package com.menuka.ee.remote;

import jakarta.ejb.Remote;

@Remote
public interface UserDetails {
    String getUserName();

    String getUserEmail();

    String getUserPhoneNumber();

    String getUserAddress();

    String getUserRole();
}
