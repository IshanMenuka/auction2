package com.menuka.ee.impl;

import com.menuka.ee.remote.UserDetails;
import jakarta.ejb.Stateless;


@Stateless
public class UserDetailsBean implements UserDetails {
    @Override
    public String getUserName() {
        return "Ishan Menuka";
    }

    @Override
    public String getUserEmail() {
        return "menuka@gmail.com";
    }

    @Override
    public String getUserPhoneNumber() {
        return "0761234567";
    }

    @Override
    public String getUserAddress() {
        return "11, Colombo, Sri Lanka";
    }

    @Override
    public String getUserRole() {
        return "administrator";
    }
}
