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
import java.util.UUID; // Dùng để tạo token ngẫu nhiên

@WebServlet(name = "ForgotpasswordServlet", urlPatterns = "/forgot-password")
public class ForgotpasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        if (user != null) {
            // ---- NẾU TÌM THẤY USER ----

            // 1. Tạo một token ngẫu nhiên, duy nhất
            String resetToken = UUID.randomUUID().toString();

            // 2. (Quan trọng) Lưu token này vào database cùng với user ID
            // Bạn cần thêm một cột `reset_token` vào bảng Users
            // và một phương thức trong UserDAO để lưu nó.
            // Ví dụ: userDAO.saveResetToken(user.getId(), resetToken);
            System.out.println("Generated Reset Token: " + resetToken);


            // 3. Tạo link reset
            String resetLink = "http://localhost:8080" + request.getContextPath() + "/reset-password.jsp?token=" + resetToken;

            // 4. Soạn nội dung email
            String subject = "Yêu cầu đặt lại mật khẩu cho Moving Furniture";
            String body = "<html>"
                    + "<body>"
                    + "<h2>Đặt Lại Mật Khẩu</h2>"
                    + "<p>Xin chào " + user.getFullName() + ",</p>"
                    + "<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Vui lòng nhấp vào liên kết dưới đây để tạo mật khẩu mới:</p>"
                    + "<p><a href=\"" + resetLink + "\">Đặt lại mật khẩu của tôi</a></p>"
                    + "<p>Nếu bạn không yêu cầu điều này, vui lòng bỏ qua email này.</p>"
                    + "<p>Trân trọng,<br>Đội ngũ Moving Furniture</p>"
                    + "</body>"
                    + "</html>";

            // 5. Gửi email
            EmailUtil.sendEmail(email, subject, body);

            // 6. Chuyển hướng về trang cũ với thông báo thành công
            response.sendRedirect("forgotpassword.jsp?success=true");

        } else {
            // ---- NẾU KHÔNG TÌM THẤY USER ----
            // Chúng ta vẫn chuyển hướng về trang thành công để bảo mật.
            // Điều này ngăn kẻ xấu biết được một email có tồn tại trong hệ thống hay không.
            response.sendRedirect("forgotpassword.jsp?success=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
    }
}