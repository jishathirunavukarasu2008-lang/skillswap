package com.skillswap.model;

public class Rescue {

    private int rescueId;
    private int exchangeId;
    private int requesterId;
    private String reason;
    private String status;
    private Integer replacementUserId;

    public Rescue() {
    }

    public Rescue(int exchangeId, int requesterId, String reason) {
        this.exchangeId = exchangeId;
        this.requesterId = requesterId;
        this.reason = reason;
        this.status = "OPEN";
    }

    public int getRescueId() {
        return rescueId;
    }

    public void setRescueId(int rescueId) {
        this.rescueId = rescueId;
    }

    public int getExchangeId() {
        return exchangeId;
    }

    public void setExchangeId(int exchangeId) {
        this.exchangeId = exchangeId;
    }

    public int getRequesterId() {
        return requesterId;
    }

    public void setRequesterId(int requesterId) {
        this.requesterId = requesterId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getReplacementUserId() {
        return replacementUserId;
    }

    public void setReplacementUserId(Integer replacementUserId) {
        this.replacementUserId = replacementUserId;
    }
}