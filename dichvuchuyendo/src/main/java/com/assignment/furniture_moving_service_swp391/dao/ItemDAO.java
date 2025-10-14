package com.assignment.furniture_moving_service_swp391.dao;

import com.assignment.furniture_moving_service_swp391.model.Item;
import com.assignment.furniture_moving_service_swp391.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    // 📋 Lấy danh sách tất cả items (JOIN với ItemCategory để lấy tên category)
    public List<Item> getAllItems() {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT i.id, i.name, i.description, i.category_id, " +
                "c.name AS category_name, i.weight_kg, i.volume_m3, " +
                "i.base_price, i.is_active " +
                "FROM Items i " +
                "LEFT JOIN ItemCategory c ON i.category_id = c.id";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Item item = new Item(
                        rs.getLong("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getLong("category_id"),
                        rs.getString("category_name"),
                        rs.getDouble("weight_kg"),
                        rs.getDouble("volume_m3"),
                        rs.getDouble("base_price"),
                        rs.getBoolean("is_active")
                );
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ➕ Thêm mới item
    public void insertItem(Item item) {
        String sql = "INSERT INTO Items (name, description, category_id, weight_kg, volume_m3, base_price, is_active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setLong(3, item.getCategoryId());
            ps.setDouble(4, item.getWeightKg());
            ps.setDouble(5, item.getVolumeM3());
            ps.setDouble(6, item.getBasePrice());
            ps.setBoolean(7, item.isActive());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // 🔍 Lọc items theo tên và trạng thái (SQL Server dùng BIT)
    public List<Item> searchItems(String keyword, String status) {
        List<Item> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT i.id, i.name, i.description, i.category_id, " +
                        "c.name AS category_name, i.weight_kg, i.volume_m3, " +
                        "i.base_price, i.is_active " +
                        "FROM Items i " +
                        "LEFT JOIN ItemCategory c ON i.category_id = c.id WHERE 1=1 "
        );


        // Thêm điều kiện nếu có keyword
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND i.name LIKE ? ");
        }

        // Thêm điều kiện nếu có trạng thái
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND i.is_active = ? ");
        }

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int index = 1;

            // Set keyword (nếu có)
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }

            // Set status (Active = 1, Inactive = 0)
            if (status != null && !status.trim().isEmpty()) {
                boolean isActive = status.equalsIgnoreCase("active");
                ps.setInt(index++, isActive ? 1 : 0); // ✅ SQL Server dùng BIT nên dùng setInt(1/0)
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item item = new Item(
                            rs.getLong("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getLong("category_id"),
                            rs.getString("category_name"),
                            rs.getDouble("weight_kg"),
                            rs.getDouble("volume_m3"),
                            rs.getDouble("base_price"),
                            rs.getBoolean("is_active")
                    );
                    list.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }



    // 🔍 Lấy item theo ID
    public Item getItemById(long id) {
        String sql = "SELECT i.*, c.name AS category_name " +
                "FROM Items i LEFT JOIN ItemCategory c ON i.category_id = c.id WHERE i.id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Item(
                            rs.getLong("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getLong("category_id"),
                            rs.getString("category_name"),
                            rs.getDouble("weight_kg"),
                            rs.getDouble("volume_m3"),
                            rs.getDouble("base_price"),
                            rs.getBoolean("is_active")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✏️ Cập nhật item
    public void updateItem(Item item) {
        String sql = "UPDATE Items SET name=?, description=?, category_id=?, weight_kg=?, volume_m3=?, base_price=?, is_active=? WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setLong(3, item.getCategoryId());
            ps.setDouble(4, item.getWeightKg());
            ps.setDouble(5, item.getVolumeM3());
            ps.setDouble(6, item.getBasePrice());
            ps.setBoolean(7, item.isActive());
            ps.setLong(8, item.getId());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ❌ Xóa item
    public void deleteItem(long id) {
        String sql = "DELETE FROM Items WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
