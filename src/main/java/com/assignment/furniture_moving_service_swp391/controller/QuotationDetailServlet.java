package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dal.QuotationDAO;
import com.assignment.furniture_moving_service_swp391.model.QuotationRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/quotation/detail")
public class QuotationDetailServlet extends HttpServlet {

    private QuotationDAO quotationDAO;

    @Override
    public void init() throws ServletException {
        quotationDAO = new QuotationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Lấy toàn bộ bản ghi từ DB
            List<QuotationRequest> quotations = quotationDAO.getAllQuotations();

            if (quotations == null || quotations.isEmpty()) {
                req.setAttribute("error", "Không tìm thấy báo giá nào trong hệ thống.");
            } else {
                req.setAttribute("quotationList", quotations);
            }

            // Forward ra view để hiển thị tất cả báo giá
            req.getRequestDispatcher("/views/quotation-detail.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException("Không thể tải danh sách báo giá", e);
        }
    }
}
