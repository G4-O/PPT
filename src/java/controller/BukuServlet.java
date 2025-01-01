package controller;

import model.*;

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
@WebServlet(name = "CatalogueServlet", urlPatterns = {"/catalogue"})
public class BukuServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<ItemPerpustakaan> itemList = new ArrayList<>();
        List<Peminjaman> peminjamanList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            // Query untuk mengambil semua item dari berbagai tabel
            String sqlItems = 
                "SELECT 'buku' as tipe, idItem, judul, penulis as creator, tahunTerbit as info1, null as info2, gambarUrl, stok FROM buku " +
                "UNION ALL " +
                "SELECT 'dvd' as tipe, idItem, judul, sutradara as creator, durasi as info1, null as info2, gambarUrl, stok FROM dvd " +
                "UNION ALL " +
                "SELECT 'jurnal' as tipe, idItem, judul, penulis as creator, bidang as info1, null as info2, gambarUrl, stok FROM jurnal " +
                "UNION ALL " +
                "SELECT 'majalah' as tipe, idItem, judul, null as creator, edisi as info1, null as info2, gambarUrl, stok FROM majalah";

            try (Statement statement = connection.createStatement()) {
                ResultSet resultSet = statement.executeQuery(sqlItems);
                while (resultSet.next()) {
                    String tipe = resultSet.getString("tipe");
                    String idItem = resultSet.getString("idItem");
                    String judul = resultSet.getString("judul");
                    String creator = resultSet.getString("creator");
                    String info1 = resultSet.getString("info1");
                    String gambarUrl = resultSet.getString("gambarUrl");
                    int stok = resultSet.getInt("stok");

                    switch(tipe) {
                        case "buku":
                            itemList.add(new Buku(judul, idItem, creator, 
                                Integer.parseInt(info1), gambarUrl, stok));
                            break;
                        case "dvd":
                            itemList.add(new DVD(judul, idItem, creator, 
                                Integer.parseInt(info1), gambarUrl, stok));
                            break;
                        case "jurnal":
                            itemList.add(new Jurnal(judul, idItem, creator, 
                                info1, gambarUrl, stok));
                            break;
                        case "majalah":
                            itemList.add(new Majalah(judul, idItem, 
                                Integer.parseInt(info1), gambarUrl, stok));
                            break;
                    }
                }
            }

            // Get active loans
            String sqlPeminjaman = "SELECT * FROM peminjaman WHERE tanggalKembali > ?";
            try (PreparedStatement pstmt = connection.prepareStatement(sqlPeminjaman)) {
                long currentTime = System.currentTimeMillis() / 1000L;
                pstmt.setLong(1, currentTime);
                ResultSet resultSet = pstmt.executeQuery();
                
                while (resultSet.next()) {
                    String idTransaksi = resultSet.getString("idTransaksi");
                    String idItem = resultSet.getString("idItem");
                    String userId = resultSet.getString("idAnggota");
                    long tanggalPinjam = resultSet.getLong("tanggalTransaksi");
                    long tanggalKembali = resultSet.getLong("tanggalKembali");

                    // Find corresponding item
                    for (ItemPerpustakaan item : itemList) {
                        if (item.getIdItem().equals(idItem)) {
                            User user = new User(userId, "");
                            peminjamanList.add(new Peminjaman(idTransaksi, item, user, 
                                tanggalPinjam, tanggalKembali));
                            break;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("itemList", itemList);
        request.setAttribute("peminjamanList", peminjamanList);
        request.getRequestDispatcher("catalogue.jsp").forward(request, response);
    }
}
