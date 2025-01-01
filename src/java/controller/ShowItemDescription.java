/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author umarzein
 */
@WebServlet(name = "ShowItemDescription", urlPatterns = {"/showItemDescription"})
public class ShowItemDescription extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/perpustakaan_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";


    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idItem = request.getParameter("idItem");
        Integer idUser = (Integer) request.getSession().getAttribute("idUser");

        if (idUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
            // Ambil detail item berdasarkan idItem
            String query = "SELECT judul, penulis, gambarUrl, deskripsi, klasifikasi, viewCount, stok, bidang FROM buku WHERE idItem = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, idItem);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("judul", rs.getString("judul"));
                    request.setAttribute("penulis", rs.getString("penulis"));
                    request.setAttribute("gambarUrl", rs.getString("gambarUrl"));
                    request.setAttribute("deskripsi", rs.getString("deskripsi"));
                    request.setAttribute("klasifikasi", rs.getString("klasifikasi"));
                    request.setAttribute("viewCount", rs.getInt("viewCount"));
                    request.setAttribute("stok", rs.getInt("stok"));
                    request.setAttribute("bidang", rs.getString("bidang"));
                }
            }

            // Ambil nama pengguna jika tersedia
            String userQuery = "SELECT nama FROM users WHERE id = ?";
            try (PreparedStatement userStmt = connection.prepareStatement(userQuery)) {
                userStmt.setInt(1, idUser);
                ResultSet rs = userStmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("nama", rs.getString("nama"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("idItem", idItem);
        request.getRequestDispatcher("bookDescription.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
