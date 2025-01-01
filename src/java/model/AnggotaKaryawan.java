package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AnggotaKaryawan {
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private int idAnggota;
    private String username;
    private String email;
    private String password;
    private String nama;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root"; // Ganti dengan username database Anda
    private static final String JDBC_PASSWORD = ""; // Ganti dengan password database Anda

    // Constructor kosong
    public AnggotaKaryawan() {}

    // Constructor penuh
    public AnggotaKaryawan(int idAnggota, String username, String email, String password, String nama) {
        this.idAnggota = idAnggota;
        this.username = username;
        this.email = email;
        this.password = password;
        this.nama = nama;
    }

    // Constructor untuk autentikasi login
    public AnggotaKaryawan(String username, String password) {
        this.username = username;
        this.password = password;
    }

    // Getters dan Setters
    public int getIdAnggota() {
        return idAnggota;
    }

    public void setIdAnggota(int idAnggota) {
        this.idAnggota = idAnggota;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    // Method untuk autentikasi login
    public boolean authenticate() throws SQLException {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            String sql = "SELECT * FROM anggota_karyawan WHERE username = ? AND password = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);

                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    this.idAnggota = resultSet.getInt("id");
                    this.nama = resultSet.getString("nama");
                    this.email = resultSet.getString("email");
                    return true; // Login berhasil
                }
                return false; // Login gagal
            }
        }
    }
}
