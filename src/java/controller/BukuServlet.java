package controller;

import model.Buku;
import model.User;
import model.Peminjaman;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// BukuServlet.java
@WebServlet(name = "BukuServlet", urlPatterns = {"/catalogue"})
public class BukuServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Buku> bukuList = new ArrayList<>();
        List<Peminjaman> peminjamanList = new ArrayList<>();
        
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            // Get books
            String sqlBuku = "SELECT idItem, judul, penulis, tahunTerbit, gambarUrl, stok FROM buku LIMIT 10";
            try (Statement statement = connection.createStatement()) {
                ResultSet resultSet = statement.executeQuery(sqlBuku);
                while (resultSet.next()) {
                    String idItem = resultSet.getString("idItem");
                    String judul = resultSet.getString("judul");
                    String penulis = resultSet.getString("penulis");
                    int tahunTerbit = resultSet.getInt("tahunTerbit");
                    String gambarUrl = resultSet.getString("gambarUrl");
                    int stok = resultSet.getInt("stok");
                    bukuList.add(new Buku(judul, idItem, penulis, tahunTerbit, gambarUrl, stok));
                }
            }

            
            // Get active loans
            String sqlPeminjaman = "SELECT * FROM peminjaman WHERE tanggalKembali > ?";
            try (PreparedStatement pstmt = connection.prepareStatement(sqlPeminjaman)) {
                long currentTime = System.currentTimeMillis() / 1000L;
                pstmt.setLong(1, currentTime);
                ResultSet resultSet = pstmt.executeQuery();
                while (resultSet.next()) {
                    // Sesuaikan dengan struktur tabel peminjaman Anda
                    String idTransaksi = resultSet.getString("idTransaksi");
                    String idItem = resultSet.getString("idItem");
                    String userId = resultSet.getString("userId");
                    long tanggalPinjam = resultSet.getLong("tanggalPinjam");
                    long tanggalKembali = resultSet.getLong("tanggalKembali");
                    
                    // Find the corresponding book
                    for (Buku buku : bukuList) {
                        if (buku.getIdItem().equals(idItem)) {
                            // Create User object (implement according to your User class)
                            User user = new User(userId, ""); // Add other user details as needed
                            peminjamanList.add(new Peminjaman(idTransaksi, buku, user, tanggalPinjam, tanggalKembali));
                            break;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("bukuList", bukuList);
        request.setAttribute("peminjamanList", peminjamanList);
        request.getRequestDispatcher("catalogue.jsp").forward(request, response);
    }
}
