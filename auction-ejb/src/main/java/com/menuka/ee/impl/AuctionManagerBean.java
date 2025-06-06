package com.menuka.ee.impl;

import com.menuka.ee.model.Auction;
import com.menuka.ee.model.Bid;
import com.menuka.ee.remote.AuctionManager;
import jakarta.ejb.*;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Singleton
@Startup
public class AuctionManagerBean implements AuctionManager {

    // Maps to store auction data and bids
    private final Map<Integer, Auction> auctionMap = new ConcurrentHashMap<>();
    private final Map<Integer, Double> bidMap = new ConcurrentHashMap<>();




    @Override
    public void createAuction(Auction auction) {
        auctionMap.put(auction.getId(), auction);
        bidMap.put(auction.getId(), 0.0); // Default starting bid


    }



    @Override
    public void closeAuction(int id) {
        auctionMap.remove(id);
        bidMap.remove(id);
    }

    @Override
    public void addBidToAuctionHistory(int auctionId, Bid bid) {
        Auction auction = auctionMap.get(auctionId);
        if (auction != null) {
            auction.addBid(bid);
        }
    }

    @Override
    public boolean auctionExists(int id) {
        return auctionMap.containsKey(id);
    }

    @Override
    public Auction getAuction(int id) {
        return auctionMap.get(id);
    }

    @Override
    public List<Auction> getAllAuctions() {
        return new ArrayList<>(auctionMap.values());
    }

    @Override
    public double getHighestBid(int id) {
        return bidMap.getOrDefault(id, 0.0);
    }

    @Override
    public void updateBid(int id, double newBid) {
        bidMap.put(id, newBid);

        Auction auction = auctionMap.get(id);
        if (auction != null) {
            auctionMap.put(id, auction);
        }
    }
}