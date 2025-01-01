package controller;

import model.AnggotaKaryawan;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/loginAnggotaKaryawan")
public class LoginAnggotaKaryawan extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validasi input tidak kosong
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Username dan password tidak boleh kosong.");
            request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
            return; // Hentikan eksekusi jika input tidak valid
        }

        // Gunakan model AnggotaKaryawan untuk autentikasi
        AnggotaKaryawan anggota = new AnggotaKaryawan(username, password);

        try {
            if (anggota.authenticate()) {
                // Autentikasi berhasil
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", anggota.getUsername());
                session.setAttribute("isLoggedIn", true);
                session.setAttribute("idAnggota", anggota.getIdAnggota());
                session.setAttribute("namaUser", anggota.getNama());

                response.sendRedirect("dashboard.jsp"); // Redirect ke dashboard
            } else {
                // Autentikasi gagal
                request.setAttribute("errorMessage", "Username atau password salah.");
                request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error ke console untuk debugging
            request.setAttribute("errorMessage", "Terjadi kesalahan pada sistem. Silakan coba lagi.");
            request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
        }
    }
}
