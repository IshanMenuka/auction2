package com.menuka.ee.model;

import java.io.Serializable;
// Removed: import java.time.LocalDateTime; // No longer needed here
import java.util.Date; // Added for java.util.Date

public class Bid implements Serializable {
    // It's highly recommended to add a serialVersionUID for Serializable classes
    private static final long serialVersionUID = 1L;

    private String userEmail;
    private String userName;
    private double amount;
    private Date timestamp; // Changed from LocalDateTime to java.util.Date

    public Bid() {
        // Default constructor is good practice for JavaBeans/serialization
    }

    // Updated constructor signature to use java.util.Date
    public Bid(String userEmail, String userName, double amount, Date timestamp) {
        this.userEmail = userEmail;
        this.userName = userName;
        this.amount = amount;
        this.timestamp = timestamp;
    }

    // Getters and Setters
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    // Updated getter/setter types to java.util.Date
    public Date getTimestamp() { return timestamp; }
    public void setTimestamp(Date timestamp) { this.timestamp = timestamp; }
}