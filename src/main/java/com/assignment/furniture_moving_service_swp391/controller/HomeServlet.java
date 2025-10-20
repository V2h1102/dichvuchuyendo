package com.assignment.furniture_moving_service_swp391.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HomeServlet", urlPatterns = {"/", "/home"})
public class HomeServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
// --- Demo data to drive the JSP ---
        req.setAttribute("pageTitle", "MoveEasy - Nền tảng đặt dịch vụ");
        req.setAttribute("companyName", "MoveEasy");


// Notifications (you can replace with data from DB/service)
        List<Map<String, String>> notifications = new ArrayList<>();
        notifications.add(Map.of("message", "Đã tạo đặt chỗ mới"));
        notifications.add(Map.of("message", "Yêu cầu báo giá đã được gửi"));
        notifications.add(Map.of("message", "Lịch làm việc nhân viên đã thay đổi"));
        req.setAttribute("notifications", notifications);
        req.setAttribute("notificationCount", notifications.size());


// User info (avatar/name/role)
        Map<String, Object> user = new HashMap<>();
        user.put("name", "Jane Doe");
        user.put("role", "Khách hàng");
        user.put("avatar", "https://via.placeholder.com/32/2563eb/ffffff?text=U");
        req.setAttribute("user", user);


// Optional hero text
        req.setAttribute("heroTitle", "Chuyển dọn nhẹ nhàng, dịch vụ tinh gọn");
        req.setAttribute("heroDescription", "Đặt dịch vụ chuyển dọn trực tuyến tức thì. Nhận báo giá chính xác và quản lý chi tiết dễ dàng.");


        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}
