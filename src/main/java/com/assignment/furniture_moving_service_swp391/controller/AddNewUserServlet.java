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

@WebServlet(name = "AddNewUserServlet", urlPatterns = "/admin/add-user")
public class AddNewUserServlet extends HttpServlet {

    // doGet() dùng để hiển thị form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/add-new-user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("\n--- BẮT ĐẦU QUY TRÌNH ADD NEW USER ---");
        try {
            // Lấy thông tin từ form
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String plainPassword = request.getParameter("password");
            String userType = request.getParameter("userType");
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
            String loginAt = request.getParameter("loginAt");
            System.out.println("1. Dữ liệu nhận từ form:");
            System.out.println("   - fullName: [" + fullName + "]");
            System.out.println("   - email: [" + email + "]");
            System.out.println("   - phone: [" + phone + "]");
            System.out.println("   - userType: [" + userType + "]");
            System.out.println("   - isActive: [" + isActive + "]");
            System.out.println("   - loginAt: [" + loginAt + "]");

            // Băm mật khẩu
            System.out.println("2. Băm mật khẩu...");
            String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());

            // Tạo đối tượng User mới
            User newUser = new User();
            newUser.setFullName(fullName);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setPasswordHash(hashedPassword);
            newUser.setUserType(userType);
            newUser.setActive(isActive);
            newUser.setLastLoginAt(new java.util.Date(System.currentTimeMillis()));
            // Gọi DAO để lưu vào database
            System.out.println("3. Chuẩn bị gọi UserDAO.addUser()...");
            UserDAO userDAO = new UserDAO();
            userDAO.addUser(newUser);
            System.out.println("4. UserDAO.addUser() đã thực thi xong.");

            // Chuyển hướng về trang danh sách user
            System.out.println("5. Thêm thành công! Chuyển hướng về /admin/all-users.");
            response.sendRedirect(request.getContextPath() + "/admin/all-users");

        } catch (SQLException e) {
            System.out.println("!!! LỖI SQL XẢY RA KHI THÊM USER !!!");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
        System.out.println("--- KẾT THÚC QUY TRÌNH ---\n");
    }
}