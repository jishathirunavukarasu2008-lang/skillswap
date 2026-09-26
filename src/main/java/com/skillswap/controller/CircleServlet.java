package com.skillswap.controller;

import com.skillswap.dao.CircleDAO;
import com.skillswap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/circles")
public class CircleServlet extends HttpServlet {

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

            CircleDAO dao = new CircleDAO();

            List<String[]> allCircles =
                    dao.getAllCircles();

            List<String[]> myCircles =
                    dao.getMyCircles(user.getUserId());

            request.setAttribute(
                    "allCircles",
                    allCircles);

            request.setAttribute(
                    "myCircles",
                    myCircles);

            request.getRequestDispatcher(
                    "/circles.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load circles",
                    e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("loggedInUser");

        String action =
                request.getParameter("action");

        try {

            CircleDAO dao =
                    new CircleDAO();


            // =================================================
            // CREATE CIRCLE
            // =================================================

            if ("CREATE".equals(action)) {

                String circleName =
                        request.getParameter("circleName");

                String description =
                        request.getParameter("description");

                if (circleName == null ||
                    circleName.trim().isEmpty()) {

                    response.sendRedirect(
                            "circles?error=invalid");

                    return;
                }

                if (description == null) {
                    description = "";
                }

                boolean created =
                        dao.createCircle(
                                circleName.trim(),
                                description.trim(),
                                user.getUserId());

                if (created) {

                    response.sendRedirect(
                            "circles?success=created");

                } else {

                    response.sendRedirect(
                            "circles?error=1");
                }

                return;
            }


            // =================================================
            // JOIN CIRCLE
            // =================================================

            if ("JOIN".equals(action)) {

                String circleIdParameter =
                        request.getParameter("circleId");

                if (circleIdParameter == null ||
                    circleIdParameter.trim().isEmpty()) {

                    response.sendRedirect(
                            "circles?error=invalid");

                    return;
                }

                int circleId =
                        Integer.parseInt(
                                circleIdParameter);

                boolean joined =
                        dao.joinCircle(
                                circleId,
                                user.getUserId());

                if (joined) {

                    response.sendRedirect(
                            "circles?success=joined");

                } else {

                    response.sendRedirect(
                            "circles?error=alreadyjoined");
                }

                return;
            }


            response.sendRedirect("circles");

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "circles?error=invalid");

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to process circle request",
                    e);
        }
    }
}