package com.menuka.ee;

import com.menuka.ee.remote.UserDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.naming.InitialContext;
import java.io.IOException;

@WebServlet(name = "Home", urlPatterns = {"/home"})
public class Home extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try
        {
//
//            InitialContext ctx = new InitialContext();
//            UserDetails user =(UserDetails) ctx.lookup("java:global/auction-ejb/UserDetailsBean");
//            response.getWriter().write(user.getUserName());


        } catch (Exception e) {
            response.getWriter().write(e.getMessage());


        }
    }



}
