package com.skillswap.model;

public class Circle {

    private int circleId;
    private String circleName;
    private String description;
    private int createdBy;

    public Circle() {
    }

    public Circle(String circleName,
                  String description,
                  int createdBy) {

        this.circleName = circleName;
        this.description = description;
        this.createdBy = createdBy;
    }

    public int getCircleId() {
        return circleId;
    }

    public void setCircleId(int circleId) {
        this.circleId = circleId;
    }

    public String getCircleName() {
        return circleName;
    }

    public void setCircleName(String circleName) {
        this.circleName = circleName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
}