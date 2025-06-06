package com.menuka.ee.impl;

import com.menuka.ee.remote.UserDetails;
import jakarta.ejb.Stateless;


@Stateless
public class UserDetailsBean implements UserDetails {
    @Override
    public String getUserName() {
        return "Ashan Himantha";
    }

    @Override
    public String getUserEmail() {
        return "ashan@gmail.com";
    }

    @Override
    public String getUserPhoneNumber() {
        return "0701234567";
    }

    @Override
    public String getUserAddress() {
        return "26, Colombo, Sri Lanka";
    }

    @Override
    public String getUserRole() {
        return "administrator";
    }
}
