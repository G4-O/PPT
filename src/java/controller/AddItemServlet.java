/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.io.IOException;

/**
 *
 * @author HP Pavilion
 */
@WebServlet("/addItem")
public class AddItemServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String judul = request.getParameter("judul");
        String gambarUrl = request.getParameter("gambarUrl");
        int stok = Integer.parseInt(request.getParameter("stok"));

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String query = "";
            switch (type) {
                case "buku":
                    query = "INSERT INTO buku (judul, penulis, tahunTerbit, gambarUrl, stok) VALUES (?, ?, ?, ?, ?)";
                    break;
                case "dvd":
                    // Query for DVD
                    break;
                case "jurnal":
                    // Query for Jurnal
                    break;
                case "majalah":
                    // Query for Majalah
                    break;
            }

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, judul);
                stmt.setString(2, request.getParameter("penulis")); // Example for Buku
                stmt.setInt(3, Integer.parseInt(request.getParameter("tahunTerbit")));
                stmt.setString(4, gambarUrl);
                stmt.setInt(5, stok);
                stmt.executeUpdate();
            }

            response.sendRedirect("dashboardItem?type=" + type);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}

