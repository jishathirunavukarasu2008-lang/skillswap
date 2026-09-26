package com.skillswap.dao;

import com.skillswap.model.User;
import com.skillswap.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // REGISTER USER
    public boolean registerUser(User user) throws SQLException {

        String sql = "INSERT INTO users "
                + "(full_name, username, email, password_hash) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());

            return ps.executeUpdate() > 0;
        }
    }

    // LOGIN USER
    public User loginUser(String username, String password)
            throws SQLException {

        String sql = "SELECT * FROM users "
                + "WHERE (username = ? OR email = ?) "
                + "AND password_hash = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                 User user = new User(
    rs.getString("full_name"),
    rs.getString("username"),
    rs.getString("email"),
    rs.getString("password_hash")
);

user.setUserId(rs.getInt("user_id"));

return user;   
                }
            }
        }

        return null;
    }
}