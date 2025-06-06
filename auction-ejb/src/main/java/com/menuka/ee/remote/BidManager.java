package com.menuka.ee.remote;

import com.menuka.ee.model.User;
import jakarta.ejb.Remote;

@Remote
public interface BidManager {
    boolean placeBid(int auctionId, double bid , User user);
}
