package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dao.UserDAO;
import com.assignment.furniture_moving_service_swp391.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = "/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1. Kiểm tra mật khẩu có khớp không
        if (!newPassword.equals(confirmPassword)) {
            // Nếu không khớp, quay lại trang reset với thông báo lỗi
            response.sendRedirect("reset-password.jsp?token=" + token + "&error=password_mismatch");
            return;
        }

        UserDAO userDAO = new UserDAO();
        try {
            // 2. Tìm người dùng trong DB bằng token
            User user = userDAO.getUserByResetToken(token);

            if (user != null) {
                // 3. Token hợp lệ -> Băm mật khẩu mới
                String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());

                // 4. Cập nhật mật khẩu mới vào DB
                userDAO.updatePassword(user.getId(), newPasswordHash);

                // 5. Chuyển hướng về trang đăng nhập với thông báo thành công
                response.sendRedirect("login.jsp?reset_success=true");
            } else {
                // 6. Token không hợp lệ hoặc đã hết hạn
                response.sendRedirect("reset-password.jsp?token=" + token + "&error=invalid_token");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Nếu có lỗi DB, chuyển đến trang lỗi chung
            response.sendRedirect("error.jsp");
        }
    }
}