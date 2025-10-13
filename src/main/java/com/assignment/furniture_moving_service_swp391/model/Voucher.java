package com.assignment.furniture_moving_service_swp391.model;

import java.time.LocalDate;

public class Voucher {

    // Thuộc tính ánh xạ trực tiếp từ cột DB
    private Integer voucherID;
    private String code;

    private String discountType;    // Ví dụ: "PERCENTAGE" hoặc "FIXED_AMOUNT"
    private double discountValue;   // Giá trị giảm (số tiền hoặc phần trăm)

    private Double minimumCost;     // Giá trị đơn hàng tối thiểu

    private LocalDate startDate;    // Ngày bắt đầu có hiệu lực
    private LocalDate endDate;      // Ngày hết hạn

    private Integer usageLimit;     // Giới hạn tổng số lần sử dụng
    private int usedCount;          // Số lần đã được sử dụng

    private boolean isActive;       // Trạng thái kích hoạt (BIT -> boolean)

    // Constructor mặc định
    public Voucher() {
    }

    // Constructor đầy đủ (Tùy chọn)
    public Voucher(Integer voucherID, String code, String discountType, double discountValue, Double minimumCost, LocalDate startDate, LocalDate endDate, Integer usageLimit, int usedCount, boolean isActive) {
        this.voucherID = voucherID;
        this.code = code;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minimumCost = minimumCost;
        this.startDate = startDate;
        this.endDate = endDate;
        this.usageLimit = usageLimit;
        this.usedCount = usedCount;
        this.isActive = isActive;
    }


    // Getters and Setters

    public Integer getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(Integer voucherID) {
        this.voucherID = voucherID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public Double getMinimumCost() {
        return minimumCost;
    }

    public void setMinimumCost(Double minimumCost) {
        this.minimumCost = minimumCost;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public Integer getUsageLimit() {
        return usageLimit;
    }

    public void setUsageLimit(Integer usageLimit) {
        this.usageLimit = usageLimit;
    }

    public int getUsedCount() {
        return usedCount;
    }

    public void setUsedCount(int usedCount) {
        this.usedCount = usedCount;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}