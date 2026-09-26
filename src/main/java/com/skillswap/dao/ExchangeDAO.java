package com.skillswap.dao;

import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ExchangeDAO {

    // =========================================================
    // 1. CREATE EXCHANGE REQUEST
    // =========================================================

    public boolean createExchange(
            int requesterId,
            int receiverId,
            int offeredSkillId,
            int wantedSkillId)
            throws SQLException {

        String sql =
                "INSERT INTO exchanges " +
                "(requester_id, receiver_id, offered_skill_id, wanted_skill_id, status) " +
                "VALUES (?, ?, ?, ?, 'PENDING')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, requesterId);
            ps.setInt(2, receiverId);
            ps.setInt(3, offeredSkillId);
            ps.setInt(4, wantedSkillId);

            return ps.executeUpdate() > 0;
        }
    }


    // =========================================================
    // 2. GET OTHER STUDENTS' OFFERED SKILLS
    // =========================================================

    public List<String[]> getAvailableSkills(int currentUserId)
            throws SQLException {

        List<String[]> skills = new ArrayList<>();

        String sql =
                "SELECT us.user_id, " +
                "s.skill_id, " +
                "s.skill_name, " +
                "us.skill_type, " +
                "u.full_name, " +
                "u.username, " +
                "u.bio " +
                "FROM user_skills us " +
                "JOIN skills s ON us.skill_id = s.skill_id " +
                "JOIN users u ON us.user_id = u.user_id " +
                "WHERE us.user_id <> ? " +
                "AND us.skill_type = 'OFFER' " +
                "ORDER BY s.skill_name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, currentUserId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    skills.add(new String[]{
                            String.valueOf(rs.getInt("user_id")),
                            String.valueOf(rs.getInt("skill_id")),
                            rs.getString("skill_name"),
                            rs.getString("skill_type"),
                            rs.getString("full_name"),
                            rs.getString("username"),
                            rs.getString("bio")
                    });
                }
            }
        }

        return skills;
    }


    // =========================================================
    // 3. GET MY OFFERED SKILLS
    // =========================================================

    public List<String[]> getMyOfferedSkills(int userId)
            throws SQLException {

        List<String[]> skills = new ArrayList<>();

        String sql =
                "SELECT s.skill_id, s.skill_name " +
                "FROM user_skills us " +
                "JOIN skills s ON us.skill_id = s.skill_id " +
                "WHERE us.user_id = ? " +
                "AND us.skill_type = 'OFFER' " +
                "ORDER BY s.skill_name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    skills.add(new String[]{
                            String.valueOf(rs.getInt("skill_id")),
                            rs.getString("skill_name")
                    });
                }
            }
        }

        return skills;
    }


    // =========================================================
    // 4. GET MY EXCHANGE REQUESTS
    // =========================================================

    public List<String[]> getMyExchanges(int userId)
            throws SQLException {

        List<String[]> exchanges = new ArrayList<>();

        String sql =
                "SELECT e.exchange_id, " +
                "CASE " +
                "WHEN e.requester_id = ? THEN receiver.full_name " +
                "ELSE requester.full_name " +
                "END AS other_student, " +
                "offered.skill_name AS offered_skill, " +
                "wanted.skill_name AS wanted_skill, " +
                "e.status " +
                "FROM exchanges e " +
                "JOIN users requester " +
                "ON e.requester_id = requester.user_id " +
                "JOIN users receiver " +
                "ON e.receiver_id = receiver.user_id " +
                "JOIN skills offered " +
                "ON e.offered_skill_id = offered.skill_id " +
                "JOIN skills wanted " +
                "ON e.wanted_skill_id = wanted.skill_id " +
                "WHERE (e.requester_id = ? OR e.receiver_id = ?) " +
                "ORDER BY e.exchange_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ps.setInt(3, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    exchanges.add(new String[]{
                            String.valueOf(rs.getInt("exchange_id")),
                            rs.getString("other_student"),
                            rs.getString("offered_skill"),
                            rs.getString("wanted_skill"),
                            rs.getString("status")
                    });
                }
            }
        }

        return exchanges;
    }


    // =========================================================
    // 5. ACCEPT / REJECT EXCHANGE REQUEST
    // =========================================================

    public boolean updateExchangeStatus(
            int exchangeId,
            int receiverId,
            String status)
            throws SQLException {

        String sql =
                "UPDATE exchanges " +
                "SET status = ? " +
                "WHERE exchange_id = ? " +
                "AND receiver_id = ? " +
                "AND status = 'PENDING'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, exchangeId);
            ps.setInt(3, receiverId);

            return ps.executeUpdate() > 0;
        }
    }
}