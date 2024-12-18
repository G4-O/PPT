<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    // Ambil data dari form
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Variabel untuk validasi
    boolean loginSuccess = false;

    try {
        // Hubungkan ke database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/perpustakaan_db", "root", "password");

        // Query untuk memverifikasi login
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            // Jika login berhasil
            loginSuccess = true;

            // Simpan username ke session
            session.setAttribute("username", username);

            // Redirect ke halaman utama
            response.sendRedirect("index.jsp");
        } else {
            // Jika login gagal
            out.println("<script>alert('Invalid username or password!'); window.location='login.jsp';</script>");
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
