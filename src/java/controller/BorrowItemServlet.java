package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/borrowItem")
public class BorrowItemServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idItem = request.getParameter("idItem");
        Integer idUser = (Integer) request.getSession().getAttribute("idUser");

        if (idUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            // Ambil detail item berdasarkan idItem
            String query = "SELECT judul, penulis, gambarUrl, deskripsi, klasifikasi, viewCount, stok, bidang FROM buku WHERE idItem = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, idItem);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("judul", rs.getString("judul"));
                    request.setAttribute("penulis", rs.getString("penulis"));
                    request.setAttribute("gambarUrl", rs.getString("gambarUrl"));
                    request.setAttribute("deskripsi", rs.getString("deskripsi"));
                    request.setAttribute("klasifikasi", rs.getString("klasifikasi"));
                    request.setAttribute("viewCount", rs.getInt("viewCount"));
                    request.setAttribute("stok", rs.getInt("stok"));
                    request.setAttribute("bidang", rs.getString("bidang"));
                }
            }

            // Ambil nama pengguna jika tersedia
            String userQuery = "SELECT nama FROM users WHERE id = ?";
            try (PreparedStatement userStmt = connection.prepareStatement(userQuery)) {
                userStmt.setInt(1, idUser);
                ResultSet rs = userStmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("nama", rs.getString("nama"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("idItem", idItem);
        request.getRequestDispatcher("borrowForm.jsp").forward(request, response);
    }
}


