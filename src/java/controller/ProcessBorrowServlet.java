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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer idUserObj = (Integer) request.getSession().getAttribute("idUser");
        String nama = null;
        String idAnggota = null;

        if (idUserObj != null) {
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
                String selectUser = "SELECT nama, idAnggota FROM users WHERE id = ?";
                try (PreparedStatement selectStmt = connection.prepareStatement(selectUser)) {
                    selectStmt.setInt(1, idUserObj);
                    ResultSet rs = selectStmt.executeQuery();

                    if (rs.next()) {
                        nama = rs.getString("nama");
                        idAnggota = rs.getString("idAnggota");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("nama", nama);
        request.setAttribute("idAnggota", idAnggota);
        request.getRequestDispatcher("borrowForm.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idItem = request.getParameter("idItem");
        String durasiPinjamStr = request.getParameter("durasiPinjam");
        Integer idUserObj = (Integer) request.getSession().getAttribute("idUser");
        String nama = request.getParameter("nama");

        if (idUserObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (idItem == null || durasiPinjamStr == null || nama == null || nama.trim().isEmpty()) {
            request.setAttribute("message", "Please provide all required information.");
            request.getRequestDispatcher("borrowForm.jsp").forward(request, response);
            return;
        }

        long durasiPinjam;
        try {
            durasiPinjam = Long.parseLong(durasiPinjamStr) * 24 * 3600; // Convert days to seconds
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid duration format.");
            request.getRequestDispatcher("borrowForm.jsp").forward(request, response);
            return;
        }

        long unixTime = System.currentTimeMillis() / 1000L;
        String idTransaksi = UUID.randomUUID().toString();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            connection.setAutoCommit(false); // Start transaction

            String selectUser = "SELECT nama, idAnggota FROM users WHERE id = ?";
            String currentNama = null;
            String currentIdAnggota = null;
            try (PreparedStatement selectStmt = connection.prepareStatement(selectUser)) {
                selectStmt.setInt(1, idUserObj);
                ResultSet rs = selectStmt.executeQuery();
                if (rs.next()) {
                    currentNama = rs.getString("nama");
                    currentIdAnggota = rs.getString("idAnggota");
                }
            }

            // Update `nama` and generate `idAnggota` if necessary
            if (currentNama == null || currentNama.isEmpty()) {
                if (currentIdAnggota == null || currentIdAnggota.isEmpty()) {
                    currentIdAnggota = UUID.randomUUID().toString();
                }
                String updateUser = "UPDATE users SET nama = ?, idAnggota = ? WHERE id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateUser)) {
                    updateStmt.setString(1, nama);
                    updateStmt.setString(2, currentIdAnggota);
                    updateStmt.setInt(3, idUserObj);
                    updateStmt.executeUpdate();
                }
            }

            // Insert peminjaman record
            String insertPeminjaman = "INSERT INTO peminjaman (idTransaksi, idItem, idAnggota, tanggalTransaksi, tanggalKembali) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement insertStmt = connection.prepareStatement(insertPeminjaman)) {
                insertStmt.setString(1, idTransaksi);
                insertStmt.setString(2, idItem);
                insertStmt.setString(3, currentIdAnggota);
                insertStmt.setLong(4, unixTime);
                insertStmt.setLong(5, unixTime + durasiPinjam);
                insertStmt.executeUpdate();
            }

            connection.commit(); // Commit transaction

            request.setAttribute("message", "Item borrowed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing your request. Error: " + e.getMessage());
        }

        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
    }
}



