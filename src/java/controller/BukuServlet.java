package controller;

import model.Buku;

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
@WebServlet(name = "BukuServlet", urlPatterns = {"/catalogue"})  // Lebih lengkap
public class BukuServlet extends HttpServlet {
    // Konfigurasi database
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Buku> bukuList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "SELECT idItem, judul, penulis, tahunTerbit, gambarUrl FROM buku LIMIT 10";
            try (Statement statement = connection.createStatement()) {
                ResultSet resultSet = statement.executeQuery(sql);
                while (resultSet.next()) {
                    String idItem = resultSet.getString("idItem");
                    String judul = resultSet.getString("judul");
                    String penulis = resultSet.getString("penulis");
                    int tahunTerbit = resultSet.getInt("tahunTerbit");
                    String gambarUrl = resultSet.getString("gambarUrl");

                    bukuList.add(new Buku(judul, idItem, penulis, tahunTerbit, gambarUrl));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("bukuList", bukuList); // Set atribut
        request.getRequestDispatcher("catalogue.jsp").forward(request, response); // Forward ke JSP
    }
}

