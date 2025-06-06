package com.menuka.ee.remote;

import jakarta.ejb.Remote;

@Remote
public interface SingletonState {
    void increment();
    void decrement();
    int getActiveAuctionCount();
}
