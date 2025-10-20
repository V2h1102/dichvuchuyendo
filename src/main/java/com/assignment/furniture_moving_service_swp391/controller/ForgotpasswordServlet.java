package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dao.UserDAO;
import com.assignment.furniture_moving_service_swp391.model.User;
import com.assignment.furniture_moving_service_swp391.util.EmailUtil; // Import lớp EmailUtil
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID; // Dùng để tạo token ngẫu nhiên

@WebServlet(name = "ForgotpasswordServlet", urlPatterns = "/forgot-password")
public class ForgotpasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO userDAO = new UserDAO();

        try {
            User user = userDAO.getUserByEmail(email);
            if (user != null) {
                // 1. Tạo một token ngẫu nhiên
                String resetToken = UUID.randomUUID().toString();

                // ✅ 2. LƯU TOKEN VÀO DATABASE
                userDAO.saveResetToken(user.getId(), resetToken);

                // 3. Tạo link reset và gửi mail (giữ nguyên)
                String resetLink = "http://localhost:8080" + request.getContextPath() + "/reset-password.jsp?token=" + resetToken;
                String subject = "Yêu cầu đặt lại mật khẩu cho Moving Furniture";
                String body = "<html><body>"
                        + "<h2>Đặt Lại Mật Khẩu</h2>"
                        + "<p>Xin chào " + user.getFullName() + ",</p>"
                        + "<p>Vui lòng nhấp vào liên kết dưới đây để tạo mật khẩu mới:</p>"
                        + "<p><a href=\"" + resetLink + "\">Đặt lại mật khẩu của tôi</a></p>"
                        + "</body></html>";
                ; // Giữ nguyên nội dung mail

                EmailUtil.sendEmail(email, subject, body);
            }
            // Luôn chuyển hướng đến trang success để bảo mật
            response.sendRedirect("forgotpassword.jsp?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Chuyển đến trang lỗi nếu có vấn đề về DB
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
    }
}