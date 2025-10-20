package com.assignment.furniture_moving_service_swp391.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class QuotationRequest {
    // Khóa chính sau khi lưu
    private int quotationID;
    private int customerID;
    private String pickupAddress;
    private String dropoffAddress;
    private LocalDate moveDate;
    private List<ItemRequest> itemRequests;
    private String voucherCode;
    private String specialNotes;
    private boolean highValueItems;
    private String manpowerOption;
    private LocalDate createdAt;
    private String status;

    // Các trường tính toán
    private double totalLoadFactor;
    private int selectedVehicleTypeID;
    private double baseRate;
    private double surcharge;
    private double discount;
    private double totalCost;

    // ===== Constructors =====
    public QuotationRequest() {
        this.itemRequests = new ArrayList<>();
    }

    public QuotationRequest(String status, LocalDate createdAt, int quotationID, int customerID, String pickupAddress, String dropoffAddress, LocalDate moveDate, List<ItemRequest> itemRequests, String voucherCode, String specialNotes, boolean highValueItems, String manpowerOption, double totalLoadFactor, int selectedVehicleTypeID, double baseRate, double surcharge, double discount, double totalCost) {
        this.quotationID = quotationID;
        this.customerID = customerID;
        this.pickupAddress = pickupAddress;
        this.dropoffAddress = dropoffAddress;
        this.moveDate = moveDate;
        this.itemRequests = itemRequests;
        this.voucherCode = voucherCode;
        this.specialNotes = specialNotes;
        this.highValueItems = highValueItems;
        this.manpowerOption = manpowerOption;
        this.totalLoadFactor = totalLoadFactor;
        this.selectedVehicleTypeID = selectedVehicleTypeID;
        this.baseRate = baseRate;
        this.surcharge = surcharge;
        this.discount = discount;
        this.totalCost = totalCost;
        this.createdAt = createdAt;
        this.status = status;
    }

    // ===== Getters & Setters =====

    public int getCustomerID() {
        return customerID;
    }
    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getQuotationID() {
        return quotationID;
    }
    public void setQuotationID(int quotationID) {
        this.quotationID = quotationID;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdDate) {
        this.createdAt = createdDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPickupAddress() { return pickupAddress; }
    public void setPickupAddress(String pickupAddress) { this.pickupAddress = pickupAddress; }
    public String getDropoffAddress() { return dropoffAddress; }
    public void setDropoffAddress(String dropoffAddress) { this.dropoffAddress = dropoffAddress; }
    public LocalDate getMoveDate() { return moveDate; }
    public void setMoveDate(LocalDate moveDate) { this.moveDate = moveDate; }
    public List<ItemRequest> getItemRequests() { return itemRequests; }
    public void setItemRequests(List<ItemRequest> itemRequests) { this.itemRequests = itemRequests; }
    public String getVoucherCode() { return voucherCode; }
    public void setVoucherCode(String voucherCode) { this.voucherCode = voucherCode; }
    public String getSpecialNotes() { return specialNotes; }
    public void setSpecialNotes(String specialNotes) { this.specialNotes = specialNotes; }
    public boolean isHighValueItems() { return highValueItems; }
    public void setHighValueItems(boolean highValueItems) { this.highValueItems = highValueItems; }
    public String getManpowerOption() { return manpowerOption; }
    public void setManpowerOption(String manpowerOption) { this.manpowerOption = manpowerOption; }
    public double getTotalLoadFactor() { return totalLoadFactor; }
    public void setTotalLoadFactor(double totalLoadFactor) { this.totalLoadFactor = totalLoadFactor; }
    public int getSelectedVehicleTypeID() { return selectedVehicleTypeID; }
    public void setSelectedVehicleTypeID(int selectedVehicleTypeID) { this.selectedVehicleTypeID = selectedVehicleTypeID; }
    public double getBaseRate() { return baseRate; }
    public void setBaseRate(double baseRate) { this.baseRate = baseRate; }
    public double getSurcharge() { return surcharge; }
    public void setSurcharge(double surcharge) { this.surcharge = surcharge; }
    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }
    public double getTotalCost() { return totalCost; }
    public void setTotalCost(double totalCost) { this.totalCost = totalCost; }
}