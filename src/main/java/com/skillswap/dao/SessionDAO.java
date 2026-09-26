
package com.skillswap.dao;

import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SessionDAO {

    public boolean createSession(
            int exchangeId,
            String scheduledDate,
            String scheduledTime,
            String topic,
            int durationMinutes) throws SQLException {

        String sql =
                "INSERT INTO exchange_sessions " +
                "(exchange_id, scheduled_date, scheduled_time, topic, duration_minutes, status) " +
                "VALUES (?, ?, ?, ?, ?, 'SCHEDULED')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, exchangeId);
            ps.setString(2, scheduledDate);
            ps.setString(3, scheduledTime);
            ps.setString(4, topic);
            ps.setInt(5, durationMinutes);

            return ps.executeUpdate() > 0;
        }
    }


    public List<String[]> getMySessions(int userId) throws SQLException {

        List<String[]> sessions = new ArrayList<>();

        String sql =
                "SELECT es.session_id, " +
                "es.exchange_id, " +
                "es.scheduled_date, " +
                "es.scheduled_time, " +
                "es.topic, " +
                "es.duration_minutes, " +
                "es.status, " +
                "CASE " +
                "WHEN e.requester_id = ? THEN receiver.full_name " +
                "ELSE requester.full_name " +
                "END AS other_student " +
                "FROM exchange_sessions es " +
                "JOIN exchanges e " +
                "ON es.exchange_id = e.exchange_id " +
                "JOIN users requester " +
                "ON e.requester_id = requester.user_id " +
                "JOIN users receiver " +
                "ON e.receiver_id = receiver.user_id " +
                "WHERE e.requester_id = ? " +
                "OR e.receiver_id = ? " +
                "ORDER BY es.scheduled_date, es.scheduled_time";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ps.setInt(3, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    sessions.add(new String[]{
                            String.valueOf(rs.getInt("session_id")),
                            String.valueOf(rs.getInt("exchange_id")),
                            rs.getString("scheduled_date"),
                            rs.getString("scheduled_time"),
                            rs.getString("topic"),
                            String.valueOf(rs.getInt("duration_minutes")),
                            rs.getString("status"),
                            rs.getString("other_student")
                    });
                }
            }
        }

        return sessions;
    }


    public boolean updateSessionStatus(
            int sessionId,
            int userId,
            String status) throws SQLException {

        String sql =
                "UPDATE exchange_sessions es " +
                "JOIN exchanges e " +
                "ON es.exchange_id = e.exchange_id " +
                "SET es.status = ? " +
                "WHERE es.session_id = ? " +
                "AND (e.requester_id = ? OR e.receiver_id = ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, sessionId);
            ps.setInt(3, userId);
            ps.setInt(4, userId);

            return ps.executeUpdate() > 0;
        }
    }
}