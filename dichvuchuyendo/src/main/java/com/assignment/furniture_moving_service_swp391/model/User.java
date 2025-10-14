package com.assignment.furniture_moving_service_swp391.model;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password;
    private String role; // customer, staff, admin
    private boolean active;

    public User() {}

    public User(int id, String fullName, String email, String password, String role, boolean active) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.active = active;
    }


    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
