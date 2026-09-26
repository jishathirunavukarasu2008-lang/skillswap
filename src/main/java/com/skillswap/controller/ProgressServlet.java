package com.skillswap.controller;

import com.skillswap.dao.ProgressDAO;
import com.skillswap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/progress")
public class ProgressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Check login
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

            ProgressDAO dao = new ProgressDAO();

            int acceptedExchanges =
                    dao.getAcceptedExchanges(
                            user.getUserId());

            int scheduledSessions =
                    dao.getScheduledSessions(
                            user.getUserId());

            int completedSessions =
                    dao.getCompletedSessions(
                            user.getUserId());

            int joinedCircles =
                    dao.getJoinedCircles(
                            user.getUserId());

            int totalSessions =
                    dao.getTotalSessions(
                            user.getUserId());

            // Calculate progress percentage
            int progress = 0;

            if (totalSessions > 0) {

                progress =
                        (completedSessions * 100)
                        / totalSessions;
            }

            // Send values to JSP
            request.setAttribute(
                    "acceptedExchanges",
                    acceptedExchanges);

            request.setAttribute(
                    "scheduledSessions",
                    scheduledSessions);

            request.setAttribute(
                    "completedSessions",
                    completedSessions);

            request.setAttribute(
                    "joinedCircles",
                    joinedCircles);

            request.setAttribute(
                    "totalSessions",
                    totalSessions);

            request.setAttribute(
                    "progress",
                    progress);

            // Open progress page
            request.getRequestDispatcher(
                    "/progress.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load learning progress",
                    e);
        }
    }
}