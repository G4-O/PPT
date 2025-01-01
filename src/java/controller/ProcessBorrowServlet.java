package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.UUID;

@WebServlet("/processBorrow")
public class ProcessBorrowServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idItem = request.getParameter("idItem");
        String durasiPinjamStr = request.getParameter("durasiPinjam");
        String nama = request.getParameter("nama");
        Integer idUser = (Integer) request.getSession().getAttribute("idUser");

        // Validasi parameter
        if (idItem == null || durasiPinjamStr == null || nama == null) {
            request.setAttribute("success", false);
            request.setAttribute("message", "Parameter yang diperlukan tidak lengkap");
            request.getRequestDispatcher("confirmation.jsp").forward(request, response);
            return;
        }

        if (idUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection connection = null;
        try {
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
            connection.setAutoCommit(false);

            // 1. Get and update user data
            String selectUser = "SELECT nama, idAnggota FROM users WHERE id = ?";
            String currentNama = null;
            String idAnggota = null;
            
            try (PreparedStatement selectStmt = connection.prepareStatement(selectUser)) {
                selectStmt.setInt(1, idUser);
                ResultSet rs = selectStmt.executeQuery();
                if (rs.next()) {
                    currentNama = rs.getString("nama");
                    idAnggota = rs.getString("idAnggota");
                }
            }

            // Update nama dan generate idAnggota jika perlu
            if (currentNama == null || currentNama.isEmpty()) {
                if (idAnggota == null || idAnggota.isEmpty()) {
                    idAnggota = "MBR-" + UUID.randomUUID().toString().substring(0, 8);
                }
                
                String updateUser = "UPDATE users SET nama = ?, idAnggota = ? WHERE id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateUser)) {
                    updateStmt.setString(1, nama);
                    updateStmt.setString(2, idAnggota);
                    updateStmt.setInt(3, idUser);
                    updateStmt.executeUpdate();
                }
            } else if (idAnggota == null || idAnggota.isEmpty()) {
                idAnggota = "MBR-" + UUID.randomUUID().toString().substring(0, 8);
                String updateIdAnggota = "UPDATE users SET idAnggota = ? WHERE id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateIdAnggota)) {
                    updateStmt.setString(1, idAnggota);
                    updateStmt.setInt(2, idUser);
                    updateStmt.executeUpdate();
                }
            }

            // 2. Check item availability dari semua tabel
            String checkItemQuery = 
                "SELECT 'buku' as tipe, stok FROM buku WHERE idItem = ? " +
                "UNION ALL " +
                "SELECT 'dvd' as tipe, stok FROM dvd WHERE idItem = ? " +
                "UNION ALL " +
                "SELECT 'jurnal' as tipe, stok FROM jurnal WHERE idItem = ? " +
                "UNION ALL " +
                "SELECT 'majalah' as tipe, stok FROM majalah WHERE idItem = ?";

            String itemType = null;
            int stok = 0;

            try (PreparedStatement checkStmt = connection.prepareStatement(checkItemQuery)) {
                for(int i = 1; i <= 4; i++) {
                    checkStmt.setString(i, idItem);
                }
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    itemType = rs.getString("tipe");
                    stok = rs.getInt("stok");
                } else {
                    throw new SQLException("Item tidak ditemukan");
                }
                
                if (stok <= 0) {
                    throw new SQLException("Item tidak tersedia untuk dipinjam");
                }
            }

            // 3. Check overdue items
            String checkOverdueQuery = "SELECT COUNT(*) as count FROM peminjaman " +
                                     "WHERE idAnggota = ? AND tanggalKembali < UNIX_TIMESTAMP()";
            try (PreparedStatement overdueStmt = connection.prepareStatement(checkOverdueQuery)) {
                overdueStmt.setString(1, idAnggota);
                ResultSet rs = overdueStmt.executeQuery();
                if (rs.next() && rs.getInt("count") > 0) {
                    throw new SQLException("Anda memiliki peminjaman yang telah melewati batas waktu");
                }
            }

            // 4. Update stok
            String updateItemQuery = "UPDATE " + itemType + 
                                   " SET stok = stok - 1 WHERE idItem = ?";
            try (PreparedStatement updateStmt = connection.prepareStatement(updateItemQuery)) {
                updateStmt.setString(1, idItem);
                updateStmt.executeUpdate();
            }

            // 5. Create peminjaman record
            String insertPeminjaman = "INSERT INTO peminjaman (idTransaksi, idItem, idAnggota, " +
                                    "tanggalTransaksi, tanggalKembali) " +
                                    "VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement insertStmt = connection.prepareStatement(insertPeminjaman)) {
                String idTransaksi = "PJM-" + UUID.randomUUID().toString().substring(0, 8);
                long currentTime = System.currentTimeMillis() / 1000L;
                long durasiPinjam = Long.parseLong(durasiPinjamStr) * 24 * 3600;

                insertStmt.setString(1, idTransaksi);
                insertStmt.setString(2, idItem);
                insertStmt.setString(3, idAnggota);
                insertStmt.setLong(4, currentTime);
                insertStmt.setLong(5, currentTime + durasiPinjam);
                insertStmt.executeUpdate();

                request.setAttribute("idTransaksi", idTransaksi);
            }

            connection.commit();
            request.setAttribute("success", true);
            request.setAttribute("message", "Peminjaman berhasil dilakukan!");
            
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            request.setAttribute("success", false);
            request.setAttribute("message", "Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
    }
}