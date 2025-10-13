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
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    private final QuotationDAO quotationDAO = new QuotationDAO();

    // Bắt item động theo tên: itemRequests[0].itemId / itemRequests[0].quantity
    private static final Pattern ITEM_ID_KEY = Pattern.compile("^itemRequests\\[(\\d+)]\\.itemId$");
    private static final Pattern QTY_KEY     = Pattern.compile("^itemRequests\\[(\\d+)]\\.quantity$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            // 1. Tải danh mục đồ đạc cho các dropdown (SELECT/OPTGROUP)
            Map<String, List<FurnitureType>> furnitureGroups = quotationDAO.getGroupedFurnitureData();
            req.setAttribute("furnitureGroups", furnitureGroups);

            // 2. Khởi tạo model rỗng cho lần tải đầu tiên (để JSTL không bị NullPointerException)
            if (req.getAttribute("booking") == null) {
                req.setAttribute("booking", new QuotationRequest());
            }

            // 3. Chuyển hướng đến View (Thành công)
            req.getRequestDispatcher("/views/booking.jsp").forward(req, resp);

        } catch (RuntimeException e) {
            // Bắt lỗi DB/Logic nghiêm trọng từ DAO
            System.err.println("CRITICAL: Database loading error in doGet. " + e.getMessage());
            e.printStackTrace();

            // 4. Chuyển hướng đến trang lỗi an toàn
            req.setAttribute("errorMessage", "Hệ thống không thể tải dữ liệu khởi tạo. Vui lòng thử lại sau.");
            // Giả sử có trang error.jsp hoặc dùng booking.jsp để hiển thị lỗi
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        List<String> errors = new ArrayList<>();

        // 1) Đọc các field từ form
        QuotationRequest qr = new QuotationRequest();
        qr.setPickupAddress(trim(req.getParameter("pickupAddress")));
        qr.setDropoffAddress(trim(req.getParameter("dropoffAddress")));
        qr.setMoveDate(trim(req.getParameter("moveDate"))); // bạn đang dùng String trong model
        qr.setVoucherCode(trim(req.getParameter("voucherCode")));
        qr.setSpecialNotes(trim(req.getParameter("specialNotes")));
        qr.setHighValueItems(req.getParameter("highValueItems") != null);
        qr.setManpowerOption(Optional.ofNullable(req.getParameter("manpowerOption")).orElse("NONE"));

        // 2) Validate cơ bản
        if (isBlank(qr.getPickupAddress())) errors.add("Vui lòng nhập Địa chỉ Lấy hàng.");
        if (isBlank(qr.getDropoffAddress())) errors.add("Vui lòng nhập Địa chỉ Giao hàng.");
        if (isBlank(qr.getMoveDate())) errors.add("Vui lòng chọn Ngày chuyển.");

        // 3) Gom danh sách item động từ tham số
        Map<Integer, ItemRequest> tmp = new HashMap<>();
        Enumeration<String> names = req.getParameterNames();
        while (names.hasMoreElements()) {
            String key = names.nextElement();
            Matcher mId = ITEM_ID_KEY.matcher(key);
            Matcher mQty = QTY_KEY.matcher(key);

            if (mId.matches()) {
                int idx = Integer.parseInt(mId.group(1));
                ItemRequest ir = tmp.computeIfAbsent(idx, k -> new ItemRequest());
                String val = req.getParameter(key);
                if (!isBlank(val)) {
                    try { ir.setItemId(Integer.parseInt(val)); } catch (NumberFormatException ignored) {}
                }
            } else if (mQty.matches()) {
                int idx = Integer.parseInt(mQty.group(1));
                ItemRequest ir = tmp.computeIfAbsent(idx, k -> new ItemRequest());
                String val = req.getParameter(key);
                if (!isBlank(val)) {
                    try {
                        int q = Integer.parseInt(val);
                        ir.setQuantity(Math.max(1, q));
                    } catch (NumberFormatException ignored) {}
                }
            }
        }

        // Sắp xếp theo index & đưa vào request
        List<Integer> indices = new ArrayList<>(tmp.keySet());
        Collections.sort(indices);
        List<ItemRequest> items = new ArrayList<>();
        for (Integer i : indices) {
            ItemRequest ir = tmp.get(i);
            if (ir.getItemId() != null && ir.getQuantity() != null && ir.getQuantity() > 0) {
                items.add(ir);
            }
        }
        qr.setItemRequests(items);

        // (Không bắt buộc) yêu cầu ít nhất 1 món
        // if (items.isEmpty()) errors.add("Vui lòng thêm ít nhất 1 món đồ.");

        // 4) Nếu lỗi, forward trang lỗi
        if (!errors.isEmpty()) {
            // Tải lại furnitureGroups để SELECT/OPTGROUP không bị lỗi
            req.setAttribute("furnitureGroups", quotationDAO.getGroupedFurnitureData());

            // Giữ lại dữ liệu đã nhập (để JSTL hiển thị lại các giá trị)
            req.setAttribute("booking", qr);

            req.setAttribute("errors", errors);
            // Forward về trang booking chính để hiển thị lỗi và giữ lại dữ liệu
            req.getRequestDispatcher("/views/booking.jsp").forward(req, resp);
            return;
        }


        // 5) Gọi DAO để tính toán + lưu DB (có transaction bên trong QuotationDAO)
        try {
            QuotationRequest saved = quotationDAO.processQuotation(qr);

            // ... (logic chuyển hướng thành công) ...
            req.setAttribute("booking", saved);
            req.getRequestDispatcher("/views/select-carriers.jsp").forward(req, resp); // Giả định chuyển đến trang chọn carriers

        } catch (Exception ex) {
            // Xử lý lỗi tính toán/DB
            errors.add("Có lỗi khi xử lý báo giá: " + ex.getMessage());

            // Tải lại furnitureGroups và dữ liệu đã nhập
            req.setAttribute("furnitureGroups", quotationDAO.getGroupedFurnitureData());
            req.setAttribute("booking", qr);
            req.setAttribute("errors", errors);

            // Forward về booking.jsp
            req.getRequestDispatcher("/views/booking.jsp").forward(req, resp);
        }
    }

    // ---------------- helpers ----------------
    private static boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }
    private static String trim(String s) { return s == null ? null : s.trim(); }
}
