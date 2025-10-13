package com.assignment.furniture_moving_service_swp391.model;

import java.util.ArrayList;
import java.util.List;

public class QuotationRequest {
    // Khóa chính sau khi lưu
    private int quotationID;                 // <--- THÊM
    // Form inputs
    private String pickupAddress;
    private String dropoffAddress;
    private String moveDate;                 // đang để String; có thể đổi sang LocalDate sau
    private List<ItemRequest> itemRequests;  // Danh sách các món đồ
    private String voucherCode;
    private String specialNotes;
    private boolean highValueItems;
    private String manpowerOption;

    // Các trường tính toán
    private double totalLoadFactor;
    private int selectedVehicleTypeID;
    private double baseRate;
    private double surcharge;
    private double discount;                 // <--- THÊM
    private double totalCost;

    // ===== Constructors =====
    public QuotationRequest() {
        this.itemRequests = new ArrayList<>();
    }

    // ===== Getters & Setters =====
    public int getQuotationID() {
        return quotationID;
    }
    public void setQuotationID(int quotationID) {
        this.quotationID = quotationID;
    }

    public String getPickupAddress() {
        return pickupAddress;
    }
    public void setPickupAddress(String pickupAddress) {
        this.pickupAddress = pickupAddress;
    }

    public String getDropoffAddress() {
        return dropoffAddress;
    }
    public void setDropoffAddress(String dropoffAddress) {
        this.dropoffAddress = dropoffAddress;
    }

    public String getMoveDate() {
        return moveDate;
    }
    public void setMoveDate(String moveDate) {
        this.moveDate = moveDate;
    }

    public List<ItemRequest> getItemRequests() {
        return itemRequests;
    }
    public void setItemRequests(List<ItemRequest> itemRequests) {
        this.itemRequests = itemRequests;
    }

    public String getVoucherCode() {
        return voucherCode;
    }
    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getSpecialNotes() {
        return specialNotes;
    }
    public void setSpecialNotes(String specialNotes) {
        this.specialNotes = specialNotes;
    }

    public boolean isHighValueItems() {
        return highValueItems;
    }
    public void setHighValueItems(boolean highValueItems) {
        this.highValueItems = highValueItems;
    }

    public String getManpowerOption() {
        return manpowerOption;
    }
    public void setManpowerOption(String manpowerOption) {
        this.manpowerOption = manpowerOption;
    }

    public double getTotalLoadFactor() {
        return totalLoadFactor;
    }
    public void setTotalLoadFactor(double totalLoadFactor) {
        this.totalLoadFactor = totalLoadFactor;
    }

    public int getSelectedVehicleTypeID() {
        return selectedVehicleTypeID;
    }
    public void setSelectedVehicleTypeID(int selectedVehicleTypeID) {
        this.selectedVehicleTypeID = selectedVehicleTypeID;
    }

    public double getBaseRate() {
        return baseRate;
    }
    public void setBaseRate(double baseRate) {
        this.baseRate = baseRate;
    }

    public double getSurcharge() {
        return surcharge;
    }
    public void setSurcharge(double surcharge) {
        this.surcharge = surcharge;
    }

    public double getDiscount() {
        return discount;
    }
    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getTotalCost() {
        return totalCost;
    }
    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }
}
