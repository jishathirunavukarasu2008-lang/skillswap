package com.skillswap.model;

public class Exchange {

    private int exchangeId;
    private int requesterId;
    private int receiverId;
    private int offeredSkillId;
    private int wantedSkillId;
    private String status;

    public Exchange() {
    }

    public Exchange(int requesterId, int receiverId,
                    int offeredSkillId, int wantedSkillId) {
        this.requesterId = requesterId;
        this.receiverId = receiverId;
        this.offeredSkillId = offeredSkillId;
        this.wantedSkillId = wantedSkillId;
        this.status = "PENDING";
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

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public int getOfferedSkillId() {
        return offeredSkillId;
    }

    public void setOfferedSkillId(int offeredSkillId) {
        this.offeredSkillId = offeredSkillId;
    }

    public int getWantedSkillId() {
        return wantedSkillId;
    }

    public void setWantedSkillId(int wantedSkillId) {
        this.wantedSkillId = wantedSkillId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}