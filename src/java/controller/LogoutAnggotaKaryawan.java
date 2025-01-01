package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logoutAnggotaKaryawan")
public class LogoutAnggotaKaryawan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Ambil sesi yang ada
        if (session != null) {
            session.invalidate(); // Hapus sesi
        }
        response.sendRedirect("loginAdmin.jsp"); // Redirect ke halaman login
    }
}
