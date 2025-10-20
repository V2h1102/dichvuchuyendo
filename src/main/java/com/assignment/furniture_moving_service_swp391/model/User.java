package com.assignment.furniture_moving_service_swp391.model;

import java.util.Date;

public class User {
    private long id;
    private String email;
    private String phone;
    private String passwordHash;
    private String fullName;
    private String avatarUrl;
    private String userType;
    private boolean isActive;
    private Date lastLoginAt;

    // Getters and Setters cho tất cả các trường trên...

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }
    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    public Date getLastLoginAt() { return lastLoginAt; }
    public void setLastLoginAt(Date lastLoginAt) { this.lastLoginAt = lastLoginAt; }
}