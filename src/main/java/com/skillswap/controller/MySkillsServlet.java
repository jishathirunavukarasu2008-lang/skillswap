
package com.skillswap.controller;

import com.skillswap.dao.SkillDAO;
import com.skillswap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-skills")
public class MySkillsServlet extends HttpServlet {

    // Display saved skills
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
            SkillDAO dao = new SkillDAO();

            List<String[]> skills =
                    dao.getUserSkills(user.getUserId());

            request.setAttribute("skillsList", skills);

            request.getRequestDispatcher("/my-skills.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                    "Unable to load your skills", e);
        }
    }

    // Add a new skill
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

        String skillName = request.getParameter("skillName");
        String skillType = request.getParameter("skillType");

        if (skillName == null || skillName.trim().isEmpty()
                || skillType == null
                || !(skillType.equals("OFFER")
                     || skillType.equals("WANT"))) {

            response.sendRedirect("my-skills?error=invalid");
            return;
        }

        try {
            SkillDAO dao = new SkillDAO();

            boolean added = dao.addSkill(
                    user.getUserId(),
                    skillName.trim(),
                    skillType
            );

            if (added) {
                response.sendRedirect("my-skills?success=1");
            } else {
                response.sendRedirect("my-skills?error=1");
            }

        } catch (Exception e) {
            throw new ServletException(
                    "Unable to save skill", e);
        }
    }
}