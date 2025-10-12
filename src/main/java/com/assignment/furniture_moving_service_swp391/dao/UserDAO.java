package com.assignment.furniture_moving_service_swp391.dao;

import com.assignment.furniture_moving_service_swp391.model.User;
import com.assignment.furniture_moving_service_swp391.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User getUserByEmail(String email) {
        // Tên bảng của bạn là "Users" (có chữ s)
        String sql = "SELECT * FROM Users WHERE email = ?";
        User user = null;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getLong("id"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPasswordHash(rs.getString("password_hash")); // Lấy đúng tên cột
                user.setFullName(rs.getString("full_name"));
                user.setAvatarUrl(rs.getString("avatar_url"));
                user.setUserType(rs.getString("user_type"));
                user.setActive(rs.getBoolean("is_active"));
                user.setLastLoginAt(rs.getTimestamp("last_login_at"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void createUser(User user) throws SQLException {
        // Câu lệnh SQL INSERT, khớp với các cột trong bảng Users của bạn
        String sql = "INSERT INTO Users (email, password_hash, full_name, phone, user_type, is_active) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getUserType());
            ps.setBoolean(6, user.isActive());

            ps.executeUpdate(); // Thực thi câu lệnh INSERT
        }
        // SQLException sẽ được ném ra nếu có lỗi (ví dụ: email đã tồn tại do ràng buộc UNIQUE)
    }

    // (Bạn cần thêm một cột VARCHAR vào bảng Users, ví dụ: reset_token)
    public void saveResetToken(long userId, String token) throws SQLException {
        String sql = "UPDATE Users SET reset_token = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setLong(2, userId);
            ps.executeUpdate();
        }
    }

    public User getUserByResetToken(String token) throws SQLException {
        String sql = "SELECT * FROM Users WHERE reset_token = ?";
        User user = null;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                // ... set các thuộc tính cho user giống như trong getUserByEmail ...
                user.setId(rs.getLong("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
            }
        }
        return user;
    }

    public void updatePassword(long userId, String newPasswordHash) throws SQLException {
        String sql = "UPDATE Users SET password_hash = ?, reset_token = NULL WHERE id = ?"; // Xóa token sau khi đổi mật khẩu
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPasswordHash);
            ps.setLong(2, userId);
            ps.executeUpdate();
        }
    }
}