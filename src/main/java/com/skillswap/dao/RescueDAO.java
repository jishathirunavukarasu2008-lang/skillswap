package com.skillswap.dao;

import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RescueDAO {

    public boolean createRescue(int exchangeId,
                                int requesterId,
                                String reason)
            throws SQLException {

        String sql =
                "INSERT INTO rescue_requests " +
                "(exchange_id, requester_id, reason, status) " +
                "VALUES (?, ?, ?, 'OPEN')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, exchangeId);
            ps.setInt(2, requesterId);
            ps.setString(3, reason);

            return ps.executeUpdate() > 0;
        }
    }

    public List<String[]> getMyRescueRequests(int userId)
            throws SQLException {

        List<String[]> requests = new ArrayList<>();

        String sql =
                "SELECT r.rescue_id, " +
                "r.exchange_id, " +
                "r.reason, " +
                "r.status, " +
                "r.created_at " +
                "FROM rescue_requests r " +
                "WHERE r.requester_id = ? " +
                "ORDER BY r.rescue_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    requests.add(new String[]{
                            String.valueOf(rs.getInt("rescue_id")),
                            String.valueOf(rs.getInt("exchange_id")),
                            rs.getString("reason"),
                            rs.getString("status"),
                            rs.getString("created_at")
                    });
                }
            }
        }

        return requests;
    }

    public List<String[]> getMyAcceptedExchanges(int userId)
            throws SQLException {

        List<String[]> exchanges = new ArrayList<>();

        String sql =
                "SELECT exchange_id, " +
                "requester_id, " +
                "receiver_id, " +
                "status " +
                "FROM exchanges " +
                "WHERE (requester_id = ? OR receiver_id = ?) " +
                "AND status = 'ACCEPT' " +
                "ORDER BY exchange_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    exchanges.add(new String[]{
                            String.valueOf(rs.getInt("exchange_id")),
                            String.valueOf(rs.getInt("requester_id")),
                            String.valueOf(rs.getInt("receiver_id")),
                            rs.getString("status")
                    });
                }
            }
        }

        return exchanges;
    }
}