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

// Map servlet này với action="register" của form
@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy thông tin từ form đăng ký
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String plainPassword = request.getParameter("password");

        UserDAO userDAO = new UserDAO();

        try {
            // 2. Kiểm tra xem email đã tồn tại trong DB chưa
            if (userDAO.getUserByEmail(email) != null) {
                // Nếu email đã tồn tại, quay lại trang đăng ký với thông báo lỗi
                response.sendRedirect("register.jsp?error=exists");
                return;
            }

            // 3. Băm (hash) mật khẩu người dùng đã nhập
            String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());

            // 4. Tạo đối tượng User mới
            User newUser = new User();
            newUser.setFullName(fullName);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setPasswordHash(hashedPassword); // Lưu mật khẩu đã được băm
            newUser.setUserType("USER"); // Đặt giá trị mặc định, ví dụ: "CUSTOMER"
            newUser.setActive(true); // Đặt giá trị mặc định
            newUser.setLastLoginAt(new java.util.Date(System.currentTimeMillis()));
            // 5. Lưu người dùng mới vào database
            userDAO.createUser(newUser);

            // 6. Chuyển hướng đến trang đăng nhập với thông báo thành công
            response.sendRedirect("login.jsp?success=true");

        } catch (SQLException e) {
            System.out.println("Gửi email thất bại!");
            // Xử lý các lỗi liên quan đến database
            e.printStackTrace();
            // Bạn có thể chuyển hướng đến một trang lỗi chung
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Nếu người dùng truy cập /register, chỉ cần hiển thị trang đăng ký
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}