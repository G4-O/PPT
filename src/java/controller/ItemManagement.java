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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        List<ItemPerpustakaan> items = new ArrayList<>();

        if (type == null || type.isEmpty()) {
            request.setAttribute("error", "Silakan pilih kategori item.");
            request.setAttribute("items", items);
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String query = "";

            switch (type) {
                case "buku":
                    query = "SELECT idItem, judul, penulis, tahunTerbit, gambarUrl, stok FROM buku";
                    break;
                case "dvd":
                    query = "SELECT idItem, judul, sutradara, durasi, gambarUrl, stok FROM dvd";
                    break;
                case "jurnal":
                    query = "SELECT idItem, judul, penulis, bidang, gambarUrl, stok FROM jurnal";
                    break;
                case "majalah":
                    query = "SELECT idItem, judul, edisi, gambarUrl, stok FROM majalah";
                    break;
                default:
                    throw new IllegalArgumentException("Invalid type");
            }

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    switch (type) {
                        case "buku":
                            items.add(new Buku(rs.getString("judul"), rs.getString("idItem"), rs.getString("penulis"),
                                    rs.getInt("tahunTerbit"), rs.getString("gambarUrl"), rs.getInt("stok")));
                            break;
                        case "dvd":
                            items.add(new DVD(rs.getString("judul"), rs.getString("idItem"), rs.getString("sutradara"),
                                    rs.getInt("durasi"), rs.getString("gambarUrl"), rs.getInt("stok")));
                            break;
                        case "jurnal":
                            items.add(new Jurnal(rs.getString("judul"), rs.getString("idItem"), rs.getString("penulis"),
                                    rs.getString("bidang"), rs.getString("gambarUrl"), rs.getInt("stok")));
                            break;
                        case "majalah":
                            items.add(new Majalah(rs.getString("judul"), rs.getString("idItem"),
                                    rs.getInt("edisi"), rs.getString("gambarUrl"), rs.getInt("stok")));
                            break;
                    }
                }
            }

            request.setAttribute("items", items);
            request.setAttribute("type", type);
            request.setAttribute("error", items.isEmpty() ? "Tidak ada data tersedia untuk kategori ini." : null);
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
