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

        // ======================= BƯỚC 1: KIỂM TRA ĐẦU VÀO =======================
        String email = request.getParameter("email");
        String plainPassword = request.getParameter("password");

        System.out.println("\n--- BẮT ĐẦU QUY TRÌNH LOGIN ---");
        System.out.println("1. Dữ liệu nhận từ form:");
        // Dấu ngoặc vuông [] giúp phát hiện khoảng trắng thừa
        System.out.println("   - Email: [" + email + "]");
        System.out.println("   - Mật khẩu: [" + plainPassword + "]");

        // ======================= BƯỚC 2: TRUY VẤN DATABASE =======================
        System.out.println("\n2. Bắt đầu truy vấn UserDAO...");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            System.out.println("   -> KẾT QUẢ: UserDAO không tìm thấy user nào với email này. Dừng lại.");
            response.sendRedirect("login.jsp?error=true");
            return; // Dừng thực thi ngay lập tức
        } else {
            System.out.println("   -> KẾT QUẢ: UserDAO đã tìm thấy user: " + user.getEmail());
            System.out.println("      - Hash từ DB: [" + user.getPasswordHash() + "]");
        }

        // ======================= BƯỚC 3: SO SÁNH MẬT KHẨU =======================
        System.out.println("\n3. Bắt đầu so sánh mật khẩu bằng BCrypt...");
        boolean passwordMatch = false;
        try {
            passwordMatch = BCrypt.checkpw(plainPassword, user.getPasswordHash());
            System.out.println("   -> KẾT QUẢ SO SÁNH: " + passwordMatch);
        } catch (Exception e) {
            System.out.println("   -> LỖI KHI SO SÁNH BCRYPT: " + e.getMessage());
        }

        // ======================= BƯỚC 4: XỬ LÝ KẾT QUẢ CUỐI CÙNG =======================
        if (passwordMatch) {
            System.out.println("\n4. ĐĂNG NHẬP THÀNH CÔNG. Chuyển hướng đến home.jsp.");
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Cập nhật thời gian đăng nhập cuối cùng (Tùy chọn)
            // userDAO.updateLastLogin(user.getId());

            response.sendRedirect("index1.jsp");
        } else {
            System.out.println("\n4. ĐĂNG NHẬP THẤT BẠI. Chuyển hướng về login.jsp?error=true.");
            response.sendRedirect("login.jsp?error=true");
        }
        System.out.println("--- KẾT THÚC QUY TRÌNH LOGIN ---\n");
    }

    // Giữ nguyên doGet
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Nếu người dùng truy cập trực tiếp /login bằng GET, chỉ cần chuyển hướng họ đến trang jsp
        response.sendRedirect("login.jsp");
    }
}