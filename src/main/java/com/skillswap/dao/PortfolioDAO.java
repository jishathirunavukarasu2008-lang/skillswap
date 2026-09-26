
package com.skillswap.dao;

import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PortfolioDAO {

    public String[] getUserInfo(int userId)
            throws SQLException {

        String sql =
                "SELECT full_name, username, bio " +
                "FROM users " +
                "WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    return new String[]{
                            rs.getString("full_name"),
                            rs.getString("username"),
                            rs.getString("bio")
                    };
                }
            }
        }

        return new String[]{"", "", ""};
    }


    public List<String[]> getSkills(int userId,
                                    String skillType)
            throws SQLException {

        List<String[]> skills = new ArrayList<>();

        String sql =
                "SELECT s.skill_name " +
                "FROM user_skills us " +
                "JOIN skills s " +
                "ON us.skill_id = s.skill_id " +
                "WHERE us.user_id = ? " +
                "AND us.skill_type = ? " +
                "ORDER BY s.skill_name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, skillType);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    skills.add(new String[]{
                            rs.getString("skill_name")
                    });
                }
            }
        }

        return skills;
    }


    public int getAcceptedExchanges(int userId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) " +
                "FROM exchanges " +
                "WHERE (requester_id = ? " +
                "OR receiver_id = ?) " +
                "AND status = 'ACCEPT'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }


    public int getCompletedSessions(int userId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) " +
                "FROM exchange_sessions es " +
                "JOIN exchanges e " +
                "ON es.exchange_id = e.exchange_id " +
                "WHERE (e.requester_id = ? " +
                "OR e.receiver_id = ?) " +
                "AND es.status = 'COMPLETED'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }


    public int getJoinedCircles(int userId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) " +
                "FROM circle_members " +
                "WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }
}