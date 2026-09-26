
package com.skillswap.controller;

import com.skillswap.dao.PortfolioDAO;
import com.skillswap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/portfolio")
public class PortfolioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("loggedInUser");

        try {

            PortfolioDAO dao = new PortfolioDAO();

            int userId = user.getUserId();

            String[] userInfo =
                    dao.getUserInfo(userId);

            List<String[]> offeredSkills =
                    dao.getSkills(userId, "OFFER");

            List<String[]> wantedSkills =
                    dao.getSkills(userId, "WANT");

            int acceptedExchanges =
                    dao.getAcceptedExchanges(userId);

            int completedSessions =
                    dao.getCompletedSessions(userId);

            int joinedCircles =
                    dao.getJoinedCircles(userId);

            request.setAttribute(
                    "userInfo",
                    userInfo);

            request.setAttribute(
                    "offeredSkills",
                    offeredSkills);

            request.setAttribute(
                    "wantedSkills",
                    wantedSkills);

            request.setAttribute(
                    "acceptedExchanges",
                    acceptedExchanges);

            request.setAttribute(
                    "completedSessions",
                    completedSessions);

            request.setAttribute(
                    "joinedCircles",
                    joinedCircles);

            request.getRequestDispatcher(
                    "/portfolio.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load skill portfolio",
                    e);
        }
    }
}