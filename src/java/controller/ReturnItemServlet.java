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
import java.util.List;
import java.util.ArrayList;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.io.IOException;

/**
 *
 * @author HP Pavilion
 */
@WebServlet("/returnItem")
public class ReturnItemServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idTransaksi = request.getParameter("id");
        String idItem = request.getParameter("idItem");
        String status = request.getParameter("status");
        
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            conn.setAutoCommit(false);
            try {
                // Update stok
                String updateQuery = "UPDATE buku SET stok = stok + 1 WHERE idItem = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, idItem);
                updateStmt.executeUpdate();
                
                // Hapus peminjaman
                String deleteQuery = "DELETE FROM peminjaman WHERE idTransaksi = ?";
                PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
                deleteStmt.setString(1, idTransaksi);
                deleteStmt.executeUpdate();
                
                conn.commit();
                response.sendRedirect("borrowManagement?status=" + status + "&success=Item berhasil dikembalikan");
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage());
        }
    }
}
