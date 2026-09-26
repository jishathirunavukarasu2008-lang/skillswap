package com.skillswap.controller;

import com.skillswap.dao.ExchangeDAO;
import com.skillswap.dao.SessionDAO;
import com.skillswap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/sessions")
public class SessionServlet extends HttpServlet {

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

            SessionDAO sessionDAO = new SessionDAO();
            ExchangeDAO exchangeDAO = new ExchangeDAO();

            List<String[]> sessions =
                    sessionDAO.getMySessions(user.getUserId());

            List<String[]> myExchanges =
                    exchangeDAO.getMyExchanges(user.getUserId());

            request.setAttribute("sessions", sessions);
            request.setAttribute("myExchanges", myExchanges);

            request.getRequestDispatcher("/sessions.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to load learning sessions", e);
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

            SessionDAO dao = new SessionDAO();

            /*
             * CREATE SESSION
             */
            if ("CREATE".equals(action)) {

                int exchangeId =
                        Integer.parseInt(
                                request.getParameter("exchangeId"));

                String scheduledDate =
                        request.getParameter("scheduledDate");

                String scheduledTime =
                        request.getParameter("scheduledTime");

                String topic =
                        request.getParameter("topic");

                int duration =
                        Integer.parseInt(
                                request.getParameter("duration"));

                if (scheduledDate == null ||
                    scheduledDate.trim().isEmpty() ||
                    scheduledTime == null ||
                    scheduledTime.trim().isEmpty() ||
                    topic == null ||
                    topic.trim().isEmpty()) {

                    response.sendRedirect(
                            "sessions?error=invalid");

                    return;
                }

                boolean created =
                        dao.createSession(
                                exchangeId,
                                scheduledDate,
                                scheduledTime,
                                topic.trim(),
                                duration);

                if (created) {

                    response.sendRedirect(
                            "sessions?success=1");

                } else {

                    response.sendRedirect(
                            "sessions?error=1");
                }

                return;
            }


            /*
             * COMPLETE SESSION
             */
            if ("COMPLETE".equals(action)) {

                int sessionId =
                        Integer.parseInt(
                                request.getParameter("sessionId"));

                boolean updated =
                        dao.updateSessionStatus(
                                sessionId,
                                user.getUserId(),
                                "COMPLETED");

                if (updated) {

                    response.sendRedirect(
                            "sessions?completed=1");

                } else {

                    response.sendRedirect(
                            "sessions?error=1");
                }

                return;
            }

            response.sendRedirect("sessions");

        } catch (Exception e) {

            throw new ServletException(
                    "Unable to process learning session",
                    e);
        }
    }
}