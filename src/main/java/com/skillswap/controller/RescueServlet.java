package com.skillswap.controller;

import com.skillswap.dao.RescueDAO;
import com.skillswap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/rescue")
public class RescueServlet extends HttpServlet {

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

            RescueDAO dao = new RescueDAO();

            List<String[]> exchanges =
                    dao.getMyAcceptedExchanges(user.getUserId());

            List<String[]> rescueRequests =
                    dao.getMyRescueRequests(user.getUserId());

            request.setAttribute(
                    "acceptedExchanges",
                    exchanges
            );

            request.setAttribute(
                    "rescueRequests",
                    rescueRequests
            );

            request.getRequestDispatcher(
                    "/rescue.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load rescue page",
                    e
            );
        }
    }


    @Override
    protected void doPost(HttpServletRequest request,
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

            int exchangeId =
                    Integer.parseInt(
                            request.getParameter("exchangeId")
                    );

            String reason =
                    request.getParameter("reason");

            if (reason == null ||
                    reason.trim().isEmpty()) {

                response.sendRedirect(
                        "rescue?error=empty"
                );

                return;
            }

            RescueDAO dao = new RescueDAO();

            boolean success =
                    dao.createRescue(
                            exchangeId,
                            user.getUserId(),
                            reason.trim()
                    );

            if (success) {

                response.sendRedirect(
                        "rescue?success=1"
                );

            } else {

                response.sendRedirect(
                        "rescue?error=1"
                );
            }

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to create rescue request",
                    e
            );
        }
    }
}