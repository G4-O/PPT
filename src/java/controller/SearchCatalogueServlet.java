package controller;

import model.Buku;
import model.DVD;
import model.Jurnal;
import model.Majalah;
import model.ItemPerpustakaan;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/searchCatalogue")
public class SearchCatalogueServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        String filterType = request.getParameter("filterType");

        List<ItemPerpustakaan> searchResults = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = generateSqlQuery(filterType, searchTerm);
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    statement.setString(1, "%" + searchTerm + "%");
                }

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String idItem = resultSet.getString("idItem");
                    String judul = resultSet.getString("judul");
                    String gambarUrl = resultSet.getString("gambarUrl");

                    switch (filterType) {
                        case "buku":
                            String penulisBuku = resultSet.getString("penulis");
                            int tahunTerbit = resultSet.getInt("tahunTerbit");
                            searchResults.add(new Buku(judul, idItem, penulisBuku, tahunTerbit, gambarUrl));
                            break;
                        case "dvd":
                            String sutradara = resultSet.getString("sutradara");
                            int durasi = resultSet.getInt("durasi");
                            searchResults.add(new DVD(judul, idItem, sutradara, durasi, gambarUrl));
                            break;
                        case "majalah":
                            int edisi = resultSet.getInt("edisi");
                            searchResults.add(new Majalah(judul, idItem, edisi, gambarUrl));
                            break;
                        case "jurnal":
                            String penulisJurnal = resultSet.getString("penulis");
                            String bidang = resultSet.getString("bidang");
                            searchResults.add(new Jurnal(judul, idItem, penulisJurnal, bidang, gambarUrl));
                            break;
                        default:
                            break;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("searchResults", searchResults);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }

    private String generateSqlQuery(String filterType, String searchTerm) {
        String baseQuery = "SELECT * FROM %s";
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            baseQuery += " WHERE judul LIKE ?";
        }

        switch (filterType) {
            case "buku":
                return String.format(baseQuery, "buku");
            case "dvd":
                return String.format(baseQuery, "dvd");
            case "majalah":
                return String.format(baseQuery, "majalah");
            case "jurnal":
                return String.format(baseQuery, "jurnal");
            default:
                return "SELECT * FROM buku";
        }
    }
}
