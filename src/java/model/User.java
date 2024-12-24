package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;



public class User {
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    private String username;
    private String nama;
    private String email;
    private String password;
    private int idUser;  // Tambahkan properti idUser


    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root"; // Ganti dengan username database Anda
    private static final String JDBC_PASSWORD = ""; // Ganti dengan password database Anda

    // Constructors
    public User() {}

    public User(String username, String nama, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public int getIdUser() {
        return idUser;
    }

    // Method to save new user to the database (signup)
    public boolean save() {
    try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
        // Cek apakah username atau email sudah ada
        String checkSql = "SELECT COUNT(*) FROM users WHERE username = ? OR email = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setString(1, username);
            checkStmt.setString(2, email);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // Username atau email sudah ada
            }
        }

        // Jika belum ada, lakukan insert
        String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, password);

            int row = preparedStatement.executeUpdate();
            return row > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    // Method to authenticate existing user (login)
    public boolean authenticate() {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);

                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    this.idUser = resultSet.getInt("id");  // Ambil idUser setelah autentikasi
                    return true;
                }
                return resultSet.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    public void pinjamItem(ItemPerpustakaan item, long durasiPinjam, List<Peminjaman> peminjamanList) {
        long unixTime = System.currentTimeMillis() / 1000L;
        if (item.isAvailable(peminjamanList)) {
            item.pinjamItem(peminjamanList, this, unixTime + durasiPinjam);
            System.out.println(nama + " meminjam " + item.judul + " selama " + (durasiPinjam / (3600 * 24)) + " hari");
        } else {
            System.out.println("Item tidak tersedia.");
        }
    }

    public void kembalikanItem(ItemPerpustakaan item, List<Peminjaman> peminjamanList) {
        item.batalkanPeminjaman(item.idItem, peminjamanList);
        System.out.println(nama + " mengembalikan " + item.judul);
    }

    public void tampilkanInfo() {
        System.out.println("email: " + this.email);
        System.out.println("Nama: " + this.nama);
    }
}
