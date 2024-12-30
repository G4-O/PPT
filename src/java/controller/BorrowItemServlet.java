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
        String itemType = request.getParameter("itemType");
        Integer idUser = (Integer) request.getSession().getAttribute("idUser");

        if (idUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String itemQuery = getItemQuery(itemType);
            if (itemQuery != null) {
                try (PreparedStatement itemStmt = connection.prepareStatement(itemQuery)) {
                    itemStmt.setString(1, idItem);
                    ResultSet itemRs = itemStmt.executeQuery();

                    if (itemRs.next()) {
                        request.setAttribute("judul", itemRs.getString("judul"));
                        request.setAttribute("penulis", itemRs.getString("penulis"));
                        request.setAttribute("gambarUrl", itemRs.getString("gambarUrl"));
                    }
                }
            }

            String query = "SELECT nama, idAnggota FROM users WHERE idUser = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setInt(1, idUser);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String nama = rs.getString("nama");
                    String idAnggota = rs.getString("idAnggota");
                    request.setAttribute("nama", nama);
                    request.setAttribute("idAnggota", idAnggota);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("idItem", idItem);
        request.getRequestDispatcher("borrowForm.jsp").forward(request, response);
    }

    private String getItemQuery(String itemType) {
        switch (itemType.toLowerCase()) {
            case "buku":
                return "SELECT judul, penulis, gambarUrl FROM buku WHERE idItem = ?";
            case "majalah":
                return "SELECT judul, edisi, gambarUrl FROM majalah WHERE idItem = ?";
            case "dvd":
                return "SELECT judul, sutradara, gambarUrl FROM dvd WHERE idItem = ?";
            case "jurnal":
                return "SELECT judul, penulis, gambarUrl FROM jurnal WHERE idItem = ?";
            default:
                return null;
        }
    }
}

