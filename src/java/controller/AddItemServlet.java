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
    
    // Tambahkan method generateId
    private String generateId(String type) {
        // Format: TIPE-TIMESTAMP
        long timestamp = System.currentTimeMillis();
        return type.toUpperCase() + "-" + timestamp;
    }

    @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String type = request.getParameter("type");
            String idItem = generateId(type); // Implement method to generate unique ID

            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
                String query = "";
                PreparedStatement stmt;

                switch (type) {
                    case "buku":
                        query = "INSERT INTO buku (idItem, judul, penulis, tahunTerbit, deskripsi, klasifikasi, publisher, bidang, gambarUrl, stok) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, idItem);
                        stmt.setString(2, request.getParameter("judul"));
                        stmt.setString(3, request.getParameter("penulis"));
                        stmt.setInt(4, Integer.parseInt(request.getParameter("tahunTerbit")));
                        stmt.setString(5, request.getParameter("deskripsi"));
                        stmt.setString(6, request.getParameter("klasifikasi"));
                        stmt.setString(7, request.getParameter("publisher"));
                        stmt.setString(8, request.getParameter("bidang"));
                        stmt.setString(9, request.getParameter("gambarUrl"));
                        stmt.setInt(10, Integer.parseInt(request.getParameter("stok")));
                        break;

                    case "dvd":
                        query = "INSERT INTO dvd (idItem, judul, sutradara, durasi, deskripsi, klasifikasi, bidang, gambarUrl, stok) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, idItem);
                        stmt.setString(2, request.getParameter("judul"));
                        stmt.setString(3, request.getParameter("sutradara"));
                        stmt.setInt(4, Integer.parseInt(request.getParameter("durasi")));
                        stmt.setString(5, request.getParameter("deskripsi"));
                        stmt.setString(6, request.getParameter("klasifikasi"));
                        stmt.setString(7, request.getParameter("bidang"));
                        stmt.setString(8, request.getParameter("gambarUrl"));
                        stmt.setInt(9, Integer.parseInt(request.getParameter("stok")));
                        break;

                    case "jurnal":
                        query = "INSERT INTO jurnal (idItem, judul, penulis, deskripsi, klasifikasi, publisher, bidang, gambarUrl, stok) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, idItem);
                        stmt.setString(2, request.getParameter("judul"));
                        stmt.setString(3, request.getParameter("penulis"));
                        stmt.setString(4, request.getParameter("deskripsi"));
                        stmt.setString(5, request.getParameter("klasifikasi"));
                        stmt.setString(6, request.getParameter("publisher"));
                        stmt.setString(7, request.getParameter("bidang"));
                        stmt.setString(8, request.getParameter("gambarUrl"));
                        stmt.setInt(9, Integer.parseInt(request.getParameter("stok")));
                        break;

                    case "majalah":
                        query = "INSERT INTO majalah (idItem, judul, edisi, penulis, deskripsi, klasifikasi, publisher, bidang, gambarUrl, stok) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, idItem);
                        stmt.setString(2, request.getParameter("judul"));
                        stmt.setInt(3, Integer.parseInt(request.getParameter("edisi")));
                        stmt.setString(4, request.getParameter("penulis"));
                        stmt.setString(5, request.getParameter("deskripsi"));
                        stmt.setString(6, request.getParameter("klasifikasi"));
                        stmt.setString(7, request.getParameter("publisher"));
                        stmt.setString(8, request.getParameter("bidang"));
                        stmt.setString(9, request.getParameter("gambarUrl"));
                        stmt.setInt(10, Integer.parseInt(request.getParameter("stok")));
                        break;

                    default:
                        throw new ServletException("Invalid type");
                }

                stmt.executeUpdate();
                response.sendRedirect("dashboardItem?type=" + type + "&success=Item berhasil ditambahkan");

            } catch (SQLException e) {
                throw new ServletException("Database error: " + e.getMessage());
            }
        }

}

