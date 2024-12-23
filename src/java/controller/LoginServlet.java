// LoginServlet.java
package controller;

import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(username, password);
        if (user.authenticate()) {
            // Simpan data user ke session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", username);
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("idUser", user.getIdUser()); // Simpan sebagai Integer
            
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
