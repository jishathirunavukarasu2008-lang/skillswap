
package com.skillswap.dao;

import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RecommendationDAO {

    public List<String[]> getRecommendations(int currentUserId)
            throws SQLException {

        List<String[]> recommendations = new ArrayList<>();

        String sql =
                "SELECT DISTINCT " +
                "u.user_id, " +
                "u.full_name, " +
                "u.username, " +
                "u.bio, " +
                "s.skill_name AS matching_skill " +
                "FROM users u " +
                "JOIN user_skills us ON u.user_id = us.user_id " +
                "JOIN skills s ON us.skill_id = s.skill_id " +
                "WHERE u.user_id <> ? " +
                "AND us.skill_type = 'OFFER' " +
                "AND s.skill_id IN ( " +
                "    SELECT wanted.skill_id " +
                "    FROM user_skills wanted " +
                "    WHERE wanted.user_id = ? " +
                "    AND wanted.skill_type = 'WANT' " +
                ") " +
                "ORDER BY u.full_name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, currentUserId);
            ps.setInt(2, currentUserId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    recommendations.add(new String[]{
                            String.valueOf(
                                    rs.getInt("user_id")),

                            rs.getString("full_name"),

                            rs.getString("username"),

                            rs.getString("bio"),

                            rs.getString("matching_skill")
                    });
                }
            }
        }

        return recommendations;
    }
}