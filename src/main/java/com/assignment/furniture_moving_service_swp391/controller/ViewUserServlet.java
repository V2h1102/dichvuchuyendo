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

@WebServlet(urlPatterns = "/admin/view-user")
public class ViewUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long userId = Long.parseLong(request.getParameter("id"));
        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.getUserById(userId);
            request.setAttribute("userDetail", user);
            request.getRequestDispatcher("/admin/view-user.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}