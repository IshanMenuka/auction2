package com.menuka.ee.store;

import com.menuka.ee.model.User;
import jakarta.ejb.Singleton;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Singleton
public class UserStore {
    private final Map<String, User> users = new ConcurrentHashMap<>();

    public boolean addUser(User user) {
        if (users.containsKey(user.getEmail())) return false;
        users.put(user.getEmail(), user);
        return true;
    }

    public User getUser(String email) {
        return users.get(email);
    }

    public boolean exists(String email) {
        return users.containsKey(email);
    }
}
