package com.assignment.furniture_moving_service_swp391.model;

import java.math.BigDecimal;

public class VehicleType {

    private Integer vehicleTypeId;
    private String name;
    private Double maxLoadFactor;
    private Double baseFee;
    private String description;
    private Integer numberOfVehicles;
    private String status;
    private Double maxCapacityLength;

    // ----- Constructors -----
    public VehicleType() {}

    public VehicleType(Integer vehicleTypeId, String name, Double maxLoadFactor, Double baseFee,
                       String description, Integer numberOfVehicles, String status, Double maxCapacityLength) {
        this.vehicleTypeId = vehicleTypeId;
        this.name = name;
        this.maxLoadFactor = maxLoadFactor;
        this.baseFee = baseFee;
        this.description = description;
        this.numberOfVehicles = numberOfVehicles;
        this.status = status;
        this.maxCapacityLength = maxCapacityLength;
    }

    // ----- Getters & Setters -----
    public Integer getVehicleTypeId() {
        return vehicleTypeId;
    }

    public void setVehicleTypeId(Integer vehicleTypeId) {
        this.vehicleTypeId = vehicleTypeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getMaxLoadFactor() {
        return maxLoadFactor;
    }

    public void setMaxLoadFactor(Double maxLoadFactor) {
        this.maxLoadFactor = maxLoadFactor;
    }

    public Double getBaseFee() {
        return baseFee;
    }

    public void setBaseFee(Double baseFee) {
        this.baseFee = baseFee;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getNumberOfVehicles() {
        return numberOfVehicles;
    }

    public void setNumberOfVehicles(Integer numberOfVehicles) {
        this.numberOfVehicles = numberOfVehicles;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Double getMaxCapacityLength() {
        return maxCapacityLength;
    }

    public void setMaxCapacityLength(Double maxCapacityLength) {
        this.maxCapacityLength = maxCapacityLength;
    }
}
