package com.skillswap.model;

public class Session {

    private int sessionId;
    private int exchangeId;
    private String scheduledDate;
    private String scheduledTime;
    private String topic;
    private int durationMinutes;
    private String status;

    public Session() {
    }

    public Session(int exchangeId,
                   String scheduledDate,
                   String scheduledTime,
                   String topic,
                   int durationMinutes) {

        this.exchangeId = exchangeId;
        this.scheduledDate = scheduledDate;
        this.scheduledTime = scheduledTime;
        this.topic = topic;
        this.durationMinutes = durationMinutes;
        this.status = "SCHEDULED";
    }

    public int getSessionId() {
        return sessionId;
    }

    public void setSessionId(int sessionId) {
        this.sessionId = sessionId;
    }

    public int getExchangeId() {
        return exchangeId;
    }

    public void setExchangeId(int exchangeId) {
        this.exchangeId = exchangeId;
    }

    public String getScheduledDate() {
        return scheduledDate;
    }

    public void setScheduledDate(String scheduledDate) {
        this.scheduledDate = scheduledDate;
    }

    public String getScheduledTime() {
        return scheduledTime;
    }

    public void setScheduledTime(String scheduledTime) {
        this.scheduledTime = scheduledTime;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}