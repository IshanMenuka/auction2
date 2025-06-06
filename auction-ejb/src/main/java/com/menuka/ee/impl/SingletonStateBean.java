package com.menuka.ee.impl;

import com.menuka.ee.remote.SingletonState;
import jakarta.ejb.Singleton;

@Singleton
public class SingletonStateBean implements SingletonState {

    private int activeAuctions = 0;

    @Override
    public void increment() {
        activeAuctions++;
    }

    @Override
    public void decrement() {
        activeAuctions--;
    }

    @Override
    public int getActiveAuctionCount() {
        return activeAuctions;
    }
}
