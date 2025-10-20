package com.assignment.furniture_moving_service_swp391.model;

import java.time.LocalDateTime;

public class Customer {

    private int customerID;
    private String fullName;
    private String phoneNumber;
    private String email;
    private LocalDateTime createdAt;

    // Constructor mặc định
    public Customer() {
    }

    // Constructor đầy đủ (có thể bỏ qua createdAt và customerID cho đối tượng mới)
    public Customer(String fullName, String phoneNumber, String email) {
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.email = email;
    }

    // --- Getters và Setters ---

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}