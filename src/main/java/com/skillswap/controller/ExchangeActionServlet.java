package com.skillswap.controller;

import com.skillswap.dao.ExchangeDAO;
import com.skillswap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/exchange-action")
public class ExchangeActionServlet extends HttpServlet {

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

        User user = (User) session.getAttribute("loggedInUser");

        try {

            int exchangeId =
                    Integer.parseInt(
                            request.getParameter("exchangeId"));

            String action =
                    request.getParameter("action");

            if (!"ACCEPT".equals(action) &&
                !"REJECT".equals(action)) {

                response.sendRedirect("my-exchanges?error=1");
                return;
            }

            ExchangeDAO dao = new ExchangeDAO();

            boolean updated =
                    dao.updateExchangeStatus(
                            exchangeId,
                            user.getUserId(),
                            action
                    );

            if (updated) {

                response.sendRedirect(
                        "my-exchanges?success=1");

            } else {

                response.sendRedirect(
                        "my-exchanges?error=1");
            }

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to update exchange request", e);
        }
    }
}