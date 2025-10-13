package com.assignment.furniture_moving_service_swp391.model;

public class ItemRequest {
    private Integer itemId;
    private Integer quantity;
    // Getters and Setters


    public ItemRequest() {
    }

    public ItemRequest(Integer itemId, Integer quantity) {
        this.itemId = itemId;
        this.quantity = quantity;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
