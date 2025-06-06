package com.ashanhimantha.ee.servlet;

import com.menuka.ee.model.Auction;
import com.menuka.ee.remote.AuctionManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime; // Added for conversion
import java.time.ZoneId;        // Added for conversion (e.g., systemDefault())
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Date;          // Added (though Auction import might bring it in, good for clarity)

@WebServlet("/auctionList")
public class AuctionListServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head>");
        out.println("<title>Active Auctions</title>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1'>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }");
        out.println(".container { max-width: 1200px; margin: 0 auto; }");
        out.println(".card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }");
        out.println(".card { background: white; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); overflow: hidden; transition: transform 0.3s; }");
        out.println(".card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); }");
        out.println(".card-image { height: 200px; background-color: #ddd; overflow: hidden; position: relative; }");
        out.println(".card-image img { width: 100%; height: 100%; object-fit: cover; }");
        out.println(".card-content { padding: 15px; }");
        out.println(".card-title { font-size: 18px; font-weight: bold; margin-bottom: 10px; }");
        out.println(".card-info { margin-bottom: 5px; color: #555; }");
        out.println(".card-price { font-size: 20px; font-weight: bold; color: #2c7be5; margin-top: 10px; }");
        out.println(".card-button { display: block; text-align: center; background-color: #007BFF; color: white; padding: 8px 12px; text-decoration: none; border-radius: 4px; margin-top: 10px; }");
        out.println(".card-button:hover { background-color: #0056b3; }");
        out.println(".back-button { display: inline-block; margin-top: 20px; margin-bottom: 20px; padding: 10px 15px; background-color: #333; color: white; text-decoration: none; border-radius: 4px; }");
        out.println(".no-auctions { padding: 20px; background: white; border-radius: 8px; text-align: center; }");
        out.println("</style>");
        out.println("</head><body>");
        out.println("<div class='container'>");
        out.println("<h1>Active Auctions</h1>");

        try {
            List<Auction> auctions = auctionManager.getAllAuctions();
            if (auctions.isEmpty()) {
                out.println("<div class='no-auctions'><p>No auctions found.</p></div>");
            } else {
                out.println("<div class='card-grid'>");

                // DateTimeFormatter is still used, but applied to LocalDateTime
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");

                for (Auction auction : auctions) {
                    int id = auction.getId();
                    String title = auction.getTitle();
                    double highestBid = auctionManager.getHighestBid(id);
                    List<String> images = auction.getImageUrls();
                    String imageUrl = images != null && !images.isEmpty() ? images.get(0) : "https://via.placeholder.com/300x200?text=No+Image";

                    // Convert java.util.Date back to LocalDateTime for display formatting
                    LocalDateTime displayStartTime = LocalDateTime.ofInstant(auction.getStartTime().toInstant(), ZoneId.systemDefault());
                    LocalDateTime displayEndTime = LocalDateTime.ofInstant(auction.getEndTime().toInstant(), ZoneId.systemDefault());

                    out.println("<div class='card'>");
                    out.println("  <div class='card-image'>");
                    out.println("    <img src='" + imageUrl + "' alt='" + title + "'>");
                    out.println("  </div>");
                    out.println("  <div class='card-content'>");
                    out.println("    <div class='card-title'>" + title + "</div>");
                    out.println("    <div class='card-info'><strong>ID:</strong> " + id + "</div>");
                    // Apply formatter to the converted LocalDateTime objects
                    out.println("    <div class='card-info'><strong>Starts:</strong> " + displayStartTime.format(formatter) + "</div>");
                    out.println("    <div class='card-info'><strong>Ends:</strong> " + displayEndTime.format(formatter) + "</div>");
                    out.println("    <div class='card-price'>Current Bid: $" + String.format("%.2f", highestBid) + "</div>");
                    out.println("    <a href='auctionDetail?id=" + id + "' class='card-button'>View Details</a>");
                    out.println("  </div>");
                    out.println("</div>");
                }
                out.println("</div>");
            }
        } catch (Exception e) {
            // It's good practice to log the full stack trace on the server side
            e.printStackTrace();
            out.println("<p style='color:red; padding: 15px; background: white; border-radius: 8px;'>Error: Could not retrieve auction list. " + e.getMessage() + "</p>");
        }

        out.println("<a href='index.jsp' class='back-button'>⬅ Back to Home</a>");
        out.println("</div>");
        out.println("</body></html>");
    }
}