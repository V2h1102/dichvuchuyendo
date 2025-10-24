package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/admin/delete-user")
public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long userId = Long.parseLong(request.getParameter("userId"));
        UserDAO userDAO = new UserDAO();
        try {
            userDAO.deleteUser(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Sau khi xóa, quay lại trang danh sách người dùng
        response.sendRedirect(request.getContextPath() + "/admin/all-users");
    }
}
