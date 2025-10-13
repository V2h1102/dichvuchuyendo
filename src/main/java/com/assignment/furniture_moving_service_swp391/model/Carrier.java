package com.assignment.furniture_moving_service_swp391.model;

public class Carrier {
    private int carrierID;
    private String name;
    private String iconClass;
    private String estimatedDeliveryTime;
    private double baseFee;
    private double multiplier;

    // Các trường tính toán tạm thời để hiển thị trong JSP
    private double totalPrice;
    private double carrierFee;

    // Constructor, Getters, và Setters

    public Carrier() {
    }

    public Carrier(int carrierID, String name, String iconClass, String estimatedDeliveryTime, double baseFee, double multiplier, double totalPrice, double carrierFee) {
        this.carrierID = carrierID;
        this.name = name;
        this.iconClass = iconClass;
        this.estimatedDeliveryTime = estimatedDeliveryTime;
        this.baseFee = baseFee;
        this.multiplier = multiplier;
        this.totalPrice = totalPrice;
        this.carrierFee = carrierFee;
    }

    public int getCarrierID() {
        return carrierID;
    }

    public void setCarrierID(int carrierID) {
        this.carrierID = carrierID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIconClass() {
        return iconClass;
    }

    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
    }

    public String getEstimatedDeliveryTime() {
        return estimatedDeliveryTime;
    }

    public void setEstimatedDeliveryTime(String estimatedDeliveryTime) {
        this.estimatedDeliveryTime = estimatedDeliveryTime;
    }

    public double getBaseFee() {
        return baseFee;
    }

    public void setBaseFee(double baseFee) {
        this.baseFee = baseFee;
    }

    public double getMultiplier() {
        return multiplier;
    }

    public void setMultiplier(double multiplier) {
        this.multiplier = multiplier;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public double getCarrierFee() {
        return carrierFee;
    }

    public void setCarrierFee(double carrierFee) {
        this.carrierFee = carrierFee;
    }
}
