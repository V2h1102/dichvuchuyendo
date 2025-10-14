package com.assignment.furniture_moving_service_swp391;

import java.io.*;
import java.util.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;

@WebServlet(name = "indexServlet", value = "/")
public class IndexServlet extends HttpServlet {

    public void init() {
        // Initialization code if needed
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        // Set attributes for JSP
        request.setAttribute("pageTitle", "Dịch Vụ Chuyển Nhà - MoveEasy");
        request.setAttribute("companyName", "MoveEasy");
        request.setAttribute("heroTitle", "Dịch Vụ Chuyển Nhà Chuyên Nghiệp");
        request.setAttribute("heroDescription", 
            "Chuyển nhà an toàn, nhanh chóng và tiết kiệm với đội ngũ nhân viên chuyên nghiệp. Chúng tôi cam kết bảo vệ đồ đạc của bạn như của chính mình.");
        
        // Create sample user data
        Map<String, String> user = new HashMap<>();
        user.put("name", "Nguyễn Văn A");
        user.put("role", "Quản trị viên");
        user.put("email", "admin@moveeasy.com");
        user.put("avatar", "/assets/images/user/1.jpg");
        request.setAttribute("user", user);
        
        // Create sample notifications
        List<String> notifications = new ArrayList<>();
        notifications.add("Đơn hàng mới đã được tạo");
        notifications.add("Cập nhật hệ thống");
        notifications.add("Báo cáo tháng đã sẵn sàng");
        request.setAttribute("notifications", notifications);
        request.setAttribute("notificationCount", notifications.size());
        
        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}
