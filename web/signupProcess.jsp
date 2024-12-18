<%@ page import="java.sql.*" %>
<%
    // Ambil data yang dikirim dari form
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");

    if (password.equals(confirmPassword)) {
        String jdbcURL = "jdbc:mysql://localhost:3306/perpustakaan_db";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // SQL Query untuk memasukkan data ke tabel pengguna
            String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, password);

            int row = preparedStatement.executeUpdate();

            if (row > 0) {
                out.println("User registered successfully!");
                // Redirect ke halaman login atau halaman lain
                response.sendRedirect("login.jsp");
            } else {
                out.println("Error registering user.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.println("Passwords do not match.");
    }
%>
