package com.assignment.furniture_moving_service_swp391.dao;

import com.assignment.furniture_moving_service_swp391.model.User;
import com.assignment.furniture_moving_service_swp391.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User getUserByEmail(String email) {

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

        String sql = "INSERT INTO Users (email, password_hash, full_name, phone, user_type, is_active, last_login_at) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getUserType());
            ps.setBoolean(6, user.isActive());
            java.sql.Timestamp sqlTimestamp = null;
            if (user.getLastLoginAt() != null) {
                sqlTimestamp = new java.sql.Timestamp(user.getLastLoginAt().getTime());
                ps.setTimestamp(7, sqlTimestamp);
            } else {
                ps.setTimestamp(7, null);
            }
            ps.executeUpdate();
        }

    }

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
                user.setId(rs.getLong("id"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setFullName(rs.getString("full_name"));
                user.setAvatarUrl(rs.getString("avatar_url"));
                user.setUserType(rs.getString("user_type"));
                user.setActive(rs.getBoolean("is_active"));
                user.setLastLoginAt(rs.getTimestamp("last_login_at"));

            }
        }
        return user;
    }

    public void updatePassword(long userId, String newPasswordHash) throws SQLException {
        // Cập nhật mật khẩu và xóa token để nó không thể được sử dụng lại
        String sql = "UPDATE Users SET password_hash = ?, reset_token = NULL WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPasswordHash);
            ps.setLong(2, userId);
            ps.executeUpdate();
        }
    }


    public List<User> getAllUsers() throws SQLException {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT id, email, full_name, phone, user_type, is_active FROM Users";

        System.out.println("--- [DAO] Bắt đầu lấy tất cả user...");

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                System.out.println("--- [DAO] Tìm thấy một user trong ResultSet!");

                User user = new User();
                user.setId(rs.getLong("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setUserType(rs.getString("user_type"));
                user.setActive(rs.getBoolean("is_active"));
                userList.add(user);
            }
        }

        System.out.println("--- [DAO] Kết thúc. Số user tìm thấy: " + userList.size());
        return userList;
    }


    public User getUserById(long userId) throws SQLException {
        User user = null;
        String sql = "SELECT * FROM Users WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getLong("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setUserType(rs.getString("user_type"));
                user.setActive(rs.getBoolean("is_active"));
            }
        }
        return user;
    }

    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE Users SET full_name = ?, email = ?, phone = ?, user_type = ?, is_active = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getUserType());
            ps.setBoolean(5, user.isActive());
            ps.setLong(6, user.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có hàng nào được cập nhật
        }
    }


    public boolean addUser(User user) throws SQLException {
        // Không cần chèn ID vì nó là auto-increment
        String sql = "INSERT INTO Users (full_name, email, phone, password_hash, user_type, is_active, last_login_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        System.out.println("--- [DAO addUser] SQL: " + sql);
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPasswordHash());
            ps.setString(5, user.getUserType());
            ps.setBoolean(6, user.isActive());
            java.sql.Timestamp sqlTimestamp = null;
            if (user.getLastLoginAt() != null) {
                sqlTimestamp = new java.sql.Timestamp(user.getLastLoginAt().getTime());
                ps.setTimestamp(7, sqlTimestamp);
            } else {
                ps.setTimestamp(7, null);
            }

            System.out.println("--- [DAO addUser] Timestamp being set (Index 7): " + sqlTimestamp);

            System.out.println("--- [DAO addUser] Executing update...");
            int rowsAffected = ps.executeUpdate();
            System.out.println("--- [DAO addUser] Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        }catch (SQLException e) {
            System.out.println("!!! [DAO addUser] SQLException during execution !!!"); // Log exception in DAO
            e.printStackTrace();
            throw e;
        }
    }


    public boolean deleteUser(long userId) throws SQLException {
        String sql = "DELETE FROM Users WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
}