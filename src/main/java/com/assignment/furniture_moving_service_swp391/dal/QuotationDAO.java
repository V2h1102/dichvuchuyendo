package com.assignment.furniture_moving_service_swp391.dal;

import com.assignment.furniture_moving_service_swp391.model.*;
import com.assignment.furniture_moving_service_swp391.util.DatabaseConnection;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.util.stream.Collectors;

import static com.assignment.furniture_moving_service_swp391.util.DatabaseConnection.getConnection;

/** DAO tính toán & truy cập dữ liệu cho báo giá */
public class QuotationDAO {

    // Phụ phí đồ giá trị cao (VND)
    private static final double HIGH_VALUE_ITEM_FEE = 100_000.0;

    // ===========================
    // PHẦN LOGIC KINH DOANH
    // ===========================
    public QuotationRequest processQuotation(QuotationRequest req) {
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

        // 2) Chọn loại xe & base rate
        VehicleType vehicle = this.getAppropriateVehicle(totalLoadFactor);
        if (vehicle == null) {
            throw new RuntimeException("Không có VehicleType phù hợp cho tải: " + totalLoadFactor);
        }
        req.setSelectedVehicleTypeID(vehicle.getVehicleTypeID());
        req.setBaseRate(vehicle.getBaseFee());

        // 3) Phụ phí
        double surcharge = 0.0;
        if (req.isHighValueItems()) {
            surcharge += HIGH_VALUE_ITEM_FEE;
        }
        if (req.getManpowerOption() != null && !req.getManpowerOption().isBlank()) {
            ExtraService manpower = this.getExtraServiceByCode(req.getManpowerOption());
            if (manpower != null) {
                surcharge += manpower.getFee();
            }
        }
        req.setSurcharge(surcharge);

        // 4) Discount (áp trên baseRate + surcharge theo logic hiện có)
        double discount = this.calculateDiscount(req.getVoucherCode(), req.getBaseRate() + req.getSurcharge());
        req.setDiscount(discount);

        double totalCost = req.getBaseRate() + req.getSurcharge() - req.getDiscount();
        req.setTotalCost(totalCost);

        // 5) Lưu DB trong 1 transaction
        try (Connection cn = getConnection()) {
            boolean oldAuto = cn.getAutoCommit();
            cn.setAutoCommit(false);
            try {
                QuotationRequest saved = this.saveQuotationRequest(cn, req);
                this.saveQuotationItems(cn, saved.getQuotationID(), saved.getItemRequests());
                cn.commit();
                return saved;
            } catch (Exception ex) {
                cn.rollback();
                throw ex;
            } finally {
                cn.setAutoCommit(oldAuto);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi DB khi lưu QuotationRequest", e);
        }
    }

    public List<Carrier> getAvailableCarriers(QuotationRequest quotation) {
        return this.getCarriersByVehicleType(quotation.getSelectedVehicleTypeID());
    }

    // ===========================
    // PHẦN TRUY CẬP DỮ LIỆU (JDBC)
    // ===========================

    /** 1) Lấy FurnitureType theo ID */
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

    /** 2) Lấy VehicleType phù hợp với tổng tải */
    public VehicleType getAppropriateVehicle(double totalLoadFactor) {
        String sql = """
            SELECT TOP 1 VehicleTypeID, Name, MaxLoadFactor, BaseFee
            FROM VehicleType
            WHERE MaxLoadFactor >= ?
            ORDER BY MaxLoadFactor ASC
        """;
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setDouble(1, totalLoadFactor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    VehicleType vt = new VehicleType();
                    vt.setVehicleTypeID(rs.getInt("VehicleTypeID"));
                    vt.setName(rs.getString("Name"));
                    vt.setMaxLoadFactor(rs.getDouble("MaxLoadFactor"));
                    vt.setBaseFee(rs.getDouble("BaseFee"));
                    return vt;
                }
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getAppropriateVehicle", e);
        }
    }

    /** 3) Lấy ExtraService theo OptionCode (vd: TWO_MAN, THREE_MAN) */
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

    /** 4) Tính discount theo voucherCode (hỗ trợ PERCENT/FIXED, kiểm tra hạn & active) */
    public double calculateDiscount(String voucherCode) {
        // Giữ tương thích chữ ký cũ
        return calculateDiscount(voucherCode, 0.0);
    }

    // Sửa lỗi trong QuotationDAO.java
    public double calculateDiscount(String voucherCode, double subTotal) {
        if (voucherCode == null || voucherCode.isBlank()) return 0.0;

        // ĐÃ SỬA: Tên cột phải khớp với Voucher table: Code, DiscountType, DiscountValue, EndDate
        String sql = """
        SELECT Code, DiscountType, DiscountValue, IsActive, EndDate, MinimumCost
        FROM Voucher
        WHERE Code = ?
          AND IsActive = 1
          AND (EndDate IS NULL OR EndDate >= CAST(GETDATE() AS date))
    """;
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, voucherCode.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return 0.0;

                String type = rs.getString("DiscountType");   // Lấy từ cột DiscountType
                double value = rs.getDouble("DiscountValue"); // Lấy từ cột DiscountValue

                // Lấy MinimumCost để kiểm tra điều kiện áp dụng
                double minimumCost = rs.getDouble("MinimumCost");

                // **THÊM LOGIC KIỂM TRA MINIMUM COST**
                if (subTotal < minimumCost) return 0.0;

                // Xử lý logic giảm giá
                if ("PERCENTAGE".equalsIgnoreCase(type)) { // Dùng PERCENTAGE thay vì PERCENT
                    return Math.round(subTotal * (value / 100.0));
                } else if ("FIXED_AMOUNT".equalsIgnoreCase(type)) { // Dùng FIXED_AMOUNT thay vì FIXED
                    return value;
                }
                return 0.0;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error calculateDiscount", e);
        }
    }

    /** 5) Lưu QuotationRequest (dùng Connection ngoài để gói chung transaction) */
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

    /** Overload giữ tương thích (tự mở kết nối – không gom transaction với items) */
    public QuotationRequest saveQuotationRequest(QuotationRequest req) {
        try (Connection cn = getConnection()) {
            return saveQuotationRequest(cn, req);
        } catch (SQLException e) {
            throw new RuntimeException("Error saveQuotationRequest(connless)", e);
        }
    }

    /** 6) Lưu danh sách Item (batch) */
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

    /** Overload giữ tương thích (mở kết nối riêng) */
    public void saveQuotationItems(int quotationId, List<ItemRequest> items) {
        try (Connection cn = getConnection()) {
            saveQuotationItems(cn, quotationId, items);
        } catch (SQLException e) {
            throw new RuntimeException("Error saveQuotationItems(connless)", e);
        }
    }

    public List<Carrier> getCarriersByVehicleType(int vehicleTypeId) {
        String sql = """
        SELECT c.CarrierID, c.Name, c.IconClass, c.EstimatedDeliveryTime, 
               c.BaseFee, c.Multiplier
        FROM Carrier c
        JOIN CarrierVehicleType cvt ON cvt.CarrierID = c.CarrierID
        WHERE cvt.VehicleTypeID = ?
    """;
        List<Carrier> list = new ArrayList<>();
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, vehicleTypeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Carrier c = new Carrier();
                    c.setCarrierID(rs.getInt("CarrierID"));
                    c.setName(rs.getString("Name"));
                    c.setIconClass(rs.getString("IconClass"));
                    c.setEstimatedDeliveryTime(rs.getString("EstimatedDeliveryTime"));
                    c.setBaseFee(rs.getDouble("BaseFee"));
                    c.setMultiplier(rs.getDouble("Multiplier"));
                    list.add(c);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error getCarriersByVehicleType", e);
        }
        return list;
    }

    // Trong QuotationDAO.java (hoặc Service, nếu tách)


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

    // Trong QuotationDAO.java

    /**
     * 1. Lấy thông tin Carrier (Multiplier, BaseFee, v.v.)
     * 2. Tính toán TotalPrice và DepositAmount.
     * 3. Cập nhật các trường này và SelectedCarrierID vào DB.
     * @param quotationId ID của yêu cầu báo giá.
     * @param selectedCarrierId ID của Carrier được chọn.
     * @return QuotationRequest đã được cập nhật.
     */
    public QuotationRequest updateCarrierSelection(int quotationId, int selectedCarrierId) throws SQLException {
        // 1. Lấy QuotationRequest hiện tại (để có TotalCost)
        QuotationRequest req = this.getQuotationRequestById(quotationId);
        if (req == null) return null;

        // 2. Lấy Carrier được chọn
        Carrier carrier = this.getCarrierById(selectedCarrierId);
        if (carrier == null) throw new SQLException("Carrier ID not found: " + selectedCarrierId);

        // 3. TÍNH TOÁN CHI PHÍ CUỐI CÙNG
        double totalCostBeforeCarrier = req.getTotalCost(); // Chi phí đã tính toán (BaseRate + Surcharge - Discount)

        // Tính Phí Carrier (ví dụ: CarrierFee = Carrier.Multiplier * TotalCost)
        double carrierFee = carrier.getMultiplier() * totalCostBeforeCarrier;
        carrierFee += carrier.getBaseFee(); // Cộng thêm BaseFee của Carrier (nếu có)

        double totalPrice = totalCostBeforeCarrier + carrierFee;
        double depositAmount = totalPrice / 2.0;

        // 4. CẬP NHẬT DB
        String sql = """
        UPDATE QuotationRequest SET 
            SelectedCarrierID = ?, 
            CarrierFee = ?, 
            TotalPrice = ?, 
            DepositAmount = ?,
            Status = 'CARRIER_SELECTED'
        WHERE QuotationID = ?
    """;

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, ca);
            ps.setDouble(2, carrierFee);
            ps.setDouble(3, totalPrice);
            ps.setDouble(4, depositAmount);
            ps.setInt(5, quotationId);
            ps.executeUpdate();
        }

        // 5. Cập nhật Model và trả về
        req.se(selectedCarrierId);
        req.setCarrierFee(carrierFee);
        req.setTotalPrice(totalPrice);
        req.setDepositAmount(depositAmount);
        req.setStatus("CARRIER_SELECTED");

        return req;
    }

    // Yêu cầu phương thức phụ trợ để lấy thông tin chi tiết:
    public QuotationRequest getQuotationRequestById(int id) { /* ... JDBC implementation ... */ return new QuotationRequest(); }
    public Carrier getCarrierById(int id) { /* ... JDBC implementation ... */ return new Carrier(); }
}
