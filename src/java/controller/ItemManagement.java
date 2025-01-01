package controller;

import model.ItemPerpustakaan;
import model.Buku;
import model.DVD;
import model.Jurnal;
import model.Majalah;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;

@WebServlet("/dashboardItem")
public class ItemManagement extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String type = request.getParameter("type");
        
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            // Jika tidak ada type, tampilkan dashboard utama dengan statistik
            if (type == null || type.isEmpty()) {
                try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM buku")) {
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) request.setAttribute("totalBuku", rs.getInt(1));
                }
                
                try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM dvd")) {
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) request.setAttribute("totalDvd", rs.getInt(1));
                }
                
                try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM jurnal")) {
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) request.setAttribute("totalJurnal", rs.getInt(1));
                }
                
                try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM majalah")) {
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) request.setAttribute("totalMajalah", rs.getInt(1));
                }
                
                try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM users")) {
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) request.setAttribute("totalUsers", rs.getInt(1));
                }
                
                try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM peminjaman")) {
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) request.setAttribute("totalPeminjaman", rs.getInt(1));
                }
                
                request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
                return;
            }

            // Jika ada type, tampilkan daftar item sesuai kategori
            List<ItemPerpustakaan> items = new ArrayList<>();
            String query = "";
            
            switch (type) {
                case "buku":
                    query = "SELECT * FROM buku";
                    break;
                case "dvd":
                    query = "SELECT * FROM dvd";
                    break;
                case "jurnal":
                    query = "SELECT * FROM jurnal";
                    break;
                case "majalah":
                    query = "SELECT * FROM majalah";
                    break;
                default:
                    throw new ServletException("Tipe item tidak valid");
            }

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    switch (type) {
                        case "buku":
                            items.add(new Buku(
                                rs.getString("judul"),
                                rs.getString("idItem"),
                                rs.getString("penulis"),
                                rs.getInt("tahunTerbit"),
                                rs.getString("gambarUrl"),
                                rs.getInt("stok")
                            ));
                            break;
                        case "dvd":
                            items.add(new DVD(
                                rs.getString("judul"),
                                rs.getString("idItem"),
                                rs.getString("sutradara"),
                                rs.getInt("durasi"),
                                rs.getString("gambarUrl"),
                                rs.getInt("stok")
                            ));
                            break;
                        case "jurnal":
                            items.add(new Jurnal(
                                rs.getString("judul"),
                                rs.getString("idItem"),
                                rs.getString("penulis"),
                                rs.getString("bidang"),
                                rs.getString("gambarUrl"),
                                rs.getInt("stok")
                            ));
                            break;
                        case "majalah":
                            items.add(new Majalah(
                                rs.getString("judul"),
                                rs.getString("idItem"),
                                rs.getInt("edisi"),
                                rs.getString("gambarUrl"),
                                rs.getInt("stok")
                            ));
                            break;
                    }
                }
            }
            
            request.setAttribute("items", items);
            request.setAttribute("type", type);
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}

