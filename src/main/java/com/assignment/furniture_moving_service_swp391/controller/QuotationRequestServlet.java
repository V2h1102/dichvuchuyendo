package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dal.QuotationDAO;
import com.assignment.furniture_moving_service_swp391.model.FurnitureType;
import com.assignment.furniture_moving_service_swp391.model.ItemRequest;
import com.assignment.furniture_moving_service_swp391.model.QuotationRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@WebServlet("/quotation")
public class QuotationRequestServlet extends HttpServlet {

    private final QuotationDAO quotationDAO = new QuotationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý hiển thị form (nếu chưa có)
        try {
            // Lấy danh sách đồ đạc theo nhóm để hiển thị trong form select/optgroup
            Map<String, List<FurnitureType>> furnitureGroups = quotationDAO.getGroupedFurnitureData();
            request.setAttribute("furnitureGroups", furnitureGroups);
            request.getRequestDispatcher("/views/quotation-request.jsp").forward(request, response);

        } catch (RuntimeException e) {
            // Xử lý lỗi DB (ví dụ: không thể tải danh mục)
            request.setAttribute("errorMessage", "Lỗi hệ thống: Không thể tải dữ liệu danh mục.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        QuotationRequest req = new QuotationRequest();
        try {
            // 1) Lấy dữ liệu cơ bản
            req.setPickupAddress(request.getParameter("pickupAddress"));
            req.setDropoffAddress(request.getParameter("dropoffAddress"));

            String moveDateStr = request.getParameter("moveDate");
            if (moveDateStr != null && !moveDateStr.isEmpty()) {
                req.setMoveDate(LocalDate.parse(moveDateStr));
            }

            // Tùy chọn bổ sung
            String voucher = request.getParameter("voucherCode");
            req.setVoucherCode(voucher == null ? null : voucher.trim());
            req.setSpecialNotes(request.getParameter("specialNotes"));

            String manpower = request.getParameter("manpowerOption");
            req.setManpowerOption(manpower == null ? "NONE" : manpower);

            req.setHighValueItems(request.getParameter("highValueItems") != null);

            // 2) Đọc mảng phẳng itemIds/quantities
            String[] idArr  = request.getParameterValues("itemIds");
            String[] qtyArr = request.getParameterValues("quantities");

            List<ItemRequest> items = new ArrayList<>();
            if (idArr != null && qtyArr != null) {
                int n = Math.min(idArr.length, qtyArr.length);
                Map<Integer, Integer> sum = new LinkedHashMap<>();
                for (int i = 0; i < n; i++) {
                    try {
                        int id  = Integer.parseInt(idArr[i].trim());
                        int qty = Integer.parseInt(qtyArr[i].trim());
                        if (id > 0 && qty > 0) sum.merge(id, qty, Integer::sum);
                    } catch (Exception ignored) {}
                }
                for (Map.Entry<Integer, Integer> e : sum.entrySet()) {
                    ItemRequest it = new ItemRequest();
                    it.setItemId(e.getKey());
                    it.setQuantity(e.getValue());
                    items.add(it);
                }
            }

            if (items.isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng thêm ít nhất 1 món đồ.");
                request.setAttribute("quotation", req);
                repopulateFormAttributes(request);
                request.getRequestDispatcher("/views/quotation-request.jsp").forward(request, response);
                return;
            }

            // GÁN items VÀO req (điểm lỗi trước đây)
            req.setItemRequests(items);

            // 3) Tính toán & Lưu DB
            QuotationRequest savedRequest = quotationDAO.processQuotation(req);

            // 4) Redirect sang trang hợp đồng
            // (tuỳ chọn: không cần lưu session nếu contract.jsp tự load từ DB theo ID)
            request.getSession().setAttribute("currentQuotation", savedRequest);
            response.sendRedirect(request.getContextPath() + "/contract?quotationId=" + savedRequest.getQuotationID());

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("quotation", req);
            repopulateFormAttributes(request);
            request.getRequestDispatcher("/views/quotation-request.jsp").forward(request, response);

        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", "Lỗi khi xử lý báo giá: " + e.getMessage());
            request.setAttribute("quotation", req);
            repopulateFormAttributes(request);
            request.getRequestDispatcher("/views/quotation-request.jsp").forward(request, response);
        }
    }


    /**
     * Phương thức phân tích danh sách ItemRequest mạnh mẽ hơn.
     * Sử dụng regex để xử lý các tham số dạng: itemRequests[i].itemId và itemRequests[i].quantity
     */
    private List<ItemRequest> parseItemRequests(HttpServletRequest request) {

        // Lấy tất cả các tên tham số (parameter names)
        Map<String, String[]> params = request.getParameterMap();

        // Pattern để tìm chỉ số [i] từ tên tham số (ví dụ: "itemRequests[0].itemId")
        // Regex: tìm itemRequests[<chữ số>]
        Pattern indexPattern = Pattern.compile("itemRequests\\[(\\d+)\\]");

        // Map tạm để nhóm itemId và quantity theo cùng một index
        Map<Integer, ItemRequest> itemMap = new HashMap<>();

        for (String paramName : params.keySet()) {
            Matcher matcher = indexPattern.matcher(paramName);

            if (matcher.find()) {
                int index = Integer.parseInt(matcher.group(1)); // Lấy index (0, 1, 2, ...)
                String[] values = params.get(paramName); // Lấy mảng giá trị (thường chỉ có 1 phần tử)
                String value = (values.length > 0) ? values[0] : ""; // Lấy giá trị chuỗi

                // 💡 KIỂM TRA: Bỏ qua các giá trị rỗng/null, vì giá trị rỗng sẽ gây NumberFormatException
                if (value.trim().isEmpty()) {
                    continue;
                }

                // Khởi tạo hoặc lấy ItemRequest từ map
                ItemRequest item = itemMap.computeIfAbsent(index, k -> new ItemRequest());

                try {
                    // Chúng ta không cần kiểm tra value == null nữa nhờ logic ở trên
                    if (paramName.endsWith(".itemId")) {
                        item.setItemId(Integer.parseInt(value));
                    } else if (paramName.endsWith(".quantity")) {
                        item.setQuantity(Integer.parseInt(value));
                    }
                } catch (NumberFormatException e) {
                    // Log lỗi và bỏ qua item không hợp lệ
                    System.err.println("Dữ liệu ItemRequest không hợp lệ (Không phải số): " + paramName + " = " + value);
                }
            }
        }

        // Lọc ra các ItemRequest hợp lệ (itemId và quantity > 0)
        List<ItemRequest> validItems = itemMap.values().stream()
                .filter(item -> item.getItemId() > 0 && item.getQuantity() > 0)
                .collect(Collectors.toList());

        System.out.println("DEBUG: Số lượng items hợp lệ sau xử lý: " + validItems.size());

        return validItems;
    }

    // Phương thức trợ giúp để tải lại danh mục khi có lỗi
    private void repopulateFormAttributes(HttpServletRequest request) {
        try {
            Map<String, List<FurnitureType>> furnitureGroups = quotationDAO.getGroupedFurnitureData();
            request.setAttribute("furnitureGroups", furnitureGroups);
        } catch (RuntimeException dbError) {
            // Xử lý lỗi nếu ngay cả việc tải danh mục cũng thất bại
            System.err.println("Lỗi nghiêm trọng: Không thể tải lại danh mục cho form. " + dbError.getMessage());
            request.setAttribute("furnitureGroups", new ArrayList<>());
        }
    }
}
