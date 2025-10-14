package com.assignment.furniture_moving_service_swp391.model;

public class Item {
    private long id;
    private String name;
    private String description;
    private long categoryId;       // FK đến ItemCategory
    private String categoryName;   // Hiển thị JOIN
    private double weightKg;
    private double volumeM3;
    private double basePrice;
    private boolean isActive;

    public Item(long id, String nameU, String descriptionU, long categoryIdU, double priceU, String statusU) {}


    // Constructor có đủ dữ liệu JOIN
    public Item(long id, String name, String description, long categoryId, String categoryName,
                double weightKg, double volumeM3, double basePrice, boolean isActive) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.weightKg = weightKg;
        this.volumeM3 = volumeM3;
        this.basePrice = basePrice;
        this.isActive = isActive;
    }

    // Constructor dùng cho insert/update
    public Item(long id, String name, String description, long categoryId,
                double weightKg, double volumeM3, double basePrice, boolean isActive) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.categoryId = categoryId;
        this.weightKg = weightKg;
        this.volumeM3 = volumeM3;
        this.basePrice = basePrice;
        this.isActive = isActive;
    }

    // --- Getters & Setters ---
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public long getCategoryId() { return categoryId; }
    public void setCategoryId(long categoryId) { this.categoryId = categoryId; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public double getWeightKg() { return weightKg; }
    public void setWeightKg(double weightKg) { this.weightKg = weightKg; }

    public double getVolumeM3() { return volumeM3; }
    public void setVolumeM3(double volumeM3) { this.volumeM3 = volumeM3; }

    public double getBasePrice() { return basePrice; }
    public void setBasePrice(double basePrice) { this.basePrice = basePrice; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}
