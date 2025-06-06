<%@ page import="com.menuka.ee.model.Auction, com.menuka.ee.model.Bid, com.menuka.ee.model.User" %>
<%@ page import="com.menuka.ee.remote.AuctionManager, javax.naming.*" %>
<%@ page import="java.util.List, java.util.Date" %>
<%@ page import="java.time.Instant, java.time.LocalDateTime, java.time.ZoneId, java.time.format.DateTimeFormatter, java.time.temporal.ChronoUnit" %>
<%-- Removed: java.util.Map import as it's not needed with the simplified bid history --%>

<%
    // The auction object is passed as a request attribute, likely by a servlet
    Auction auction = (Auction) request.getAttribute("auction");
    User user = (User) session.getAttribute("user");

    // Get AuctionManager to access the highest bid
    AuctionManager auctionManager = null;
    double highestBid = 0.0;
    List<Bid> bidHistory = null; // Initialize to null

    try {
        Context ctx = new InitialContext();
        String jndi = "java:global/auction-ejb/AuctionManagerBean!com.ashanhimantha.ee.remote.AuctionManager";
        auctionManager = (AuctionManager) ctx.lookup(jndi);

        if (auction != null) {
            highestBid = auctionManager.getHighestBid(auction.getId());

            // Retrieve bid history directly from the Auction object.
            // Assuming auctionManager.getAuction() (which populates the 'auction' object)
            // also fetches its bid history.
            bidHistory = auction.getBidHistory();
        }
    } catch (Exception e) {
        // Log the exception on the server side for debugging
        e.printStackTrace();

        // Fallback for highest bid and history if EJB lookup or call fails
        if (auction != null && auction.getBidHistory() != null) {
            highestBid = auction.getBidHistory().stream().mapToDouble(Bid::getAmount).max().orElse(0.0);
            bidHistory = auction.getBidHistory();
        } else {
            // If auction or its history is null, ensure highestBid is 0 and history is empty
            highestBid = 0.0;
            bidHistory = java.util.Collections.emptyList(); // Ensure it's not null to avoid NPEs later
        }
    }

    if (auction == null) {
%>
<p>❌ Auction not found.</p>
<% return; }

    // Convert java.util.Date objects from Auction to Instant/LocalDateTime for calculations and display
    Instant nowInstant = Instant.now();
    Instant auctionStartInstant = auction.getStartTime().toInstant();
    Instant auctionEndInstant = auction.getEndTime().toInstant();

    boolean hasStarted = nowInstant.isAfter(auctionStartInstant);
    boolean hasEnded = nowInstant.isAfter(auctionEndInstant);

    // Calculate minutes until start, ensure nowInstant is not after start for positive result
    long minutesUntilStart = 0;
    if (!hasStarted) {
        minutesUntilStart = ChronoUnit.MINUTES.between(nowInstant, auctionStartInstant);
    }

    // Formatter configured to display in the system's default timezone
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy - hh:mm a").withZone(ZoneId.systemDefault());
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= auction.getTitle() %></title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 text-gray-800">

<%-- Include the header and pass the user variable --%>
<jsp:include page="header.jsp">
    <jsp:param name="user" value="<%= user != null ? user.getName() : null %>"/>
</jsp:include>

<%-- Add spacing to prevent content from being hidden under the fixed header --%>
<div class="pt-16"></div>

<div class="max-w-5xl mx-auto mt-10 p-6 bg-white rounded-lg shadow-lg">
    <div class="mb-6 border-b pb-4">
        <h1 class="text-3xl font-bold text-blue-700"><%= auction.getTitle() %></h1>
        <p class="text-gray-600 mt-2"><%= auction.getDescription() %></p>
        <div class="mt-4 text-sm">
            <span class="inline-block bg-blue-100 text-blue-700 px-3 py-1 rounded-full mr-2">Start: <%= formatter.format(auctionStartInstant) %></span>
            <span class="inline-block bg-green-100 text-green-700 px-3 py-1 rounded-full">End: <%= formatter.format(auctionEndInstant) %></span>
        </div>
    </div>

    <!-- Image Preview -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
        <%
            // Defensive check for imageUrls not being null or empty
            if (auction.getImageUrls() != null && !auction.getImageUrls().isEmpty()) {
                for (String img : auction.getImageUrls()) { %>
        <img src="<%= img %>" alt="Auction Image" class="rounded shadow-sm object-cover h-48 w-full">
        <% }
        } else {
            // Fallback if no images are provided
        %>
        <img src="https://via.placeholder.com/300x200?text=No+Image" alt="No Image" class="rounded shadow-sm object-cover h-48 w-full col-span-full">
        <% } %>
    </div>

    <!-- Bid Info & Form -->
    <div class="mb-8">
        <h2 class="text-2xl font-semibold mb-2">Current Highest Bid: <span class="text-blue-600">LKR <%= String.format("%.2f", highestBid) %></span></h2>

        <% if (!hasStarted) { %>
        <p class="text-yellow-600 font-medium mb-4">
            ⏳ Auction hasn't started yet. Starts in <%= minutesUntilStart %> minute(s).
        </p>
        <% } else if (hasEnded) { %>
        <p class="text-red-600 font-semibold mb-4">🚫 Auction has ended.</p>
        <% } %>

        <% if (user != null && hasStarted && !hasEnded) { %>
        <form method="post" action="placeBid" class="space-y-4 mt-4">
            <input type="hidden" name="auctionId" value="<%= auction.getId() %>">
            <label for="bid" class="block font-medium">Enter your bid:</label>
            <input type="number" step="0.01" name="bid" id="bid"
                   class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:border-blue-300"
                   required min="<%= String.format("%.2f", highestBid + 0.01) %>" >
            <button type="submit"
                    class="bg-blue-600 text-white px-6 py-2 rounded-md hover:bg-blue-700 transition">
                Place Bid
            </button>
        </form>
        <% } else if (user == null) { %>
        <p class="text-gray-700 mt-4">🔒 <a href="login.jsp" class="text-blue-600 underline">Login</a> to place a bid.</p>
        <% } %>
    </div>

    <!-- Bid History -->
    <div>
        <h3 class="text-xl font-semibold mb-3">📜 Bid History</h3>
        <table class="w-full text-sm border rounded-md overflow-hidden shadow-sm">
            <thead class="bg-gray-100">
            <tr>
                <th class="p-3 text-left">User</th>
                <th class="p-3 text-left">Amount</th>
                <th class="p-3 text-left">Time</th>
            </tr>
            </thead>
            <tbody>
            <% if (bidHistory != null && !bidHistory.isEmpty()) { %>
            <% for (Bid b : bidHistory) {
                // Convert Bid's Date timestamp to Instant for formatting
                Instant bidTimestampInstant = b.getTimestamp().toInstant();
            %>
            <tr class="border-t">
                <td class="p-3"><%= b.getUserName() %> </td>
                <td class="p-3">LKR <%= String.format("%.2f", b.getAmount()) %></td>
                <td class="p-3"><%= formatter.format(bidTimestampInstant) %></td> <%-- Format Instant directly --%>
            </tr>
            <% } %>
            <% } else { %>
            <tr class="border-t">
                <td colspan="3" class="p-3 text-center">No bids placed yet</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>