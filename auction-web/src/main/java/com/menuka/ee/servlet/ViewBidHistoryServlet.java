package com.ashanhimantha.ee.servlet;

import com.menuka.ee.model.Auction;
import com.menuka.ee.remote.AuctionManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;

@WebServlet("/viewSingleBidHistory")
public class ViewBidHistoryServlet extends HttpServlet {

    private AuctionManager auctionManager;

    @Override
    public void init() {
        try {
            Context ctx = new InitialContext();
            auctionManager = (AuctionManager) ctx.lookup(
                    "java:global/auction-ejb/AuctionManagerBean!com.menuka.ee.remote.AuctionManager"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String idParam = request.getParameter("auctionId");
            if (idParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing auctionId");
                return;
            }

            int auctionId = Integer.parseInt(idParam);
            Auction auction = auctionManager.getAuction(auctionId);

            if (auction == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Auction not found");
                return;
            }

            request.setAttribute("auction", auction);
            RequestDispatcher dispatcher = request.getRequestDispatcher("viewBids.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red;'>❌ Error: " + e.getMessage() + "</h3>");
        }
    }
}
