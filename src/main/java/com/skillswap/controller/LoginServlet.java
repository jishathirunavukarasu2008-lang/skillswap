
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
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.loginUser(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);

                response.sendRedirect("dashboard.jsp");  
            } else {
                response.sendRedirect("login.jsp?error=1");
            }

        } catch (SQLException e) {
            log("Login failed due to database error", e);
            response.sendRedirect("login.jsp?error=1");
        }
    }
}