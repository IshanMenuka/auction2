package com.ashanhimantha.ee.servlet;

import com.menuka.ee.model.Auction;
import com.menuka.ee.remote.AuctionManager;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import java.io.IOException;

@WebServlet("/viewBids")
public class ViewBidsServlet extends HttpServlet {

    private AuctionManager auctionManager;

    @Override
    public void init() {
        try {
            Context ctx = new InitialContext();
            String jndi = "java:global/auction-ejb/AuctionManagerBean!com.menuka.ee.remote.AuctionManager";
            auctionManager = (AuctionManager) ctx.lookup(jndi);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int auctionId = Integer.parseInt(request.getParameter("auctionId"));
            Auction auction = auctionManager.getAuction(auctionId);

            request.setAttribute("auction", auction);
            RequestDispatcher dispatcher = request.getRequestDispatcher("viewBids.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            response.getWriter().println("❌ Error loading auction: " + e.getMessage());
        }
    }
}
