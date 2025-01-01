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
import java.sql.ResultSet;
import java.util.Map;
import java.util.HashMap;
import java.util.Date;


/**
 *
 * @author HP Pavilion
 */
@WebServlet("/borrowManagement")
public class BorrowManagement extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String status = request.getParameter("status");
        // Ubah ke detik karena timestamp disimpan dalam detik
        long currentTime = System.currentTimeMillis() / 1000L;
        
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String query = "";
            if ("active".equals(status)) {
                query = "SELECT p.*, COALESCE(b.judul, d.judul, j.judul, m.judul) as judul " +
                        "FROM peminjaman p " +
                        "LEFT JOIN buku b ON p.idItem = b.idItem " +
                        "LEFT JOIN dvd d ON p.idItem = d.idItem " +
                        "LEFT JOIN jurnal j ON p.idItem = j.idItem " +
                        "LEFT JOIN majalah m ON p.idItem = m.idItem " +
                        "WHERE p.tanggalKembali >= ?";
            } else if ("overdue".equals(status)) {
                query = "SELECT p.*, COALESCE(b.judul, d.judul, j.judul, m.judul) as judul " +
                        "FROM peminjaman p " +
                        "LEFT JOIN buku b ON p.idItem = b.idItem " +
                        "LEFT JOIN dvd d ON p.idItem = d.idItem " +
                        "LEFT JOIN jurnal j ON p.idItem = j.idItem " +
                        "LEFT JOIN majalah m ON p.idItem = m.idItem " +
                        "WHERE p.tanggalKembali < ?";
            }
            
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setLong(1, currentTime);
            ResultSet rs = stmt.executeQuery();
            
            List<Map<String, Object>> borrowList = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> borrow = new HashMap<>();
                borrow.put("idTransaksi", rs.getString("idTransaksi"));
                borrow.put("idItem", rs.getString("idItem"));
                borrow.put("judul", rs.getString("judul"));
                borrow.put("idAnggota", rs.getString("idAnggota"));
                
                // Kalikan dengan 1000 untuk konversi ke milliseconds untuk Date
                long tanggalTransaksi = rs.getLong("tanggalTransaksi") * 1000L;
                long tanggalKembali = rs.getLong("tanggalKembali") * 1000L;
                
                borrow.put("tanggalTransaksi", new Date(tanggalTransaksi));
                borrow.put("tanggalKembali", new Date(tanggalKembali));
                
                if ("overdue".equals(status)) {
                    // Hitung selisih dalam detik karena timestamp dalam detik
                    long diffInSeconds = currentTime - rs.getLong("tanggalKembali");
                    long diffInHours = diffInSeconds / 3600;
                    long days = diffInHours / 24;
                    long hours = diffInHours % 24;
                    
                    String keterlambatan = String.format("%d hari %d jam", days, hours);
                    long denda = diffInHours * 1000; // Rp 1000 per jam
                    
                    borrow.put("keterlambatan", keterlambatan);
                    borrow.put("denda", denda);
                }
                
                borrowList.add(borrow);
            }
            
            request.setAttribute("borrowList", borrowList);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/borrowManagement.jsp").forward(request, response);
            
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage());
        }
    }
}
