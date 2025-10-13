package com.assignment.furniture_moving_service_swp391.model;

public class VehicleType {
    private int vehicleTypeID;
    private String name;
    private double maxLoadFactor; // Quan trọng cho logic chọn xe
    private double baseFee;       // Quan trọng cho logic tính BaseRate
    private String description;

    // Constructor, Getters, và Setters


    public VehicleType() {
    }

    public VehicleType(int vehicleTypeID, String name, double maxLoadFactor, double baseFee, String description) {
        this.vehicleTypeID = vehicleTypeID;
        this.name = name;
        this.maxLoadFactor = maxLoadFactor;
        this.baseFee = baseFee;
        this.description = description;
    }

    public int getVehicleTypeID() {
        return vehicleTypeID;
    }

    public void setVehicleTypeID(int vehicleTypeID) {
        this.vehicleTypeID = vehicleTypeID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getMaxLoadFactor() {
        return maxLoadFactor;
    }

    public void setMaxLoadFactor(double maxLoadFactor) {
        this.maxLoadFactor = maxLoadFactor;
    }

    public double getBaseFee() {
        return baseFee;
    }

    public void setBaseFee(double baseFee) {
        this.baseFee = baseFee;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
