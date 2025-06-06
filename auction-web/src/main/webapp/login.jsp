<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.menuka.ee.model.User" %>
<%
    // Define user variable before including header.jsp
    User user = (session != null) ? (User) session.getAttribute("user") : null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - BidMaster</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen">
<div class="flex min-h-screen">
    <!-- Left Side - Auction Image Showcase -->
    <div class="hidden lg:flex lg:w-1/2 bg-blue-700 relative overflow-hidden">
        <!-- Dark overlay to improve text readability -->
        <div class="absolute inset-0 bg-gradient-to-r from-blue-900/90 to-blue-700/75 z-10"></div>



        <!-- Content overlay -->
        <div class="relative z-20 flex flex-col justify-center px-10 py-20 w-full">
            <div class="flex items-center mb-6">
                <span class="text-3xl font-bold text-white mr-2">🏆</span>
                <span class="text-2xl font-bold text-white">BidMaster</span>
            </div>

            <h1 class="text-4xl font-bold text-white mb-6">Find Treasures. <br>Make Offers. <br>Win Auctions.</h1>

            <p class="text-lg text-blue-100 mb-8">Join thousands of smart bidders who trust BidMaster for unique finds at competitive prices.</p>

            <!-- Testimonial -->
            <div class="bg-white/10 p-4 rounded-lg backdrop-blur-sm border border-white/20 mt-6">
                <p class="italic text-blue-50">"I found a rare vintage watch at 40% below retail. BidMaster made the entire process smooth and secure."</p>
                <p class="text-blue-200 mt-2 font-medium">— Michael S., Premium Member</p>
            </div>

            <!-- Stats -->
            <div class="mt-10 grid grid-cols-3 gap-4">
                <div class="text-center">
                    <div class="text-white text-3xl font-bold">50k+</div>
                    <div class="text-blue-200 text-sm">Active Users</div>
                </div>
                <div class="text-center">
                    <div class="text-white text-3xl font-bold">100k+</div>
                    <div class="text-blue-200 text-sm">Auctions</div>
                </div>
                <div class="text-center">
                    <div class="text-white text-3xl font-bold">99%</div>
                    <div class="text-blue-200 text-sm">Satisfaction</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Side - Login Form -->
    <div class="w-full lg:w-1/2 flex items-center justify-center p-6">
        <div class="max-w-md w-full">
            <!-- Logo for mobile view -->
            <div class="lg:hidden flex justify-center mb-8">
                <div class="flex items-center">
                    <span class="text-3xl font-bold text-blue-600 mr-2">🏆</span>
                    <span class="text-2xl font-bold text-gray-800">BidMaster</span>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-lg p-8">
                <div class="text-center mb-8">
                    <h2 class="text-2xl font-bold text-gray-800">Welcome Back</h2>
                    <p class="text-gray-600 mt-1">Enter your credentials to access your account</p>
                </div>

                <!-- Error message placeholder -->
                <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-50 text-red-500 p-3 rounded-md mb-4 text-sm">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <!-- Login Form -->
                <form method="post" action="login" class="space-y-5">
                    <div>
                        <label for="email" class="block text-gray-700 text-sm font-medium mb-2">Email Address</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
                                </svg>
                            </div>
                            <input type="email" id="email" name="email" required
                                   class="w-full pl-10 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="your@email.com">
                        </div>
                    </div>

                    <div>
                        <label for="password" class="block text-gray-700 text-sm font-medium mb-2">Password</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                </svg>
                            </div>
                            <input type="password" id="password" name="password" required
                                   class="w-full pl-10 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="••••••••">
                        </div>
                    </div>

                    <div class="flex items-center justify-between text-sm">
                        <div class="flex items-center">
                            <input type="checkbox" id="remember" name="remember"
                                   class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                            <label for="remember" class="ml-2 block text-gray-700">Remember me</label>
                        </div>
                        <a href="#" class="text-blue-600 hover:text-blue-800 font-medium">Forgot password?</a>
                    </div>

                    <button type="submit"
                            class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 px-4 rounded-lg font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        Sign In
                    </button>
                </form>



                <div class="mt-6 text-center text-gray-600 text-sm">
                    Don't have an account?
                    <a href="register.jsp" class="text-blue-600 hover:text-blue-800 font-medium">
                        Create Account
                    </a>
                </div>
            </div>

            <div class="text-center mt-6">
                <a href="index.jsp" class="text-blue-600 hover:text-blue-800 inline-flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Back to Home
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>