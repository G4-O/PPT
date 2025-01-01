package controller;

import model.Buku;
import model.TrendingItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrendingController {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    public List<TrendingItem> getTrendingItems() {
        List<TrendingItem> trendingItems = new ArrayList<>();

        // Query SQL untuk mendapatkan data trending items
        String query = """
            WITH TopItems AS (
                SELECT idItem, COUNT(*) as jumlah_peminjaman 
                FROM peminjaman 
                GROUP BY idItem 
                ORDER BY jumlah_peminjaman DESC 
                LIMIT 5
            )
            SELECT t.idItem, t.jumlah_peminjaman,
                COALESCE(b.judul, d.judul, j.judul, m.judul) AS judul,
                COALESCE(b.stok, d.stok, j.stok, m.stok) AS stok,
                COALESCE(b.gambar_url, d.gambar_url, j.gambar_url, m.gambar_url) AS gambar_url,
                COALESCE(b.penulis, d.sutradara, j.penulis, m.edisi) AS detail,
                CASE 
                    WHEN b.idItem IS NOT NULL THEN 'buku'
                    WHEN d.idItem IS NOT NULL THEN 'dvd'
                    WHEN j.idItem IS NOT NULL THEN 'jurnal'
                    WHEN m.idItem IS NOT NULL THEN 'majalah'
                END AS item_type
            FROM TopItems t
            LEFT JOIN buku b ON t.idItem = b.idItem
            LEFT JOIN dvd d ON t.idItem = d.idItem
            LEFT JOIN jurnal j ON t.idItem = j.idItem
            LEFT JOIN majalah m ON t.idItem = m.idItem
            """;

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                TrendingItem item = new TrendingItem(
                        rs.getString("judul"),
                        rs.getString("idItem"),
                        rs.getInt("stok"),
                        rs.getInt("jumlah_peminjaman"),
                        rs.getString("gambar_url"),
                        rs.getString("detail"),
                        rs.getString("item_type")
                );
                trendingItems.add(item);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return trendingItems;
    }
}
