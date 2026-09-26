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
import java.util.List;

@WebServlet("/exchange")
public class ExchangeServlet extends HttpServlet {

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

        User user = (User) session.getAttribute("loggedInUser");

        try {

            ExchangeDAO dao = new ExchangeDAO();

            // Other students' offered skills
            List<String[]> availableSkills =
                    dao.getAvailableSkills(user.getUserId());

            // Current student's offered skills
            List<String[]> myOfferedSkills =
                    dao.getMyOfferedSkills(user.getUserId());

            request.setAttribute("availableSkills", availableSkills);
            request.setAttribute("myOfferedSkills", myOfferedSkills);

            request.getRequestDispatcher("/exchange.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load exchange skills", e);
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

        User user = (User) session.getAttribute("loggedInUser");

        try {

            int receiverId =
                    Integer.parseInt(request.getParameter("receiverId"));

            int offeredSkillId =
                    Integer.parseInt(request.getParameter("offeredSkillId"));

            int wantedSkillId =
                    Integer.parseInt(request.getParameter("wantedSkillId"));

            ExchangeDAO dao = new ExchangeDAO();

            boolean success = dao.createExchange(
                    user.getUserId(),
                    receiverId,
                    offeredSkillId,
                    wantedSkillId
            );

            if (success) {

                response.sendRedirect("exchange?success=1");

            } else {

                response.sendRedirect("exchange?error=1");
            }

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to create exchange request", e);
        }
    }
}