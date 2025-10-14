package com.assignment.furniture_moving_service_swp391;

import java.io.*;
import java.util.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;

@WebServlet(name = "adminServlet", value = "/admin")
public class AdminServlet extends HttpServlet {

    public void init() {
        // Initialization code if needed
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        // Set attributes for admin JSP
        request.setAttribute("pageTitle", "Admin Dashboard - MoveEasy");
        request.setAttribute("companyName", "MoveEasy");
        
        // Create sample admin user data
        Map<String, String> adminUser = new HashMap<>();
        adminUser.put("name", "Nguyễn Văn A");
        adminUser.put("role", "Quản trị viên");
        adminUser.put("email", "admin@moveeasy.com");
        adminUser.put("avatar", "/assets/images/user/1.jpg");
        request.setAttribute("user", adminUser);
        
        // Create sample admin notifications
        List<String> notifications = new ArrayList<>();
        notifications.add("Đơn hàng mới cần xử lý");
        notifications.add("Báo cáo doanh thu tháng");
        notifications.add("Cập nhật hệ thống thành công");
        request.setAttribute("notifications", notifications);
        request.setAttribute("notificationCount", notifications.size());
        
        // Create sample dashboard data
        Map<String, Object> dashboardData = new HashMap<>();
        dashboardData.put("totalOrders", 156);
        dashboardData.put("pendingOrders", 23);
        dashboardData.put("completedOrders", 133);
        dashboardData.put("totalRevenue", 12500000); // VND
        dashboardData.put("monthlyRevenue", 3200000); // VND
        dashboardData.put("activeCustomers", 89);
        dashboardData.put("totalEmployees", 15);
        request.setAttribute("dashboardData", dashboardData);
        
        // Create sample recent orders
        List<Map<String, Object>> recentOrders = new ArrayList<>();
        Map<String, Object> order1 = new HashMap<>();
        order1.put("id", "ORD001");
        order1.put("customer", "Trần Thị B");
        order1.put("service", "Chuyển Nhà Tiêu Chuẩn");
        order1.put("amount", 2500000);
        order1.put("status", "Đang xử lý");
        order1.put("date", "2025-01-15");
        recentOrders.add(order1);
        
        Map<String, Object> order2 = new HashMap<>();
        order2.put("id", "ORD002");
        order2.put("customer", "Lê Văn C");
        order2.put("service", "Chuyển Nhà Cao Cấp");
        order2.put("amount", 4500000);
        order2.put("status", "Hoàn thành");
        order2.put("date", "2025-01-14");
        recentOrders.add(order2);
        
        Map<String, Object> order3 = new HashMap<>();
        order3.put("id", "ORD003");
        order3.put("customer", "Phạm Thị D");
        order3.put("service", "Chuyển Nhà Cơ Bản");
        order3.put("amount", 1800000);
        order3.put("status", "Chờ xác nhận");
        order3.put("date", "2025-01-13");
        recentOrders.add(order3);
        
        request.setAttribute("recentOrders", recentOrders);
        
        // Forward to admin JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminindex.jsp");
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}
