package com.assignment.furniture_moving_service_swp391.model;

public class ExtraService {
    private String optionCode;
    private double fee;
    private String name;
    // Getters and Setters


    public ExtraService() {
    }

    public ExtraService(String optionCode, double fee, String name) {
        this.optionCode = optionCode;
        this.fee = fee;
        this.name = name;
    }

    public String getOptionCode() {
        return optionCode;
    }

    public void setOptionCode(String optionCode) {
        this.optionCode = optionCode;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
