package com.assignment.furniture_moving_service_swp391.model;


public class QuotationItem {

    private int quotationItemID;

    private int quotationID;

    private int furnitureTypeID;

    private int quantity;


    public QuotationItem() {
    }

    public QuotationItem(int quotationItemID, int quotationID, int furnitureTypeID, int quantity) {
        this.quotationItemID = quotationItemID;
        this.quotationID = quotationID;
        this.furnitureTypeID = furnitureTypeID;
        this.quantity = quantity;
    }

    public QuotationItem(int quotationID, int furnitureTypeID, int quantity) {
        this.quotationID = quotationID;
        this.furnitureTypeID = furnitureTypeID;
        this.quantity = quantity;
    }

    // ======================================
    // 2. GETTERS VÀ SETTERS
    // ======================================

    public int getQuotationItemID() {
        return quotationItemID;
    }

    public void setQuotationItemID(int quotationItemID) {
        this.quotationItemID = quotationItemID;
    }

    public int getQuotationID() {
        return quotationID;
    }

    public void setQuotationID(int quotationID) {
        this.quotationID = quotationID;
    }

    public int getFurnitureTypeID() {
        return furnitureTypeID;
    }

    public void setFurnitureTypeID(int furnitureTypeID) {
        this.furnitureTypeID = furnitureTypeID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}