
package com.skillswap.controller;

import com.skillswap.dao.UserDAO;
import com.skillswap.model.User;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(fullName, username, email, password);

        UserDAO userDAO = new UserDAO();

        try {
            boolean success = userDAO.registerUser(user);

            if (success) {
                response.sendRedirect("register.jsp?success=1");
            } else {
                response.sendRedirect("register.jsp?error=1");
            }

        } catch (SQLException e) {
            log("Registration failed", e);
            response.sendRedirect("register.jsp?error=1");
        }
    }
}