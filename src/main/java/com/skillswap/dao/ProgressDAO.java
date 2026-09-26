
package com.skillswap.dao;

import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProgressDAO {

    public int getAcceptedExchanges(int userId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) " +
                "FROM exchanges " +
                "WHERE (requester_id = ? OR receiver_id = ?) " +
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


    public int getScheduledSessions(int userId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) " +
                "FROM exchange_sessions es " +
                "JOIN exchanges e " +
                "ON es.exchange_id = e.exchange_id " +
                "WHERE (e.requester_id = ? OR e.receiver_id = ?) " +
                "AND es.status = 'SCHEDULED'";

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
                "WHERE (e.requester_id = ? OR e.receiver_id = ?) " +
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


    public int getTotalSessions(int userId)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) " +
                "FROM exchange_sessions es " +
                "JOIN exchanges e " +
                "ON es.exchange_id = e.exchange_id " +
                "WHERE e.requester_id = ? " +
                "OR e.receiver_id = ?";

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
}