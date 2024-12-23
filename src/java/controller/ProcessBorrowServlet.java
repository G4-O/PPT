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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idItem = request.getParameter("idItem");
        String durasiPinjamStr = request.getParameter("durasiPinjam");
        Integer idUser = (Integer) request.getSession().getAttribute("idUser"); // Retrieve as Integer
        String nama = request.getParameter("nama");

        if (idUser == null) {
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
        String idAnggota = UUID.randomUUID().toString();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            // Check if anggota exists
            String checkUserQuery = "SELECT * FROM anggota WHERE idUser = ?";
            try (PreparedStatement checkStmt = connection.prepareStatement(checkUserQuery)) {
                checkStmt.setInt(1, idUser); // Use setInt for Integer
                ResultSet resultSet = checkStmt.executeQuery();

                if (!resultSet.next()) {
                    // Insert anggota if not exists
                    String insertAnggota = "INSERT INTO anggota (idAnggota, nama, idUser) VALUES (?, ?, ?)";
                    try (PreparedStatement insertStmt = connection.prepareStatement(insertAnggota)) {
                        insertStmt.setString(1, idAnggota);
                        insertStmt.setString(2, nama);
                        insertStmt.setInt(3, idUser); // Use setInt for Integer
                        insertStmt.executeUpdate();
                    }
                } else {
                    idAnggota = resultSet.getString("idAnggota");
                }

                // Insert peminjaman
                String idTransaksi = UUID.randomUUID().toString();
                long tanggalKembali = unixTime + durasiPinjam;

                String insertPeminjaman = "INSERT INTO peminjaman (idTransaksi, idItem, idAnggota, tanggalTransaksi, tanggalKembali) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = connection.prepareStatement(insertPeminjaman)) {
                    insertStmt.setString(1, idTransaksi);
                    insertStmt.setString(2, idItem);
                    insertStmt.setString(3, idAnggota);
                    insertStmt.setLong(4, unixTime);
                    insertStmt.setLong(5, tanggalKembali);
                    insertStmt.executeUpdate();
                }

                request.setAttribute("message", "Item borrowed successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing your request.");
        }

        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
    }
}
