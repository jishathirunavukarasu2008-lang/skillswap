package com.skillswap.controller;

import com.skillswap.dao.RecommendationDAO;
import com.skillswap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/recommendations")
public class RecommendationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether user is logged in
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user
        User user =
                (User) session.getAttribute("loggedInUser");

        try {

            RecommendationDAO dao =
                    new RecommendationDAO();

            // Get recommended partners
            List<String[]> recommendations =
                    dao.getRecommendations(
                            user.getUserId());

            // Send recommendations to JSP
            request.setAttribute(
                    "recommendations",
                    recommendations);

            // Open recommendation page
            request.getRequestDispatcher(
                    "/recommendations.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load recommendations",
                    e);
        }
    }
}