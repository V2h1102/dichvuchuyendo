package com.assignment.furniture_moving_service_swp391.dao;

import com.assignment.furniture_moving_service_swp391.model.ItemCategory;
import com.assignment.furniture_moving_service_swp391.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemCategoryDAO {

    // 🔹 Lấy toàn bộ category
    public List<ItemCategory> getAllCategories() {
        List<ItemCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM ItemCategory";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ItemCategory c = new ItemCategory();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setActive(rs.getBoolean("is_active"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    // 🔹 Lấy danh sách category đang hoạt động
    public List<ItemCategory> getActiveCategories() {
        List<ItemCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM ItemCategory WHERE is_active = 1";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ItemCategory c = new ItemCategory();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setActive(rs.getBoolean("is_active"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 🔹 Lấy category theo ID
    public ItemCategory getCategoryById(int id) {
        String sql = "SELECT * FROM ItemCategory WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ItemCategory(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getBoolean("is_active")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🔹 Thêm mới category
    public void insertCategory(ItemCategory category) {
        String sql = "INSERT INTO ItemCategory (name, description, is_active) VALUES (?, ?, ?)";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setBoolean(3, category.isActive());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🔹 Cập nhật category
    public void updateCategory(ItemCategory category) {
        String sql = "UPDATE ItemCategory SET name=?, description=?, is_active=? WHERE id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setBoolean(3, category.isActive());
            ps.setInt(4, (int) category.getId());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🔹 Xóa category (logic delete)
    public void deleteCategory(int id) {
        String sql = "UPDATE ItemCategory SET is_active = 0 WHERE id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
