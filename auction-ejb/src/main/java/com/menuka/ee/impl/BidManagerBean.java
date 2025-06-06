package com.menuka.ee.impl;

import com.menuka.ee.model.Auction;
import com.menuka.ee.model.Bid;
import com.menuka.ee.model.User;
import com.menuka.ee.remote.AuctionManager;
import com.menuka.ee.remote.BidManager;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId; // <--- ADD THIS IMPORT
// Removed: import java.time.ZoneOffset; // No longer using this directly for conversion
import java.util.Date;

@Stateless
public class BidManagerBean implements BidManager {

    @EJB
    private AuctionManager auctionManager;

    @Override
    public boolean placeBid(int auctionId, double bidAmount, User user) {
        if (!auctionManager.auctionExists(auctionId)) {
            System.out.println("❌ Auction does not exist: " + auctionId);
            return false;
        }

        Auction auction = auctionManager.getAuction(auctionId);

        Instant nowInstant = Instant.now();
        Instant auctionStartInstant = auction.getStartTime().toInstant();
        Instant auctionEndInstant = auction.getEndTime().toInstant();

        if (nowInstant.isBefore(auctionStartInstant)) {
            System.out.println("❌ Auction hasn't started yet.");
            return false;
        }

        if (nowInstant.isAfter(auctionEndInstant)) {
            System.out.println("❌ Auction already ended.");
            return false;
        }

        double currentBid = auctionManager.getHighestBid(auctionId);
        if (bidAmount <= currentBid) {
            System.out.println("❌ Bid too low. Current: " + currentBid + ", Offered: " + bidAmount);
            return false;
        }

        LocalDateTime currentBidLDT = LocalDateTime.now(); // This is the local time where the server is running

        // --- FIX IS HERE ---
        // Convert the current LocalDateTime (server's local time) to java.util.Date
        Date bidTimeAsDate = Date.from(currentBidLDT.atZone(ZoneId.systemDefault()).toInstant());
        // -------------------

        auctionManager.updateBid(auctionId, bidAmount);

        Bid newBid = new Bid(user.getEmail(), user.getName(), bidAmount, bidTimeAsDate);
        auctionManager.addBidToAuctionHistory(auctionId, newBid);

        StringBuilder sb = new StringBuilder("All auctions (after bid attempt):\n");
        for (Auction auction1 : auctionManager.getAllAuctions()) {
            sb.append("ID: ").append(auction1.getId())
                    .append(", Title: ").append(auction1.getTitle())
                    .append(", Current Bid: ").append(auctionManager.getHighestBid(auction1.getId()))
                    .append(", Bids: ").append(auction1.getBidHistory().size())
                    .append(", End Time: ").append(auction1.getEndTime())
                    .append("\n");
        }
        System.out.println(sb);

        System.out.println("✅ Bid placed: " + bidAmount + " for auction " + auctionId);

        return true;
    }
}