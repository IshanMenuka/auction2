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
    <title>Register - BidMaster</title>
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

            <h1 class="text-4xl font-bold text-white mb-6">Join Our Community.<br>Discover Unique Items.<br>Win Great Deals.</h1>

            <p class="text-lg text-blue-100 mb-8">Create your account today and start bidding on thousands of exciting auctions.</p>

            <!-- Features -->
            <div class="space-y-4 mb-8">
                <div class="flex items-start">
                    <div class="flex-shrink-0 h-6 w-6 text-blue-300 mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                    <p class="text-blue-100">Access to exclusive auctions and limited items</p>
                </div>
                <div class="flex items-start">
                    <div class="flex-shrink-0 h-6 w-6 text-blue-300 mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                    <p class="text-blue-100">Secure bidding with real-time notifications</p>
                </div>
                <div class="flex items-start">
                    <div class="flex-shrink-0 h-6 w-6 text-blue-300 mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                    <p class="text-blue-100">Transparent transaction process with buyer protection</p>
                </div>
            </div>

            <!-- Testimonial -->
            <div class="bg-white/10 p-4 rounded-lg backdrop-blur-sm border border-white/20 mt-6">
                <p class="italic text-blue-50">"Signing up was quick and easy. Within minutes I was bidding on my first item. The experience has been fantastic!"</p>
                <p class="text-blue-200 mt-2 font-medium">— Sarah J., New Member</p>
            </div>
        </div>
    </div>

    <!-- Right Side - Registration Form -->
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
                    <h2 class="text-2xl font-bold text-gray-800">Create Your Account</h2>
                    <p class="text-gray-600 mt-1">Join thousands of auction enthusiasts</p>
                </div>

                <!-- Error message placeholder -->
                <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-50 text-red-500 p-3 rounded-md mb-4 text-sm">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <!-- Registration Form -->
                <form method="post" action="register" class="space-y-5">
                    <div>
                        <label for="name" class="block text-gray-700 text-sm font-medium mb-2">Full Name</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                </svg>
                            </div>
                            <input type="text" id="name" name="name" required
                                   class="w-full pl-10 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="John Doe">
                        </div>
                    </div>

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
                        <p class="text-xs text-gray-500 mt-1">Must be at least 8 characters</p>
                    </div>

                    <div>
                        <label for="role" class="block text-gray-700 text-sm font-medium mb-2">Account Type</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                                </svg>
                            </div>
                            <select name="role" id="role" class="w-full pl-10 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <option value="user">Regular User</option>
                                <option value="admin">Administrator</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex items-center">
                        <input type="checkbox" id="terms" name="terms" required
                               class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                        <label for="terms" class="ml-2 block text-sm text-gray-700">
                            I agree to the <a href="#" class="text-blue-600 hover:text-blue-800">Terms of Service</a> and <a href="#" class="text-blue-600 hover:text-blue-800">Privacy Policy</a>
                        </label>
                    </div>

                    <button type="submit"
                            class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 px-4 rounded-lg font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        Create Account
                    </button>
                </form>

                <div class="mt-6 text-center text-gray-600 text-sm">
                    Already have an account?
                    <a href="login.jsp" class="text-blue-600 hover:text-blue-800 font-medium">
                        Sign In
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