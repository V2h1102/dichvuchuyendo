package com.assignment.furniture_moving_service_swp391.model;

public class FurnitureType {
    private int furnitureTypeID;
    private int categoryID;
    private String name;
    private double loadFactor;
    // Getters and Setters

    public int getFurnitureTypeID() {
        return furnitureTypeID;
    }

    public void setFurnitureTypeID(int furnitureTypeID) {
        this.furnitureTypeID = furnitureTypeID;
    }

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

    public double getLoadFactor() {
        return loadFactor;
    }

    public void setLoadFactor(double loadFactor) {
        this.loadFactor = loadFactor;
    }
}
