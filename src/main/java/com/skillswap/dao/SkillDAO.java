
package com.skillswap.dao;

import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

public class SkillDAO {

    // Add a skill for a user
    public boolean addSkill(int userId, String skillName,
                            String skillType) throws SQLException {

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            int skillId = -1;

            // Check whether the skill already exists
            String checkSql =
                    "SELECT skill_id FROM skills WHERE skill_name = ?";

            try (PreparedStatement ps =
                         con.prepareStatement(checkSql)) {

                ps.setString(1, skillName);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        skillId = rs.getInt("skill_id");
                    }
                }
            }

            // Insert the skill if it does not exist
            if (skillId == -1) {

                String insertSkill =
                        "INSERT INTO skills (skill_name) VALUES (?)";

                try (PreparedStatement ps =
                             con.prepareStatement(
                                     insertSkill,
                                     Statement.RETURN_GENERATED_KEYS)) {

                    ps.setString(1, skillName);
                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            skillId = rs.getInt(1);
                        }
                    }
                }
            }

            // Connect the skill with the user
            String insertUserSkill =
                    "INSERT INTO user_skills " +
                    "(user_id, skill_id, skill_type) VALUES (?, ?, ?)";

            try (PreparedStatement ps =
                         con.prepareStatement(insertUserSkill)) {

                ps.setInt(1, userId);
                ps.setInt(2, skillId);
                ps.setString(3, skillType);

                ps.executeUpdate();
            }

            con.commit();
            return true;

       } catch (SQLException e) {

    if (con != null) {
        try {
            con.rollback();
        } catch (SQLException rollbackException) {
            rollbackException.printStackTrace();
        }
    }

    // Duplicate skill for the same user and type
    if (e instanceof java.sql.SQLIntegrityConstraintViolationException) {
        return false;
    }

    throw e;
}finally {

            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        }
    }

    // Get all skills belonging to a user
    public List<String[]> getUserSkills(int userId)
            throws SQLException {

        List<String[]> skills = new ArrayList<>();

        String sql =
                "SELECT s.skill_name, us.skill_type " +
                "FROM user_skills us " +
                "JOIN skills s ON us.skill_id = s.skill_id " +
                "WHERE us.user_id = ? " +
                "ORDER BY us.skill_type, s.skill_name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    String[] skill = {
                        rs.getString("skill_name"),
                        rs.getString("skill_type")
                    };

                    skills.add(skill);
                }
            }
        }

        return skills;
    }
}