package com.ashanhimantha.ee.servlet;
import com.menuka.ee.model.User;
import com.menuka.ee.remote.BidManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/placeBid")
public class AuctionServlet extends HttpServlet {

    private BidManager bidManager;

    @Override
    public void init() {
        try {
            Context ctx = new InitialContext();
            // Modify this if needed based on the app name and module
            String jndiName = "java:global/auction-ejb/BidManagerBean!com.menuka.ee.remote.BidManager";
            bidManager = (BidManager) ctx.lookup(jndiName);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Check if user is logged in
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int auctionId = Integer.parseInt(request.getParameter("auctionId"));
            double bid = Double.parseDouble(request.getParameter("bid"));

            boolean result = bidManager.placeBid(auctionId, bid, user);
            out.println(result ? "✅ Bid Accepted!" : "❌ Bid Rejected.");
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
}