package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dal.QuotationDAO;
import com.assignment.furniture_moving_service_swp391.model.QuotationRequest;
import com.assignment.furniture_moving_service_swp391.model.ItemRequest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.sql.SQLException; // Import cần thiết cho DAO

@WebServlet({"/contract", "/confirm-contract"})
public class ContractServlet extends HttpServlet {

    private final QuotationDAO quotationDAO = new QuotationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (Logic doGet giữ nguyên: Lấy QuotationRequest từ DB, lấy items, forward tới contract.jsp)
        String quotationIdParam = request.getParameter("quotationId");

        if (quotationIdParam == null || quotationIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quotation");
            return;
        }

        try {
            int quotationId = Integer.parseInt(quotationIdParam);
            QuotationRequest req = quotationDAO.getQuotationById(quotationId);

            if (req != null) {
                List<ItemRequest> items = quotationDAO.getQuotationItems(quotationId);
                req.setItemRequests(items);

                // Tính toán giá trị hiển thị
                double totalPrice = req.getTotalCost();
                double depositAmount = totalPrice * 0.5;

                // Gán các thuộc tính
                request.setAttribute("quotationRequest", req);
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("depositAmount", depositAmount);

                request.getRequestDispatcher("/views/contract.jsp").forward(request, response);

            } else {
                request.setAttribute("errorMessage", "Không tìm thấy báo giá có ID: " + quotationId);
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID báo giá không hợp lệ.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", "Lỗi DB khi tải báo giá: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();

        if ("/confirm-contract".equals(action)) {
            handleContractConfirmation(request, response);
        }
    }

    private void handleContractConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String quotationIdParam   = request.getParameter("quotationId");
        String customerName       = request.getParameter("customerName");
        String customerPhone      = request.getParameter("customerPhone");
        String specialInstructions= request.getParameter("specialInstructions");

        if (quotationIdParam == null || customerName == null || customerPhone == null
                || customerName.trim().isEmpty() || customerPhone.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập Tên và Số điện thoại khách hàng.");
            repopulateContractForm(request, response);
            return;
        }

        try {
            int quotationId = Integer.parseInt(quotationIdParam);

            // 1) LƯU THẲNG vào bảng QuotationRequests
            quotationDAO.saveCustomerInfoToQuotation(
                    quotationId,
                    customerName.trim(),
                    customerPhone.trim(),
                    specialInstructions
            );

            // 2) (Tuỳ chọn) Cập nhật trạng thái nếu muốn
            // quotationDAO.updateQuotationStatus(quotationId, "PENDING_PAYMENT");

            // 3) Lưu SĐT vào session để lọc "My Quotations"
            request.getSession().setAttribute("userPhone", customerPhone.trim());

            // 4) Redirect qua trang quản lý (list-user)
            response.sendRedirect(request.getContextPath() + "/quotation?action=list-user");

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi xử lý xác nhận hợp đồng: " + e.getMessage());
            repopulateContractForm(request, response);
        }
    }


    /**
     * Phương thức trợ giúp để tải lại form hợp đồng khi có lỗi (giữ nguyên)
     */
    private void repopulateContractForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String quotationIdParam = request.getParameter("quotationId");

        try {
            int quotationId = Integer.parseInt(quotationIdParam);
            QuotationRequest req = quotationDAO.getQuotationById(quotationId);

            if (req != null) {
                req.setSpecialNotes(request.getParameter("specialInstructions"));
                // Giả định rằng bạn có thể gán lại các thông tin khách hàng vào request.setAttribute("customerInfo", ...);
                request.setAttribute("quotationRequest", req);
                request.getRequestDispatcher("/views/contract.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/error.jsp");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}