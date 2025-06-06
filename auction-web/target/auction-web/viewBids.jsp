<%@ page import="com.menuka.ee.model.Auction, com.menuka.ee.model.Bid" %>
<%@ page import="java.util.List, java.time.format.DateTimeFormatter" %>
<%
    // Get the auction object from request attributes (set by the ViewBidHistoryServlet)
    Auction auction = (Auction) request.getAttribute("auction");
    List<Bid> bids = auction.getBidHistory();

    // Format for displaying date and time
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // Sort bids in descending order (highest first) - optional
    bids.sort((b1, b2) -> Double.compare(b2.getAmount(), b1.getAmount()));
%>

<div class="bid-history-container">
    <h2>Bid History for <%= auction.getTitle() %></h2>

    <% if (bids.isEmpty()) { %>
    <p>No bids have been placed yet for this auction.</p>
    <% } else { %>
    <table class="bid-table">
        <thead>
        <tr>
            <th>Bidder</th>
            <th>Amount</th>
            <th>Date & Time</th>
        </tr>
        </thead>
        <tbody>
        <% for (Bid bid : bids) { %>
        <tr>
            <td><%= bid.getUserName() %> (<%= bid.getUserEmail() %>)</td>
            <td class="amount">LKR <%= String.format("%,.2f", bid.getAmount()) %></td>
            <td><%= bid.getTimestamp().format(formatter) %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>

    <p><a href="javascript:history.back()">Back to Auction</a></p>
</div>

<style>
    .bid-history-container {
        max-width: 800px;
        margin: 0 auto;
        font-family: Arial, sans-serif;
    }
    .bid-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .bid-table th, .bid-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    .bid-table th {
        background-color: #f2f2f2;
        font-weight: bold;
    }
    .bid-table tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    .bid-table tr:hover {
        background-color: #f1f1f1;
    }
    .amount {
        text-align: right;
        font-family: monospace;
    }
</style>