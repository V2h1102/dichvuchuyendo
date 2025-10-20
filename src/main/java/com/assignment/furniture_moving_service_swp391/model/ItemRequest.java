package com.assignment.furniture_moving_service_swp391.model;

public class ItemRequest {
    private Integer itemId;
    private Integer quantity;
    private String furnitureName;
    // Getters and Setters


    public ItemRequest() {
    }

    public ItemRequest(Integer itemId, Integer quantity, String furnitureName) {
        this.itemId = itemId;
        this.quantity = quantity;
        this.furnitureName = furnitureName;
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

    public String getFurnitureName() {
        return furnitureName;
    }

    public void setFurnitureName(String furnitureName) {
        this.furnitureName = furnitureName;
    }
}
