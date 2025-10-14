package com.assignment.furniture_moving_service_swp391;

import java.io.*;
import java.util.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;

@WebServlet(name = "productReviewServlet", value = "/admin/product-review")
public class ProductReviewServlet extends HttpServlet {

    public void init() {
        // Initialization code if needed
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        // Set attributes for JSP
        request.setAttribute("pageTitle", "Đánh Giá Dịch Vụ - MoveEasy");
        request.setAttribute("companyName", "MoveEasy");
        
        // Create sample admin user data
        Map<String, String> adminUser = new HashMap<>();
        adminUser.put("name", "Nguyễn Văn A");
        adminUser.put("role", "Quản trị viên");
        adminUser.put("email", "admin@moveeasy.com");
        adminUser.put("avatar", "/assets/images/user/1.jpg");
        request.setAttribute("user", adminUser);
        
        // Create sample reviews data
        List<Map<String, Object>> reviews = new ArrayList<>();
        
        Map<String, Object> review1 = new HashMap<>();
        review1.put("id", 1);
        review1.put("customerName", "Trần Thị B");
        review1.put("service", "Chuyển Nhà Tiêu Chuẩn");
        review1.put("rating", 5);
        review1.put("comment", "Dịch vụ rất tốt, nhân viên chuyên nghiệp");
        review1.put("published", true);
        review1.put("date", "2025-01-15");
        reviews.add(review1);
        
        Map<String, Object> review2 = new HashMap<>();
        review2.put("id", 2);
        review2.put("customerName", "Lê Văn C");
        review2.put("service", "Chuyển Nhà Cao Cấp");
        review2.put("rating", 4);
        review2.put("comment", "Dịch vụ tốt, giá cả hợp lý");
        review2.put("published", true);
        review2.put("date", "2025-01-14");
        reviews.add(review2);
        
        Map<String, Object> review3 = new HashMap<>();
        review3.put("id", 3);
        review3.put("customerName", "Phạm Thị D");
        review3.put("service", "Chuyển Nhà Cơ Bản");
        review3.put("rating", 3);
        review3.put("comment", "Dịch vụ ổn, cần cải thiện thêm");
        review3.put("published", true);
        review3.put("date", "2025-01-13");
        reviews.add(review3);
        
        request.setAttribute("reviews", reviews);
        
        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/product-review.jsp");
        dispatcher.forward(request, response);
    }

    public void destroy() {
    }
}
