package com.menuka.ee.impl;

import com.menuka.ee.model.User;
import com.menuka.ee.remote.UserSessionManager;
import com.menuka.ee.store.UserStore;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;

@Stateless
public class UserSessionManagerBean implements UserSessionManager {

    @EJB
    private UserStore store;

    @Override
    public boolean register(User user) {
        return store.addUser(user);
    }

    @Override
    public User login(String email, String password) {
        User user = store.getUser(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
