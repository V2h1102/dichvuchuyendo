package com.assignment.furniture_moving_service_swp391.dal;

import com.assignment.furniture_moving_service_swp391.model.*;
import com.assignment.furniture_moving_service_swp391.util.DatabaseConnection;

import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

import static com.assignment.furniture_moving_service_swp391.util.DatabaseConnection.getConnection;

/**
 * DAO tính toán & truy cập dữ liệu cho báo giá
 */
public class QuotationDAO {

    // Phụ phí đồ giá trị cao (VND)
    private static final double HIGH_VALUE_ITEM_FEE = 100_000.0;
    // ... các thuộc tính và phương thức khác giữ nguyên ...

    // ===========================
    // PHẦN LOGIC KINH DOANH (tối ưu tính toán)
    // ===========================

    /**
     * Phương thức tính toán chi phí đầy đủ (Tải, Xe, Phí nhân công, Giảm giá)
     */
    private void calculateTotalCost(QuotationRequest req) {
        // 1) Tính tổng tải
        double totalLoadFactor = 0.0;
        for (ItemRequest item : req.getItemRequests()) {
            FurnitureType ft = this.getFurnitureTypeById(item.getItemId());
            if (ft == null) {
                throw new RuntimeException("Không tìm thấy FurnitureType ID=" + item.getItemId());
            }
            totalLoadFactor += ft.getLoadFactor() * item.getQuantity();
        }
        req.setTotalLoadFactor(totalLoadFactor);

        // 2) Chọn loại xe & base rate (theo tổng tải)
        VehicleType vehicle = this.getAppropriateVehicle(totalLoadFactor);
        if (vehicle == null) {
            throw new RuntimeException("Không có VehicleType phù hợp cho tải: " + totalLoadFactor);
        }
        req.setSelectedVehicleTypeID(vehicle.getVehicleTypeId());
        req.setBaseRate(vehicle.getBaseFee());

        // 3) Phụ phí đồ giá trị cao
        double highValueSurcharge = req.isHighValueItems() ? HIGH_VALUE_ITEM_FEE : 0.0;

        // 4) Phụ phí nhân công (Manpower)
        ExtraService manpower = this.getExtraServiceByCode(req.getManpowerOption());
        double manpowerFee = (manpower != null) ? manpower.getFee() : 0.0;

        // Tổng Surcharge = HighValue + Manpower
        double totalSurcharge = highValueSurcharge + manpowerFee;
        req.setSurcharge(totalSurcharge);


        // 5) Tính SubTotal (trước giảm giá)
        double subTotal = req.getBaseRate() + totalSurcharge;


        // 6) Tính Discount (áp dụng sau khi có subTotal)
        double discount = this.calculateDiscount(req.getVoucherCode(), subTotal);
        req.setDiscount(discount);


        // 7) Tổng chi phí cuối cùng
        double totalCost = subTotal - discount;
        req.setTotalCost(Math.max(0.0, totalCost)); // Đảm bảo chi phí không âm
    }

    /**
     * SỬA ĐỔI: Phương thức chính để xử lý, tính toán và lưu Quotation
     */
    public QuotationRequest processQuotation(QuotationRequest req) {
        // 1) THÊM: Tính toán chi phí đầy đủ trước khi lưu
        this.calculateTotalCost(req);

        // 2) Lưu DB trong transaction
        try (Connection cn = getConnection()) {
            boolean oldAuto = cn.getAutoCommit();
            cn.setAutoCommit(false);
            try {
                // Lưu QuotationRequest chính
                QuotationRequest saved = this.saveQuotationRequest(cn, req);

                // Lưu danh sách Item chi tiết
                this.saveQuotationItems(cn, saved.getQuotationID(), saved.getItemRequests());

                // Commit giao dịch
                cn.commit();
                return saved;
            } catch (Exception ex) {
                // Rollback nếu có lỗi
                cn.rollback();
                throw ex;
            } finally {
                // Khôi phục trạng thái AutoCommit ban đầu
                cn.setAutoCommit(oldAuto);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi DB khi lưu QuotationRequest", e);
        }
    }


    // ===========================
    // PHẦN TRUY CẬP DỮ LIỆU (JDBC)
    // ===========================

    /**
     * 1) Lấy FurnitureType theo ID
     */
    public FurnitureType getFurnitureTypeById(int itemId) {
        String sql = """
                    SELECT FurnitureTypeID, Name, LoadFactor
                    FROM FurnitureType
                    WHERE FurnitureTypeID = ?
                """;
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    FurnitureType ft = new FurnitureType();
                    ft.setFurnitureTypeID(rs.getInt("FurnitureTypeID"));
                    ft.setName(rs.getString("Name"));
                    ft.setLoadFactor(rs.getDouble("LoadFactor"));
                    return ft;
                }
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getFurnitureTypeById", e);
        }
    }

    /**
     * 2) Lấy VehicleType phù hợp với tổng tải.
     * Nếu không có xe nào MaxLoadFactor >= totalLoadFactor, chọn xe lớn nhất có sẵn.
     */
    public VehicleType getAppropriateVehicle(double totalLoadFactor) {
        String sql = """
                    SELECT VehicleTypeID, Name, MaxLoadFactor, BaseFee
                    FROM VehicleType
                    WHERE MaxLoadFactor >= ?
                    ORDER BY MaxLoadFactor ASC
                """;

        VehicleType vehicle = null;
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            // Cố gắng tìm xe nhỏ nhất đủ tải
            ps.setDouble(1, totalLoadFactor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    vehicle = new VehicleType();
                    vehicle.setVehicleTypeId(rs.getInt("VehicleTypeID"));
                    vehicle.setName(rs.getString("Name"));
                    vehicle.setMaxLoadFactor(rs.getDouble("MaxLoadFactor"));
                    vehicle.setBaseFee(rs.getDouble("BaseFee"));
                    return vehicle;
                }
            }

            // Nếu không tìm thấy xe đủ tải (MaxLoadFactor < totalLoadFactor),
            // Lấy xe lớn nhất có sẵn trong DB để xử lý (giả định là mức phí tối đa)
            if (vehicle == null) {
                String fallbackSql = """
                            SELECT TOP 1 VehicleTypeID, Name, MaxLoadFactor, BaseFee
                            FROM VehicleType
                            ORDER BY MaxLoadFactor DESC
                        """;
                try (Statement st = cn.createStatement();
                     ResultSet rs = st.executeQuery(fallbackSql)) {
                    if (rs.next()) {
                        vehicle = new VehicleType();
                        vehicle.setVehicleTypeId(rs.getInt("VehicleTypeID"));
                        vehicle.setName(rs.getString("Name"));
                        vehicle.setMaxLoadFactor(rs.getDouble("MaxLoadFactor"));
                        vehicle.setBaseFee(rs.getDouble("BaseFee"));
                    }
                }
            }

            // Nếu vẫn là null (không có xe nào trong DB)
            if (vehicle == null) {
                throw new RuntimeException("Không tìm thấy VehicleType nào trong hệ thống.");
            }

            return vehicle;

        } catch (SQLException e) {
            throw new RuntimeException("Error getAppropriateVehicle", e);
        }
    }

    /**
     * 3) Lấy ExtraService theo OptionCode (vd: TWO_MAN, THREE_MAN)
     */
    public ExtraService getExtraServiceByCode(String optionCode) {
        if (optionCode == null || optionCode.isBlank()) return null;
        String sql = """
                    SELECT OptionCode, Name, Fee
                    FROM ExtraService
                    WHERE OptionCode = ?
                """;
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, optionCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ExtraService es = new ExtraService();
                    es.setOptionCode(rs.getString("OptionCode"));
                    es.setName(rs.getString("Name"));
                    es.setFee(rs.getDouble("Fee"));
                    return es;
                }
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getExtraServiceByCode", e);
        }
    }

    /**
     * 4) Tính discount theo voucherCode (hỗ trợ PERCENT/FIXED, kiểm tra hạn & active)
     */
    public double calculateDiscount(String voucherCode) {
        // Giữ tương thích chữ ký cũ
        return calculateDiscount(voucherCode, 0.0);
    }

    public double calculateDiscount(String voucherCode, double subTotal) {
        if (voucherCode == null || voucherCode.isBlank()) return 0.0;

        String sql = """
                    SELECT code, discountType, discountValue, expirationDate, status, MinimumCost
                    FROM Coupons
                    WHERE code = ?
                      AND status = 'ACTIVE' -- Giả định 'ACTIVE' là trạng thái voucher đang hoạt động
                      AND (expirationDate IS NULL OR expirationDate >= CAST(GETDATE() AS date))
                """;
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, voucherCode.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return 0.0;

                // Ánh xạ tên cột mới
                String type = rs.getString("discountType");      // Tên cột: discountType
                double value = rs.getDouble("discountValue");    // Tên cột: discountValue

                // Xử lý logic giảm giá
                // Cần xác nhận giá trị trong cột discountType là gì: PERCENTAGE/FIXED_AMOUNT hay PERCENT/FIXED
                if ("PERCENT".equalsIgnoreCase(type)) {
                    return Math.round(subTotal * (value / 100.0));
                } else if ("FIXED".equalsIgnoreCase(type)) {
                    return value;
                }
                return 0.0;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error calculateDiscount using Coupons table", e);
        }
    }

    /**
     * 5) Lưu QuotationRequest (dùng Connection ngoài để gói chung transaction)
     */
    public QuotationRequest saveQuotationRequest(Connection cn, QuotationRequest req) {
        String sql = """
                    INSERT INTO QuotationRequest
                      (PickupAddress, DropoffAddress, MoveDate,
                       SelectedVehicleTypeID, BaseRate, Surcharge, Discount, TotalCost,
                       HighValueItems, ManpowerOption, VoucherCode, TotalLoadFactor, SpecialNotes,
                       CreatedAt)
                    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?, GETDATE());
                """;
        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, req.getPickupAddress());
            ps.setString(2, req.getDropoffAddress());
            if (req.getMoveDate() != null) {
                ps.setDate(3, Date.valueOf(req.getMoveDate()));
            } else {
                ps.setNull(3, Types.DATE);
            }
            ps.setInt(4, req.getSelectedVehicleTypeID());
            ps.setDouble(5, req.getBaseRate());
            ps.setDouble(6, req.getSurcharge());
            ps.setDouble(7, req.getDiscount());
            ps.setDouble(8, req.getTotalCost());
            ps.setBoolean(9, req.isHighValueItems());
            ps.setString(10, req.getManpowerOption());
            ps.setString(11, req.getVoucherCode());
            ps.setDouble(12, req.getTotalLoadFactor());
            ps.setString(13, req.getSpecialNotes());

            int affected = ps.executeUpdate();
            if (affected == 0) throw new SQLException("Insert QuotationRequest failed, no rows affected.");

            // Lấy ID vừa tạo
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    req.setQuotationID(keys.getInt(1));
                } else {
                    // Fallback cho SQL Server nếu chưa trả về keys
                    try (Statement st = cn.createStatement();
                         ResultSet rs = st.executeQuery("SELECT CAST(SCOPE_IDENTITY() AS int) AS id")) {
                        if (rs.next()) req.setQuotationID(rs.getInt("id"));
                    }
                }
            }
            return req;
        } catch (SQLException e) {
            throw new RuntimeException("Error saveQuotationRequest", e);
        }
    }


    /**
     * 6) Lưu danh sách Item (batch)
     */
    public void saveQuotationItems(Connection cn, int quotationId, List<ItemRequest> items) {
        if (items == null || items.isEmpty()) return;
        String sql = """
                    INSERT INTO QuotationItem (QuotationID, FurnitureTypeID, Quantity)
                    VALUES (?,?,?)
                """;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            for (ItemRequest it : items) {
                ps.setInt(1, quotationId);
                ps.setInt(2, it.getItemId());
                ps.setInt(3, it.getQuantity());
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            throw new RuntimeException("Error saveQuotationItems", e);
        }
    }


    // public List<FurnitureType> getAllFurnitureTypes()
    public List<FurnitureType> getAllFurnitureTypes() throws SQLException {
        List<FurnitureType> furnitureList = new ArrayList<>();
        String sql = "SELECT FurnitureTypeID, CategoryID, Name, LoadFactor FROM FurnitureType";

        // Sử dụng try-with-resources để tự động đóng Connection, PreparedStatement, và ResultSet
        try (Connection conn = DatabaseConnection.getConnection(); // SỬ DỤNG UTILITY CLASS
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                FurnitureType ft = new FurnitureType();

                ft.setFurnitureTypeID(rs.getInt("FurnitureTypeID"));
                ft.setCategoryID(rs.getInt("CategoryID"));
                ft.setName(rs.getString("Name"));
                ft.setLoadFactor(rs.getDouble("LoadFactor"));

                furnitureList.add(ft);
            }
        } catch (SQLException e) {
            // Log đã được xử lý trong DatabaseConnection, nhưng chúng ta ném lại để Controller xử lý lỗi nghiệp vụ
            throw e;
        }
        return furnitureList;
    }

    // lấy tất cả category
    public List<FurnitureCategory> getAllCategories() throws SQLException {
        List<FurnitureCategory> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, Name FROM FurnitureCategory";

        // Sử dụng try-with-resources để tự động đóng tài nguyên
        try (Connection conn = DatabaseConnection.getConnection(); // SỬ DỤNG UTILITY CLASS
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                FurnitureCategory cat = new FurnitureCategory();
                cat.setCategoryID(rs.getInt("CategoryID"));
                cat.setName(rs.getString("Name"));
                categories.add(cat);
            }
        } catch (SQLException e) {
            // Ném ngoại lệ để tầng Controller/Logic xử lý
            throw e;
        }
        return categories;
    }

    public Map<String, List<FurnitureType>> getGroupedFurnitureData() {
        List<FurnitureType> allTypes;
        List<FurnitureCategory> allCategories;

        try {
            // 1. Truy vấn tất cả dữ liệu cần thiết (Cần bọc bằng try-catch vì chúng ném SQLException)
            allTypes = this.getAllFurnitureTypes();
            allCategories = this.getAllCategories();
        } catch (SQLException e) {
            // Lỗi xảy ra khi truy vấn DB, không thể tiếp tục nhóm dữ liệu
            System.err.println("Lỗi DB khi lấy dữ liệu Furniture để nhóm: " + e.getMessage());

            // Ném RuntimeException để tầng Controller xử lý lỗi nghiêm trọng này
            throw new RuntimeException("Không thể tải dữ liệu danh mục từ cơ sở dữ liệu.", e);
        }

        // 2. Nhóm dữ liệu (Sử dụng LinkedHashMap để giữ thứ tự của Categories)
        Map<String, List<FurnitureType>> furnitureGroups = new LinkedHashMap<>();

        for (FurnitureCategory cat : allCategories) {
            // Sử dụng Java Stream để lọc và nhóm
            List<FurnitureType> itemsInCategory = allTypes.stream()
                    .filter(ft -> ft.getCategoryID() == cat.getCategoryID())
                    .collect(Collectors.toList());

            furnitureGroups.put(cat.getName(), itemsInCategory);
        }

        return furnitureGroups;
    }

    // 1) Lấy quotation theo ID
    public QuotationRequest getQuotationById(int quotationId) {
        String sql = """
                SELECT QuotationID, PickupAddress, DropoffAddress, MoveDate,
                       TotalLoadFactor, SelectedVehicleTypeID, BaseRate, Surcharge, Discount, TotalCost,
                       Status, SpecialNotes, VoucherCode, ManpowerOption, HighValueItems, CreatedAt, CustomerID
                FROM QuotationRequest
                WHERE QuotationID = ?
            """;
        try (Connection cn = DatabaseConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, quotationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    QuotationRequest q = new QuotationRequest();

                    // 1. Ánh xạ các trường cơ bản
                    q.setQuotationID(rs.getInt("QuotationID"));
                    q.setPickupAddress(rs.getString("PickupAddress"));
                    q.setDropoffAddress(rs.getString("DropoffAddress"));

                    // 2. Xử lý Date và các giá trị tính toán
                    java.sql.Date moveDateSql = rs.getDate("MoveDate");
                    if (moveDateSql != null) {
                        q.setMoveDate(moveDateSql.toLocalDate());
                    }

                    q.setTotalLoadFactor(rs.getDouble("TotalLoadFactor"));
                    q.setSelectedVehicleTypeID(rs.getInt("SelectedVehicleTypeID"));
                    q.setBaseRate(rs.getDouble("BaseRate"));
                    q.setSurcharge(rs.getDouble("Surcharge"));
                    q.setDiscount(rs.getDouble("Discount"));
                    q.setTotalCost(rs.getDouble("TotalCost"));
                    q.setHighValueItems(rs.getBoolean("HighValueItems"));
                    q.setManpowerOption(rs.getString("ManpowerOption"));
                    q.setVoucherCode(rs.getString("VoucherCode"));
                    q.setSpecialNotes(rs.getString("SpecialNotes"));
                    q.setStatus(rs.getString("Status"));
                    q.setCustomerID(rs.getInt("CustomerID"));

                    // Xử lý CreatedAt (Nếu cần)
                    java.sql.Timestamp createdAtTimestamp = rs.getTimestamp("CreatedAt");
                    if (createdAtTimestamp != null) {
                        q.setCreatedAt(createdAtTimestamp.toLocalDateTime().toLocalDate());
                    }

                    return q;
                }
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getQuotationById", e);
        }
    }

    public List<QuotationRequest> getAllQuotations() {
        List<QuotationRequest> list = new ArrayList<>();

        String sql = """
                    SELECT QuotationID, PickupAddress, DropoffAddress, MoveDate,
                           TotalLoadFactor, SelectedVehicleTypeID, BaseRate, Surcharge,
                           Discount, TotalCost, HighValueItems, ManpowerOption, VoucherCode,
                           SpecialNotes, Status, CreatedAt
                    FROM QuotationRequest
                    ORDER BY QuotationID DESC
                """;

        try (Connection cn = DatabaseConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                QuotationRequest q = new QuotationRequest();
                q.setQuotationID(rs.getInt("QuotationID"));
                q.setPickupAddress(rs.getString("PickupAddress"));
                q.setDropoffAddress(rs.getString("DropoffAddress"));

                Date moveDate = rs.getDate("MoveDate");
                q.setMoveDate(moveDate != null ? moveDate.toLocalDate() : null);

//                q.setTotalLoadFactor(rs.getDouble("TotalLoadFactor"));
//                q.setSelectedVehicleTypeID(rs.getInt("SelectedVehicleTypeID"));
                q.setBaseRate(rs.getDouble("BaseRate"));
                q.setSurcharge(rs.getDouble("Surcharge"));
                q.setDiscount(rs.getDouble("Discount"));
                q.setTotalCost(rs.getDouble("TotalCost"));
                q.setHighValueItems(rs.getBoolean("HighValueItems"));
                q.setManpowerOption(rs.getString("ManpowerOption"));
                q.setVoucherCode(rs.getString("VoucherCode"));
                q.setSpecialNotes(rs.getString("SpecialNotes"));
                q.setStatus(rs.getString("Status"));

                Timestamp createdAt = rs.getTimestamp("CreatedAt");
                if (createdAt != null) {
                    q.setCreatedAt(LocalDate.from(createdAt.toLocalDateTime()));
                }

                list.add(q);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error getAllQuotations", e);
        }

        return list;
    }
// Trong QuotationDAO.java

    /**
     * 7) Lấy danh sách ItemRequest chi tiết theo QuotationID
     */
    public List<ItemRequest> getQuotationItems(int quotationId) {
        List<ItemRequest> items = new ArrayList<>();
        String sql = """
                SELECT qi.FurnitureTypeID, qi.Quantity, ft.Name as FurnitureName 
                FROM QuotationItem qi
                JOIN FurnitureType ft ON qi.FurnitureTypeID = ft.FurnitureTypeID
                WHERE qi.QuotationID = ?
            """;

        try (Connection cn = DatabaseConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, quotationId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ItemRequest ir = new ItemRequest();
                    ir.setItemId(rs.getInt("FurnitureTypeID"));
                    ir.setQuantity(rs.getInt("Quantity"));
                    ir.setFurnitureName(rs.getString("FurnitureName"));

                    items.add(ir);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching quotation items", e);
        }
        return items;
    }

    /**
     * 1. Lưu hoặc lấy CustomerID hiện có dựa trên số điện thoại.
     */
    public int saveOrGetCustomer(String fullName, String phoneNumber, String email) throws SQLException {

        // 1. Kiểm tra tồn tại (Sử dụng SĐT là duy nhất)
        String checkSql = "SELECT CustomerID FROM Customer WHERE PhoneNumber = ?";
        try (Connection cn = DatabaseConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(checkSql)) {
            ps.setString(1, phoneNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("CustomerID"); // Khách hàng đã tồn tại
                }
            }
        }

        // 2. Nếu chưa tồn tại, INSERT mới
        String insertSql = "INSERT INTO Customer (FullName, PhoneNumber, Email, CreatedAt) VALUES (?, ?, ?, GETDATE())";
        try (Connection cn = DatabaseConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, fullName);
            ps.setString(2, phoneNumber);

            if (email != null && !email.isEmpty()) {
                ps.setString(3, email);
            } else {
                ps.setNull(3, Types.VARCHAR);
            }

            ps.executeUpdate();

            // Lấy ID mới tạo
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
                throw new SQLException("Không thể lấy CustomerID mới tạo.");
            }
        }
    }


    /**
     * 2. Cập nhật QuotationRequest với CustomerID, SĐT Người nhận, Ghi chú và Trạng thái.
     */
    public void updateQuotationWithCustomerInfo(int quotationId, int customerId, String receiverPhone, String specialNotes) throws SQLException {
        String sql = """
                UPDATE QuotationRequest
                SET CustomerID = ?, ReceiverPhone = ?, SpecialNotes = ?
                WHERE QuotationID = ?
                """;
        try (Connection cn = DatabaseConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ps.setString(2, receiverPhone);
            ps.setString(3, specialNotes);
            ps.setInt(4, quotationId);

            ps.executeUpdate();
        }
    }


    /**
     * 3. Phương thức cập nhật trạng thái (giữ nguyên).
     */
    public void updateQuotationStatus(int quotationId, String status) throws SQLException {
        String sql = "UPDATE QuotationRequest SET Status = ? WHERE QuotationID = ?";
        try (Connection cn = DatabaseConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, quotationId);

            ps.executeUpdate();
        }
    }
    // lưu thông tin người dùng sau khi gửi yêu cầu xác nhận hợp đồng
    public void saveCustomerInfoToQuotation(int quotationId, String customerName,
                                            String customerPhone, String specialNotes) throws SQLException {
        String sql = """
        UPDATE QuotationRequests
           SET customerName = ?, customerPhone = ?, specialNotes = ?
         WHERE quotationID = ?
    """;
        try (Connection cn = DatabaseConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, customerName);
            ps.setString(2, customerPhone);
            if (specialNotes == null || specialNotes.isBlank()) {
                ps.setNull(3, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(3, specialNotes.trim());
            }
            ps.setInt(4, quotationId);
            ps.executeUpdate();
        }
    }

}
