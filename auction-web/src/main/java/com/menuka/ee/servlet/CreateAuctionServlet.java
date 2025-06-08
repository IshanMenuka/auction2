package com.menuka.ee.servlet;

import com.menuka.ee.model.Auction;
import com.menuka.ee.remote.AuctionManager;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.ZoneId; // <--- ADD THIS IMPORT
// Removed: import java.time.ZoneOffset; // No longer using this directly for conversion
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/createAuction")
public class CreateAuctionServlet extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            long timestamp = System.currentTimeMillis();
            int auctionId = (int)(timestamp % 1000000000);

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String startTimeRaw = request.getParameter("startTime");
            String endTimeRaw = request.getParameter("endTime");

            LocalDateTime startLDT = LocalDateTime.parse(startTimeRaw);
            LocalDateTime endLDT = LocalDateTime.parse(endTimeRaw);

            // --- FIX IS HERE ---
            // Convert LocalDateTime (from form) to java.util.Date by interpreting it in the server's default timezone
            Date startTime = Date.from(startLDT.atZone(ZoneId.systemDefault()).toInstant());
            Date endTime = Date.from(endLDT.atZone(ZoneId.systemDefault()).toInstant());
            // --------------------

            List<String> images = new ArrayList<>();
            if (request.getParameter("image1") != null && !request.getParameter("image1").isBlank())
                images.add(request.getParameter("image1"));
            if (request.getParameter("image2") != null && !request.getParameter("image2").isBlank())
                images.add(request.getParameter("image2"));
            if (request.getParameter("image3") != null && !request.getParameter("image3").isBlank())
                images.add(request.getParameter("image3"));

            Auction auction = new Auction();
            auction.setId(auctionId);
            auction.setTitle(title);
            auction.setDescription(description);
            auction.setStartTime(startTime);
            auction.setEndTime(endTime);
            auction.setImageUrls(images);

            auctionManager.createAuction(auction);

            out.println("<h3 style='color:green;'>✅ Auction \"" + title + "\" created successfully!</h3>");
        } catch (NumberFormatException | DateTimeParseException e) {
            out.println("<h3 style='color:red;'>❌ Invalid number or date format. Please ensure correct format and valid numbers.</h3>");
            e.printStackTrace(out);
        } catch (Exception e) {
            e.printStackTrace(out);
            out.println("<h3 style='color:red;'>❌ An unexpected error occurred: " + e.getMessage() + "</h3>");
        }

        out.println("<br><a href='index.jsp'>⬅ Back to Home</a>");
    }
}