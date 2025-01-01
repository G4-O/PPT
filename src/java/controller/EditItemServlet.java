/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

/**
 *
 * @author HP Pavilion
 */

@WebServlet("/editItem")
public class EditItemServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idItem = request.getParameter("id");
        String type = request.getParameter("type");

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
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    ItemPerpustakaan item;

                    switch (type) {
                        case "buku":
                            item = new Buku(rs.getString("judul"), rs.getString("idItem"), rs.getString("penulis"),
                                    rs.getInt("tahunTerbit"), rs.getString("gambarUrl"), rs.getInt("stok"));
                            break;

                        case "dvd":
                            // Create DVD object
                            break;

                        case "jurnal":
                            // Create Jurnal object
                            break;

                        case "majalah":
                            // Create Majalah object
                            break;

                        default:
                            throw new IllegalArgumentException("Invalid type");
                    }

                    request.setAttribute("item", item);
                }
            }

            request.setAttribute("type", type);
            request.getRequestDispatcher("/editItemForm.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
