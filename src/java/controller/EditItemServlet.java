package controller;

import model.ItemPerpustakaan;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/editItem")
public class EditItemServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idItem = request.getParameter("id");
        String type = request.getParameter("type");
        
        System.out.println("Processing edit request - ID: " + idItem + ", Type: " + type);
        
        if (idItem == null || type == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parameter 'id' atau 'type' tidak ditemukan.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String query = "";
            switch (type) {
                case "buku":
                    query = "SELECT * FROM buku WHERE idItem = ?";
                    break;
                case "dvd":
                    query = "SELECT * FROM dvd WHERE idItem = ?";
                    break;
                case "jurnal":
                    query = "SELECT * FROM jurnal WHERE idItem = ?";
                    break;
                case "majalah":
                    query = "SELECT * FROM majalah WHERE idItem = ?";
                    break;
                default:
                    throw new IllegalArgumentException("Invalid type");
            }

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, idItem);
                System.out.println("Executing query: " + query + " with ID: " + idItem);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    ItemPerpustakaan item;
                    switch (type) {
                        case "buku":                            

                            item = new Buku(rs.getString("judul"), rs.getString("idItem"), rs.getString("penulis"),
                                    rs.getInt("tahunTerbit"), rs.getString("gambarUrl"), rs.getInt("stok"));
                            request.setAttribute("item", item);
                            break;
                        case "dvd":
                            item = new DVD(
                                rs.getString("judul"),
                                rs.getString("idItem"),
                                rs.getString("sutradara"),
                                rs.getInt("durasi"),
                                rs.getString("gambarUrl"),
                                rs.getInt("stok")
                            );
                            break;
                        case "jurnal":
                            item = new Jurnal(
                                rs.getString("judul"),
                                rs.getString("idItem"),
                                rs.getString("penulis"),
                                rs.getString("bidang"),
                                rs.getString("gambarUrl"),
                                rs.getInt("stok")
                            );
                            break;
                        case "majalah":
                            item = new Majalah(
                                rs.getString("judul"),
                                rs.getString("idItem"),
                                rs.getInt("edisi"),
                                rs.getString("gambarUrl"),
                                rs.getInt("stok")
                            );
                            break;
                        default:
                            throw new IllegalArgumentException("Invalid type");
                    }            
                    request.setAttribute("item", item);
                    request.setAttribute("type", type);
                    request.getRequestDispatcher("/editItemForm.jsp").forward(request, response);
                } else {
                    response.sendRedirect("dashboardItem?type=" + type + "&error=Data tidak ditemukan");
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}
