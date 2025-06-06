package com.menuka.ee.remote;

import com.menuka.ee.model.Auction;
import com.menuka.ee.model.Bid;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface AuctionManager {
    void createAuction(Auction auction);
    Auction getAuction(int id);
    List<Auction> getAllAuctions();
    void closeAuction(int id);
    boolean auctionExists(int id);
    double getHighestBid(int id);
    void updateBid(int id, double newBid);
    void addBidToAuctionHistory(int auctionId, Bid bid);


}