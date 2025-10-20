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
import java.util.List;

// Map servlet với một đường dẫn, ví dụ: /admin/users
@WebServlet(name = "AdminAllUsersServlet", urlPatterns = "/admin/all-users")
public class AdminAllUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        try {
            List<User> userList = userDAO.getAllUsers();

            System.out.println("--- [SERVLET] Số user nhận được từ DAO: " + (userList != null ? userList.size() : "null")); // Dòng debug 4

            request.setAttribute("userList", userList);
            request.getRequestDispatcher("/admin/all-users.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Nếu có lỗi, chuyển đến trang lỗi
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}