package com.skillswap.dao;

import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

public class CircleDAO {

    // =========================================================
    // 1. CREATE CIRCLE
    // =========================================================

    public boolean createCircle(
            String circleName,
            String description,
            int createdBy) throws SQLException {

        String sql =
                "INSERT INTO circles " +
                "(circle_name, description, created_by) " +
                "VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, circleName);
            ps.setString(2, description);
            ps.setInt(3, createdBy);

            return ps.executeUpdate() > 0;
        }
    }


    // =========================================================
    // 2. GET ALL CIRCLES
    // =========================================================

    public List<String[]> getAllCircles()
            throws SQLException {

        List<String[]> circles = new ArrayList<>();

        String sql =
                "SELECT c.circle_id, " +
                "c.circle_name, " +
                "c.description, " +
                "u.full_name " +
                "FROM circles c " +
                "JOIN users u " +
                "ON c.created_by = u.user_id " +
                "ORDER BY c.circle_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                circles.add(new String[]{
                        String.valueOf(
                                rs.getInt("circle_id")),

                        rs.getString("circle_name"),

                        rs.getString("description"),

                        rs.getString("full_name")
                });
            }
        }

        return circles;
    }


    // =========================================================
    // 3. JOIN CIRCLE
    // =========================================================

    public boolean joinCircle(
            int circleId,
            int userId) throws SQLException {

        String sql =
                "INSERT INTO circle_members " +
                "(circle_id, user_id) " +
                "VALUES (?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, circleId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLIntegrityConstraintViolationException e) {

            // User is already a member of this circle
            return false;
        }
    }


    // =========================================================
    // 4. GET MY CIRCLES
    // =========================================================

    public List<String[]> getMyCircles(int userId)
            throws SQLException {

        List<String[]> circles = new ArrayList<>();

        String sql =
                "SELECT c.circle_id, " +
                "c.circle_name, " +
                "c.description " +
                "FROM circles c " +
                "JOIN circle_members cm " +
                "ON c.circle_id = cm.circle_id " +
                "WHERE cm.user_id = ? " +
                "ORDER BY c.circle_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    circles.add(new String[]{
                            String.valueOf(
                                    rs.getInt("circle_id")),

                            rs.getString("circle_name"),

                            rs.getString("description")
                    });
                }
            }
        }

        return circles;
    }


    // =========================================================
    // 5. GET MEMBER COUNT
    // =========================================================

    public int getMemberCount(int circleId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) " +
                "FROM circle_members " +
                "WHERE circle_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, circleId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }
}