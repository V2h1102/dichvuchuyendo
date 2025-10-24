package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dao.UserDAO;
import com.assignment.furniture_moving_service_swp391.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UpdateUserServlet", urlPatterns = "/admin/update-user")
public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy tất cả thông tin từ form
            long id = Long.parseLong(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String userType = request.getParameter("userType");
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

            // Tạo một đối tượng User với thông tin đã cập nhật
            User userToUpdate = new User();
            userToUpdate.setId(id);
            userToUpdate.setFullName(fullName);
            userToUpdate.setEmail(email);
            userToUpdate.setPhone(phone);
            userToUpdate.setUserType(userType);
            userToUpdate.setActive(isActive);

            // Gọi DAO để thực hiện cập nhật
            UserDAO userDAO = new UserDAO();
            userDAO.updateUser(userToUpdate);

            // Chuyển hướng về trang danh sách người dùng sau khi cập nhật thành công
            response.sendRedirect(request.getContextPath() + "/admin/all-users");

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            // Nếu có lỗi, chuyển đến trang lỗi
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}