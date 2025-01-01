package controller;

import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/searchCatalogue")
public class SearchCatalogueServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        String filterType = request.getParameter("filterType");
        List<ItemPerpustakaan> searchResults = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            if (filterType == null || filterType.isEmpty()) {
                searchResults.addAll(searchAllCategories(connection, searchTerm));
            } else {
                String sql = generateSqlQuery(filterType, searchTerm);
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                        statement.setString(1, "%" + searchTerm + "%");
                    }
                    searchResults.addAll(executeSearch(statement, filterType));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("searchResults", searchResults);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }

    private List<ItemPerpustakaan> searchAllCategories(Connection connection, String searchTerm) 
            throws SQLException {
        List<ItemPerpustakaan> results = new ArrayList<>();
        String[] tables = {"buku", "dvd", "majalah", "jurnal"};
        
        for (String table : tables) {
            StringBuilder sql = new StringBuilder("SELECT idItem, judul, gambarUrl, stok");
            
            switch (table) {
                case "buku":
                    sql.append(", penulis, tahunTerbit");
                    break;
                case "dvd":
                    sql.append(", sutradara, durasi");
                    break;
                case "majalah":
                    sql.append(", edisi");
                    break;
                case "jurnal":
                    sql.append(", penulis, bidang");
                    break;
            }
            
            sql.append(" FROM ").append(table);
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                sql.append(" WHERE judul LIKE ?");
            }
            
            try (PreparedStatement statement = connection.prepareStatement(sql.toString())) {
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    statement.setString(1, "%" + searchTerm + "%");
                }
                System.out.println("Executing query: " + sql.toString()); // Debug
                results.addAll(executeSearch(statement, table));
            }
        }
        return results;
    }

    private List<ItemPerpustakaan> executeSearch(PreparedStatement statement, String filterType) 
            throws SQLException {
        List<ItemPerpustakaan> searchResults = new ArrayList<>();
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            String idItem = resultSet.getString("idItem");
            String judul = resultSet.getString("judul");
            String gambarUrl = resultSet.getString("gambarUrl");
            int stok = resultSet.getInt("stok");
            
            System.out.println("Debug - Item: " + judul + ", Stok: " + stok); // Debug

            switch (filterType) {
                case "buku":
                    String penulisBuku = resultSet.getString("penulis");
                    int tahunTerbit = resultSet.getInt("tahunTerbit");
                    searchResults.add(new Buku(judul, idItem, penulisBuku, tahunTerbit, gambarUrl, stok));
                    break;
                case "dvd":
                    String sutradara = resultSet.getString("sutradara");
                    int durasi = resultSet.getInt("durasi");
                    searchResults.add(new DVD(judul, idItem, sutradara, durasi, gambarUrl, stok));
                    break;
                case "majalah":
                    int edisi = resultSet.getInt("edisi");
                    searchResults.add(new Majalah(judul, idItem, edisi, gambarUrl, stok));
                    break;
                case "jurnal":
                    String penulisJurnal = resultSet.getString("penulis");
                    String bidang = resultSet.getString("bidang");
                    searchResults.add(new Jurnal(judul, idItem, penulisJurnal, bidang, gambarUrl, stok));
                    break;
            }
        }
        return searchResults;
    }

    private String generateSqlQuery(String filterType, String searchTerm) {
        StringBuilder sql = new StringBuilder("SELECT idItem, judul, gambarUrl, stok");
        
        switch (filterType) {
            case "buku":
                sql.append(", penulis, tahunTerbit FROM buku");
                break;
            case "dvd":
                sql.append(", sutradara, durasi FROM dvd");
                break;
            case "majalah":
                sql.append(", edisi FROM majalah");
                break;
            case "jurnal":
                sql.append(", penulis, bidang FROM jurnal");
                break;
            default:
                return "";
        }
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql.append(" WHERE judul LIKE ?");
        }
        
        return sql.toString();
    }
}
