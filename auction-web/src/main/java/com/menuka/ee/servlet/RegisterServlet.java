package com.ashanhimantha.ee.servlet;

import com.menuka.ee.model.User;
import com.menuka.ee.remote.UserSessionManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserSessionManager sessionManager;

    @Override
    public void init() {
        try {
            Context ctx = new InitialContext();
            String jndi = "java:global/auction-ejb/UserSessionManagerBean!com.menuka.ee.remote.UserSessionManager";
            sessionManager = (UserSessionManager) ctx.lookup(jndi);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        User user = new User(name, email, password, role);
        boolean success = sessionManager.register(user);

        if (success) {
            // Automatically log in the user after successful registration
            User loggedInUser = sessionManager.login(email, password);
            if (loggedInUser != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("user", loggedInUser);
                resp.sendRedirect("index.jsp");
            } else {
                // This should rarely happen (user created but can't log in)
                out.println("<h3 style='color:green'>✅ User registered successfully, but auto-login failed.</h3>");
                out.println("<a href='login.jsp'>Go to Login</a>");
            }
        } else {
            // Set error message and forward back to registration page
            req.setAttribute("error", "Email already exists. Please use a different email address.");
            try {
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            } catch (Exception e) {
                // Fallback if forwarding fails
                out.println("<h3 style='color:red'>❌ Email already exists.</h3>");
                out.println("<a href='register.jsp'>Try Again</a>");
            }
        }
    }
}