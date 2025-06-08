package com.menuka.ee.servlet;


import com.menuka.ee.model.User;
import com.menuka.ee.remote.UserSessionManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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

        String email = req.getParameter("email");
        String password = req.getParameter("password");

User user = sessionManager.login(email, password);
if (user != null) {
    HttpSession session = req.getSession(true);
    session.setAttribute("user", user);
    resp.sendRedirect("index.jsp");
} else {
    out.println("<h3 style='color:red'>❌ Invalid credentials.</h3>");
    out.println("<a href='login.jsp'>Try Again</a>");
}
    }
}
