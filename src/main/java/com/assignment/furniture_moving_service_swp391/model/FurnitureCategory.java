package com.assignment.furniture_moving_service_swp391.model;

public class FurnitureCategory {

    // Thuộc tính ánh xạ trực tiếp từ cột DB
    private int categoryID;
    private String name;

    public FurnitureCategory() {
    }

    public FurnitureCategory(int categoryID, String name) {
        this.categoryID = categoryID;
        this.name = name;
    }

    // Getters and Setters

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Tùy chọn: Phương thức toString() để dễ dàng debug
    @Override
    public String toString() {
        return "FurnitureCategory{" +
                "categoryID=" + categoryID +
                ", name='" + name + '\'' +
                '}';
    }
}