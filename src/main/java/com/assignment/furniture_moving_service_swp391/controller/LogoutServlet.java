package com.assignment.furniture_moving_service_swp391.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// ✅ BƯỚC 1: Mapping servlet này với đường dẫn "logout" trong thẻ <a>
@WebServlet(name = "LogoutServlet", urlPatterns = "/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ✅ BƯỚC 2: Lấy session hiện tại của người dùng.
        // Tham số 'false' có nghĩa là: "Lấy session nếu nó tồn tại, không tạo mới nếu không có".
        HttpSession session = request.getSession(false);

        // ✅ BƯỚC 3: Kiểm tra xem session có tồn tại không và xóa nó.
        if (session != null) {
            session.invalidate(); // Xóa tất cả các thuộc tính trong session và kết thúc session.
        }

        // ✅ BƯỚC 4: Chuyển hướng người dùng về trang đăng nhập.
        // Kèm theo một tham số "logout=true" để trang login.jsp có thể hiển thị thông báo.
        response.sendRedirect("login.jsp?logout=true");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Trong trường hợp này, chúng ta chỉ xử lý GET request từ thẻ <a>
        // nên có thể để trống hoặc gọi doGet.
        doGet(request, response);
    }
}