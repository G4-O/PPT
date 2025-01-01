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
@WebServlet("/updateItem")
public class UpdateItemServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String type = request.getParameter("type");
        String idItem = request.getParameter("idItem");
        String judul = request.getParameter("judul");
        String gambarUrl = request.getParameter("gambarUrl");
        int stok = Integer.parseInt(request.getParameter("stok"));
        
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String query = "";
            PreparedStatement stmt;
            
            switch (type) {
                case "buku":
                    query = "UPDATE buku SET judul=?, penulis=?, tahunTerbit=?, gambarUrl=?, stok=? WHERE idItem=?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, judul);
                    stmt.setString(2, request.getParameter("penulis"));
                    stmt.setInt(3, Integer.parseInt(request.getParameter("tahunTerbit")));
                    stmt.setString(4, gambarUrl);
                    stmt.setInt(5, stok);
                    stmt.setString(6, idItem);
                    break;
                    
                case "dvd":
                    query = "UPDATE dvd SET judul=?, sutradara=?, durasi=?, gambarUrl=?, stok=? WHERE idItem=?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, judul);
                    stmt.setString(2, request.getParameter("sutradara"));
                    stmt.setInt(3, Integer.parseInt(request.getParameter("durasi")));
                    stmt.setString(4, gambarUrl);
                    stmt.setInt(5, stok);
                    stmt.setString(6, idItem);
                    break;
                    
                case "jurnal":
                    query = "UPDATE jurnal SET judul=?, penulis=?, bidang=?, gambarUrl=?, stok=? WHERE idItem=?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, judul);
                    stmt.setString(2, request.getParameter("penulis"));
                    stmt.setString(3, request.getParameter("bidang"));
                    stmt.setString(4, gambarUrl);
                    stmt.setInt(5, stok);
                    stmt.setString(6, idItem);
                    break;
                    
                case "majalah":
                    query = "UPDATE majalah SET judul=?, edisi=?, gambarUrl=?, stok=? WHERE idItem=?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, judul);
                    stmt.setInt(2, Integer.parseInt(request.getParameter("edisi")));
                    stmt.setString(3, gambarUrl);
                    stmt.setInt(4, stok);
                    stmt.setString(5, idItem);
                    break;
                    
                default:
                    throw new IllegalArgumentException("Invalid type");
            }
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.sendRedirect("dashboardItem?type=" + type + "&success=Data berhasil diupdate");
            } else {
                response.sendRedirect("dashboardItem?type=" + type + "&error=Gagal mengupdate data");
            }
            
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("dashboardItem?type=" + type + "&error=Error: " + e.getMessage());
        }
    }
}

