<%@ page import="com.menuka.ee.model.User" %>
<%
    // Check if user is already defined
    User headerUser = (User) session.getAttribute("user");
%>
<!-- Tailwind CSS CDN -->
<script src="https://cdn.tailwindcss.com"></script>

<header class="fixed top-0 w-full bg-white shadow-md z-50">
    <div class="container mx-auto px-4 py-3 flex items-center justify-between">
        <!-- Logo -->
        <div class="flex items-center space-x-2">
            <span class="text-xl font-semibold">BidMaster</span>
        </div>

        <!-- Navigation -->
        <nav class="hidden md:flex items-center space-x-8">
            <a href="index.jsp" class="text-gray-800 hover:text-blue-600 font-medium">Home</a>
            <a href="auctionList" class="text-gray-800 hover:text-blue-600 font-medium">Auctions</a>
            <a href="#about" class="text-gray-800 hover:text-blue-600 font-medium">About Us</a>
        </nav>

        <!-- Auth Section -->
        <div class="flex items-center space-x-4">
            <% if (headerUser != null) { %>
            <div class="flex items-center">
                <span class="text-gray-700 mr-3">Hello, <span class="font-medium"><%= headerUser.getName() %></span></span>
                <div class="relative group">
                    <button class="flex items-center text-sm font-medium text-gray-700 hover:text-blue-600">
                                <span class="h-8 w-8 rounded-full bg-blue-100 flex items-center justify-center text-blue-600">
                                    <%= headerUser.getName().substring(0, 1).toUpperCase() %>
                                </span>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                        </svg>
                    </button>
                    <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 hidden group-hover:block">
                        <% if ("admin".equalsIgnoreCase(headerUser.getRole())) { %>
                        <a href="create-auction.jsp" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Create Auction</a>
                        <% } %>
                        <a href="placeBid.jsp" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Place Bid</a>
                        <a href="logout" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Logout</a>
                    </div>
                </div>
            </div>
            <% } else { %>
            <a href="login.jsp" class="text-blue-600 hover:text-blue-800 font-medium">Login</a>
            <a href="register.jsp" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md font-medium">Register</a>
            <% } %>
        </div>
    </div>
</header>