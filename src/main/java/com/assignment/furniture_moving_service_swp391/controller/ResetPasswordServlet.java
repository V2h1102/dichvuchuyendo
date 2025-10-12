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

        // Kiểm tra mật khẩu có khớp không
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("reset-password.jsp?token=" + token + "&error=password_mismatch");
            return;
        }

        UserDAO userDAO = new UserDAO();
        try {
            // Tìm user bằng token
            User user = userDAO.getUserByResetToken(token);

            if (user != null) {
                // Token hợp lệ, tiến hành đổi mật khẩu
                String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                userDAO.updatePassword(user.getId(), newPasswordHash);

                // Chuyển hướng về trang đăng nhập với thông báo thành công
                response.sendRedirect("login.jsp?reset_success=true");
            } else {
                // Token không hợp lệ hoặc đã hết hạn
                response.sendRedirect("reset-password.jsp?token=" + token + "&error=invalid_token");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý lỗi DB
            response.sendRedirect("error.jsp");
        }
    }
}