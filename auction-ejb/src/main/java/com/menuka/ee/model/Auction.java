package com.menuka.ee.model;

import java.io.Serializable;
// Removed: import java.time.LocalDateTime; // No longer needed here
import java.util.ArrayList;
import java.util.Date; // Added for java.util.Date
import java.util.List;

public class Auction implements Serializable {
    // It's highly recommended to add a serialVersionUID for Serializable classes
    private static final long serialVersionUID = 1L;

    private int id;
    private String title;
    private String description;
    private Date startTime; // Changed from LocalDateTime to java.util.Date
    private Date endTime;   // Changed from LocalDateTime to java.util.Date
    private List<String> imageUrls;
    private List<Bid> bidHistory = new ArrayList<>(); // IMPORTANT: Bid class MUST also be Serializable!

    public List<Bid> getBidHistory() {
        return bidHistory;
    }

    public void addBid(Bid bid) {
        this.bidHistory.add(bid);
    }


    // Getters and Setters

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    // Updated getter/setter types to java.util.Date
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }

    // Updated getter/setter types to java.util.Date
    public Date getEndTime() { return endTime; }
    public void setEndTime(Date endTime) { this.endTime = endTime; }

    public List<String> getImageUrls() { return imageUrls; }
    public void setImageUrls(List<String> imageUrls) { this.imageUrls = imageUrls; }
}