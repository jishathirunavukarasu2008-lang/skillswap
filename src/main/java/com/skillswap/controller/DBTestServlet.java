package com.skillswap.controller;

import com.skillswap.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/db-test")
public class DBTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (Connection connection = DBConnection.getConnection()) {

            response.getWriter().println(
                "<h1>MySQL Connected Successfully!</h1>"
            );

            response.getWriter().println(
                "<p>SkillSwap database is connected to Java.</p>"
            );

        } catch (SQLException e) {

            log("SkillSwap database connection failed.", e);

            response.setStatus(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().println(
                "<h1>Database Connection Failed</h1>"
            );

            response.getWriter().println(
                "<p>Error: " + e.getMessage() + "</p>"
            );

            response.getWriter().println(
                "<p>Error Code: " + e.getErrorCode() + "</p>"
            );

            response.getWriter().println(
                "<p>SQL State: " + e.getSQLState() + "</p>"
            );
        }
    }
}