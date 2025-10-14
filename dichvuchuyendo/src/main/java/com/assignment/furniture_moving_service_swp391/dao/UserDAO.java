package com.assignment.furniture_moving_service_swp391.dao;

import com.assignment.furniture_moving_service_swp391.model.User;
import com.assignment.furniture_moving_service_swp391.util.DBUtil;
import java.sql.*;

public class UserDAO {


    public User login(String email, String password) {
        String sql = "SELECT * FROM Users WHERE email = ? AND password = ? AND active = 1";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("active")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
