package com.menuka.ee.remote;

import com.menuka.ee.model.User;
import jakarta.ejb.Remote;

@Remote
public interface UserSessionManager {
    boolean register(User user);
    User login(String email, String password);
}
