<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.menuka.ee.model.User" %>
<%
    // Use the implicit session object instead of declaring a new one
    User user = (session != null) ? (User) session.getAttribute("user") : null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Auction System Home</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<!-- Fixed Header -->
<%@ include file="header.jsp" %>

<!-- Hero Section -->
<section class="pt-32 pb-20 bg-gradient-to-br from-blue-50 to-indigo-100">
    <div class="container mx-auto px-4">
        <div class="flex flex-col md:flex-row items-center">
            <div class="md:w-1/2 mb-10 md:mb-0">
                <h1 class="text-4xl md:text-5xl font-bold text-gray-800 leading-tight mb-4">
                    Discover Unique Items at <span class="text-blue-600">Competitive Prices</span>
                </h1>
                <p class="text-lg text-gray-600 mb-8">
                    Join thousands of bidders in our trusted auction marketplace.
                    Find treasures, bid with confidence, and win the items you've always wanted.
                </p>
                <div class="flex space-x-4">
                    <a href="auctionList" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-medium transition-colors">
                        Browse Auctions
                    </a>
                    <a href="register.jsp" class="bg-transparent border border-blue-600 text-blue-600 hover:bg-blue-50 px-6 py-3 rounded-lg font-medium transition-colors">
                        Join Now
                    </a>
                </div>
            </div>
            <div class="md:w-1/2">
                <img src="https://images.unsplash.com/photo-1551836022-aadb801c60ae?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"
                     alt="Auction image" class="rounded-lg shadow-xl">
            </div>
        </div>
    </div>
</section>


<!-- Featured Auctions Section -->
<section class="py-16">
    <div class="container mx-auto px-4">
        <div class="text-center mb-12">
            <h2 class="text-3xl font-bold text-gray-800">Featured Auctions</h2>
            <p class="text-gray-600 mt-2">Explore our most popular ongoing auctions</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <%-- IMPORTANT: Keep imports here if you have a JSP fragment, but if this is a full JSP,
                         it's best to put all page imports at the very top. --%>
            <%@ page import="com.menuka.ee.model.Auction, com.menuka.ee.remote.AuctionManager, java.util.List, javax.naming.*, java.time.format.DateTimeFormatter, java.time.ZoneId, java.time.Instant" %>
            <%
                AuctionManager auctionManager = null;
                try {
                    Context ctx = new InitialContext();
                    String jndi = "java:global/auction-ejb/AuctionManagerBean!com.menuka.ee.remote.AuctionManager";
                    auctionManager = (AuctionManager) ctx.lookup(jndi);

                    List<Auction> auctions = auctionManager.getAllAuctions();
                    // Formatter is defined with the timezone.
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy hh:mm a").withZone(ZoneId.systemDefault());
                    int count = 0;

                    for (Auction auction : auctions) {
                        if (count >= 3) break; // Only show top 3 featured

                        int id = auction.getId();
                        String title = auction.getTitle();
                        double highestBid = auctionManager.getHighestBid(id);
                        List<String> images = auction.getImageUrls();
                        String imageUrl = (images != null && !images.isEmpty()) ? images.get(0) : "https://via.placeholder.com/300x200?text=No+Image";

                        // Convert java.util.Date to java.time.Instant before formatting
                        // The formatter already has a ZoneId, so it can directly format an Instant.
                        String timeRemaining = formatter.format(auction.getEndTime().toInstant());

                        String description = auction.getDescription() != null ? auction.getDescription() : "No description provided.";
                        if (description.length() > 100) {
                            description = description.substring(0, 100) + "...";
                        }
            %>
            <!-- Auction Card -->
            <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-lg transition-shadow">
                <div class="h-48 overflow-hidden">
                    <img src="<%= imageUrl %>" alt="<%= title %>" class="w-full h-full object-cover">
                </div>
                <div class="p-6">
                    <h3 class="font-bold text-xl mb-2"><%= title %></h3>
                    <p class="text-gray-600 mb-4"><%= description %></p>
                    <div class="flex justify-between items-center">
                        <span class="text-blue-600 font-semibold">Current Bid: LKR <%= String.format("%.2f", highestBid) %></span>
                        <span class="text-gray-500 text-sm">Ends: <%= timeRemaining %></span>
                    </div>
                    <a href="auctionItem?auctionId=<%= id %>" class="mt-4 block text-center bg-blue-600 hover:bg-blue-700 text-white py-2 rounded-md font-medium">
                        View Details
                    </a>
                </div>
            </div>
            <%
                    count++;
                }

                if (auctions == null || auctions.isEmpty()) {
            %>
            <div class="col-span-3 py-10 text-center">
                <p class="text-gray-500 text-lg">No auctions currently available.</p>
                <p class="mt-2 text-gray-500">Check back soon for new listings!</p>
            </div>
            <%
                }
            } catch (Exception e) {
                // Log the exception on the server for debugging
                e.printStackTrace();
            %>
            <div class="col-span-3 bg-red-50 p-4 rounded-md">
                <p class="text-red-500">Unable to load auctions. Please try again later.</p>
                <%-- Optionally display error message for debugging purposes (remove in production) --%>
                <%-- <p class="text-red-500 text-sm"><%= e.getMessage() %></p> --%>
            </div>
            <%
                }
            %>
        </div>

        <div class="text-center mt-10">
            <a href="auctionList" class="inline-block bg-transparent border border-blue-600 text-blue-600 hover:bg-blue-50 px-6 py-3 rounded-lg font-medium transition-colors">
                View All Auctions
            </a>
        </div>
    </div>
</section>


<!-- About Us Section -->
<section id="about" class="py-16 bg-gray-50">
    <div class="container mx-auto px-4">
        <div class="max-w-3xl mx-auto text-center">
            <h2 class="text-3xl font-bold text-gray-800 mb-6">About BidMaster</h2>
            <p class="text-lg text-gray-600 mb-8">
                BidMaster is a trusted online auction platform connecting buyers and sellers since 2010.
                We provide a secure, transparent, and exciting auction experience for collectors, enthusiasts,
                and bargain hunters alike.
            </p>
            <div class="flex justify-center space-x-12 mb-8">
                <div class="text-center">
                    <div class="text-blue-600 text-4xl font-bold">50k+</div>
                    <div class="text-gray-600">Active Users</div>
                </div>
                <div class="text-center">
                    <div class="text-blue-600 text-4xl font-bold">100k+</div>
                    <div class="text-gray-600">Successful Auctions</div>
                </div>
                <div class="text-center">
                    <div class="text-blue-600 text-4xl font-bold">99%</div>
                    <div class="text-gray-600">Satisfaction Rate</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-8">
    <div class="container mx-auto px-4">
        <div class="flex flex-col md:flex-row justify-between">
            <div class="mb-6 md:mb-0">
                <div class="flex items-center space-x-2 mb-4">
                    <span class="text-2xl font-bold text-white">🏆</span>
                    <span class="text-xl font-semibold">BidMaster</span>
                </div>
                <p class="text-gray-400 max-w-xs">Your trusted platform for online auctions and bidding.</p>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-8">
                <div>
                    <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
                    <ul class="space-y-2">
                        <li><a href="index.jsp" class="text-gray-400 hover:text-white">Home</a></li>
                        <li><a href="auctionList" class="text-gray-400 hover:text-white">Auctions</a></li>
                        <li><a href="#about" class="text-gray-400 hover:text-white">About Us</a></li>
                    </ul>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Legal</h3>
                    <ul class="space-y-2">
                        <li><a href="#" class="text-gray-400 hover:text-white">Terms of Service</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white">Privacy Policy</a></li>
                    </ul>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Contact</h3>
                    <ul class="space-y-2">
                        <li class="text-gray-400">support@bidmaster.com</li>
                        <li class="text-gray-400">+1 (555) 123-4567</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400 text-sm">
            © 2025 BidMaster. All rights reserved.
        </div>
    </div>
</footer>
</body>
</html>