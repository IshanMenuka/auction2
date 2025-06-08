package com.menuka.ee.servlet;

import com.menuka.ee.model.Auction;
import com.menuka.ee.remote.AuctionManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;

@WebServlet("/auctionItem")
public class AuctionItemServlet extends HttpServlet {

    private AuctionManager auctionManager;

    @Override
    public void init() {
        try {
            Context ctx = new InitialContext();
            auctionManager = (AuctionManager) ctx.lookup("java:global/auction-ejb/AuctionManagerBean!com.menuka.ee.remote.AuctionManager");
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
            RequestDispatcher dispatcher = request.getRequestDispatcher("auctionItem.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            response.getWriter().println("❌ Error: " + e.getMessage());
        }
    }
}
