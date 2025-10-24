package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dao.UserDAO;
import com.assignment.furniture_moving_service_swp391.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt; // Import thư viện jBCrypt

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String plainPassword = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        // Kiểm tra user có tồn tại và mật khẩu có khớp không
        if (user != null && BCrypt.checkpw(plainPassword, user.getPasswordHash())) {

            // Đăng nhập thành công, tạo session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // ===================================================================
            // PHÂN QUYỀN DỰA TRÊN VAI TRÒ (userType)
            // ===================================================================
            String userType = user.getUserType();

            System.out.println("Đăng nhập thành công với vai trò: " + userType);

            if ("ADMIN".equalsIgnoreCase(userType)) {
                // Nếu là ADMIN, chuyển hướng đến trang quản trị
                System.out.println("Chuyển hướng đến trang admin...");
                response.sendRedirect(request.getContextPath() + "/admin/all-users");
            } else {
                // Nếu là CUSTOMER hoặc các vai trò khác, chuyển hướng đến trang chủ
                System.out.println("Chuyển hướng đến trang chủ...");
                response.sendRedirect(request.getContextPath() + "/index1.jsp"); // Hoặc index1.jsp tùy bạn
            }

        } else {
            // Đăng nhập thất bại
            System.out.println("Đăng nhập thất bại. Chuyển hướng về trang login.");
            response.sendRedirect("login.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}