package controller;

import model.BorrowedItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.Instant;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/mybooks")
public class MyBooksServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Integer idUser = (Integer) request.getSession().getAttribute("idUser");
        if (idUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<BorrowedItem> borrowedItems = new ArrayList<>();
        String idAnggota = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
                String userQuery = "SELECT idAnggota FROM users WHERE id = ?";
                try (PreparedStatement userStmt = connection.prepareStatement(userQuery)) {
                    userStmt.setInt(1, idUser);
                    ResultSet userRs = userStmt.executeQuery();
                    if (userRs.next()) {
                        idAnggota = userRs.getString("idAnggota");
                    }
                }

                if (idAnggota != null) {
                    String borrowQuery = "SELECT idItem, tanggalTransaksi, tanggalKembali FROM peminjaman WHERE idAnggota = ?";
                    try (PreparedStatement borrowStmt = connection.prepareStatement(borrowQuery)) {
                        borrowStmt.setString(1, idAnggota);
                        ResultSet borrowRs = borrowStmt.executeQuery();
                        
                        while (borrowRs.next()) {
                            String idItem = borrowRs.getString("idItem");
                            
                            // Konversi dari timestamp/long ke LocalDate
                            long borrowTimestamp = borrowRs.getLong("tanggalTransaksi");
                            long returnTimestamp = borrowRs.getLong("tanggalKembali");
                            
                            LocalDate borrowDate = Instant.ofEpochSecond(borrowTimestamp)
                                .atZone(ZoneId.systemDefault())
                                .toLocalDate();
                            LocalDate returnDate = Instant.ofEpochSecond(returnTimestamp)
                                .atZone(ZoneId.systemDefault())
                                .toLocalDate();

                            borrowedItems.addAll(getItemsFromTable(connection, "buku", 
                                    "judul", "penulis", idItem, "Book", borrowDate, returnDate));
                            borrowedItems.addAll(getItemsFromTable(connection, "dvd", 
                                    "judul", "sutradara", idItem, "DVD", borrowDate, returnDate));
                            borrowedItems.addAll(getItemsFromTable(connection, "majalah", 
                                    "judul", "edisi", idItem, "Magazine", borrowDate, returnDate));
                            borrowedItems.addAll(getItemsFromTable(connection, "jurnal", 
                                    "judul", "penulis", idItem, "Journal", borrowDate, returnDate));
                        }
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            throw new ServletException("JDBC Driver not found", e);
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }

        request.setAttribute("borrowedItems", borrowedItems);
        request.getRequestDispatcher("mybooks.jsp").forward(request, response);
    }

    private List<BorrowedItem> getItemsFromTable(
            Connection connection, 
            String tableName, 
            String titleColumn, 
            String authorColumn, 
            String idItem, 
            String type,
            LocalDate borrowDate,
            LocalDate returnDate) throws SQLException {
        
        List<BorrowedItem> items = new ArrayList<>();
        
        String query = String.format(
            "SELECT %s AS title, %s AS authorOrDirector, gambarUrl FROM %s WHERE idItem = ?",
            titleColumn, authorColumn, tableName);

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, idItem);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                BorrowedItem item = new BorrowedItem(
                    idItem,
                    rs.getString("title"),
                    type,
                    rs.getString("authorOrDirector"),
                    rs.getString("gambarUrl"),
                    borrowDate,
                    returnDate
                );
                items.add(item);
            }
        }
        return items;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}