package com.ashanhimantha.ee.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        // Get the current session (don't create a new one if none exists)
        HttpSession session = req.getSession(false);

        // If there is an active session, invalidate it
        if (session != null) {
            session.invalidate();
        }

        // Redirect to the home page
        resp.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        // Handle POST requests the same way as GET
        doGet(req, resp);
    }
}