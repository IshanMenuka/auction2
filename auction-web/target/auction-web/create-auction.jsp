<%@ page import="com.menuka.ee.model.User" %>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    } else if (!"admin".equalsIgnoreCase(user.getRole())) {
%>
<p style="color:red;">❌ Only admins can access this page.</p>
<a href="index.jsp">Back to Home</a>
<% return; }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Auction - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-50">

<jsp:include page="header.jsp" />

<!-- Add spacing for fixed header -->
<div class="pt-16"></div>

<div class="max-w-4xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
    <div class="bg-white rounded-xl shadow-lg overflow-hidden">
        <!-- Header Banner -->
        <div class="bg-gradient-to-r from-blue-500 to-indigo-600 px-8 py-6">
            <h1 class="text-2xl font-bold text-white flex items-center">
                <i class="fas fa-gavel mr-3"></i> Create New Auction
            </h1>
            <p class="mt-2 text-blue-100 max-w-3xl">
                Complete the form below to create a new auction that will be available to all users
            </p>
        </div>

        <!-- Form Section -->
        <div class="p-8">
            <form method="post" action="createAuction" class="space-y-6">
                <!-- Two column layout -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Left Column -->
                    <div class="space-y-6">


                        <div>
                            <label for="title" class="block text-sm font-medium text-gray-700">
                                Auction Title
                            </label>
                            <div class="mt-1 relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-heading text-gray-400"></i>
                                </div>
                                <input type="text" name="title" id="title" required
                                       class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md"
                                       placeholder="Enter a catchy title">
                            </div>
                        </div>

                        <div>
                            <label for="description" class="block text-sm font-medium text-gray-700">
                                Description
                            </label>
                            <div class="mt-1">
                                <textarea id="description" name="description" rows="4" required
                                          class="shadow-sm focus:ring-blue-500 focus:border-blue-500 block w-full sm:text-sm border-gray-300 rounded-md"
                                          placeholder="Provide detailed information about this item"></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="space-y-6">
                        <div class="flex space-x-4">
                            <div class="w-1/2">
                                <label for="startTime" class="block text-sm font-medium text-gray-700">
                                    <i class="far fa-calendar-plus mr-1 text-green-500"></i> Start Time
                                </label>
                                <div class="mt-1">
                                    <input type="datetime-local" name="startTime" id="startTime" required
                                           class="focus:ring-green-500 focus:border-green-500 block w-full sm:text-sm border-gray-300 rounded-md">
                                </div>
                            </div>
                            <div class="w-1/2">
                                <label for="endTime" class="block text-sm font-medium text-gray-700">
                                    <i class="far fa-calendar-check mr-1 text-red-500"></i> End Time
                                </label>
                                <div class="mt-1">
                                    <input type="datetime-local" name="endTime" id="endTime" required
                                           class="focus:ring-red-500 focus:border-red-500 block w-full sm:text-sm border-gray-300 rounded-md">
                                </div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="far fa-images mr-1 text-purple-500"></i> Auction Images
                            </label>
                            <div class="space-y-3">
                                <div class="relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <span class="text-blue-500 text-xs font-medium">1</span>
                                    </div>
                                    <input type="url" name="image1"
                                           class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md"
                                           placeholder="Primary image URL">
                                </div>
                                <div class="relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <span class="text-blue-500 text-xs font-medium">2</span>
                                    </div>
                                    <input type="url" name="image2"
                                           class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md"
                                           placeholder="Secondary image URL">
                                </div>
                                <div class="relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <span class="text-blue-500 text-xs font-medium">3</span>
                                    </div>
                                    <input type="url" name="image3"
                                           class="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 sm:text-sm border-gray-300 rounded-md"
                                           placeholder="Additional image URL">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Preview section (optional) -->
                <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                    <h3 class="text-sm font-medium text-gray-500 mb-3">
                        <i class="fas fa-eye mr-1"></i> Image Preview
                    </h3>
                    <div class="grid grid-cols-3 gap-2" id="image-preview">
                        <div class="bg-gray-200 rounded h-24 flex items-center justify-center">
                            <span class="text-gray-400 text-sm">Image 1</span>
                        </div>
                        <div class="bg-gray-200 rounded h-24 flex items-center justify-center">
                            <span class="text-gray-400 text-sm">Image 2</span>
                        </div>
                        <div class="bg-gray-200 rounded h-24 flex items-center justify-center">
                            <span class="text-gray-400 text-sm">Image 3</span>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="flex justify-end pt-5">
                    <button type="button" onclick="window.location='auctionList'" class="bg-gray-200 py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 mr-3">
                        Cancel
                    </button>
                    <button type="submit" class="inline-flex justify-center py-2 px-6 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        <i class="fas fa-gavel mr-2"></i> Create Auction
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Simple image preview script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const imageInputs = ['image1', 'image2', 'image3'];
        const previewContainers = document.querySelectorAll('#image-preview > div');

        imageInputs.forEach((id, index) => {
            const input = document.querySelector(`[name="${id}"]`);
            input.addEventListener('input', function() {
                const url = this.value.trim();
                if (url) {
                    previewContainers[index].innerHTML = `<img src="${url}" class="h-full w-full object-cover rounded" onerror="this.onerror=null;this.src='';this.outerHTML='<span class=\'text-red-500 text-xs\'>Invalid image URL</span>'">`;
                } else {
                    previewContainers[index].innerHTML = `<span class="text-gray-400 text-sm">Image ${index+1}</span>`;
                }
            });
        });
    });
</script>

</body>
</html>