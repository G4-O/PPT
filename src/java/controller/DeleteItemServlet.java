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
@WebServlet("/deleteItem")
public class DeleteItemServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String type = request.getParameter("type");

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String query = "";
            switch (type) {
                case "buku":
                    query = "DELETE FROM buku WHERE idItem=?";
                    break;
                case "dvd":
                    query = "DELETE FROM dvd WHERE idItem=?";
                    break;
                case "jurnal":
                    query = "DELETE FROM jurnal WHERE idItem=?";
                    break;
                case "majalah":
                    query = "DELETE FROM majalah WHERE idItem=?";
                    break;
            }

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, id);
                stmt.executeUpdate();
            }

            response.sendRedirect("dashboardItem?type=" + type);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}

