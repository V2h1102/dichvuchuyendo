<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-- Header Fragment for JSP -->
<header class="sticky top-0 z-50 w-full border-b border-border bg-background/95 backdrop-blur">
    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex h-16 items-center justify-between">
            <div class="flex items-center">
                <div class="flex items-center space-x-2">
                    <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center">
                        <i class="fas fa-truck text-primary-foreground"></i>
                    </div>
                    <span class="text-xl font-bold text-foreground">${companyName != null ? companyName : 'MoveEasy'}</span>
                </div>
            </div>
            
            <nav class="hidden md:flex items-center space-x-8">
                <a href="index.jsp" class="text-foreground hover:text-primary transition-colors">Trang Chủ</a>
                <a href="#services" class="text-foreground hover:text-primary transition-colors">Dịch Vụ</a>
                <a href="#about" class="text-foreground hover:text-primary transition-colors">Giới Thiệu</a>
                <a href="#contact" class="text-foreground hover:text-primary transition-colors">Liên Hệ</a>
            </nav>
            
            <div class="flex items-center space-x-4">
                <!-- Notifications -->
                <div class="dropdown relative">
                    <button onclick="toggleDropdown('notifications')" class="relative p-2 text-foreground hover:text-primary transition-colors">
                        <i class="fas fa-bell text-xl"></i>
                        <% if (request.getAttribute("notificationCount") != null && (Integer) request.getAttribute("notificationCount") > 0) { %>
                            <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">${notificationCount}</span>
                        <% } else { %>
                            <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">3</span>
                        <% } %>
                    </button>
                    <div id="notifications" class="dropdown-content absolute right-0 top-full mt-2 w-64 bg-background border border-border rounded-lg shadow-lg hidden">
                        <div class="p-4 border-b border-border">
                            <h3 class="font-semibold text-foreground">Thông Báo</h3>
                        </div>
                        <% 
                        List<String> notifications = (List<String>) request.getAttribute("notifications");
                        if (notifications != null && !notifications.isEmpty()) {
                            for (String notification : notifications) {
                        %>
                            <a href="#" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors"><%= notification %></a>
                        <% 
                            }
                        } else {
                        %>
                            <a href="#" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors">Đơn hàng mới đã được tạo</a>
                            <a href="#" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors">Cập nhật hệ thống</a>
                            <a href="#" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors">Báo cáo tháng đã sẵn sàng</a>
                        <% } %>
                    </div>
                </div>
                
                <!-- Dark Mode Toggle -->
                <button onclick="toggleDarkMode()" id="darkModeToggle" class="p-2 text-foreground hover:text-primary transition-colors">
                    <i id="sunIcon" class="fas fa-sun text-xl"></i>
                    <i id="moonIcon" class="fas fa-moon text-xl hidden"></i>
                </button>
                
                <!-- User Profile -->
                <div class="dropdown relative">
                    <button onclick="toggleDropdown('userProfile')" class="flex items-center space-x-2 p-2 rounded-lg hover:bg-muted transition-colors">
                        <img src="${user != null && user.avatar != null ? user.avatar : '/assets/images/user/1.jpg'}" alt="User" class="w-8 h-8 rounded-full">
                        <div class="text-left hidden sm:block">
                            <div class="text-sm font-medium text-foreground">${user != null && user.name != null ? user.name : 'Nguyễn Văn A'}</div>
                            <div class="text-xs text-muted-foreground">${user != null && user.role != null ? user.role : 'Quản trị viên'}</div>
                        </div>
                    </button>
                    <div id="userProfile" class="dropdown-content absolute right-0 top-full mt-2 w-64 bg-background border border-border rounded-lg shadow-lg hidden">
                        <div class="p-4 border-b border-border">
                            <div class="flex items-center space-x-3">
                                <img src="${user != null && user.avatar != null ? user.avatar : '/assets/images/user/1.jpg'}" alt="User" class="w-10 h-10 rounded-full">
                                <div>
                                    <div class="font-medium text-foreground">${user != null && user.name != null ? user.name : 'Nguyễn Văn A'}</div>
                                    <div class="text-sm text-muted-foreground">${user != null && user.email != null ? user.email : 'admin@moveeasy.com'}</div>
                                </div>
                            </div>
                        </div>
                        <a href="/profile" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors">
                            <i class="fas fa-user mr-2"></i>Hồ Sơ
                        </a>
                        <a href="${pageContext.request.contextPath}/admin" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors">
                            <i class="fas fa-tachometer-alt mr-2"></i>Admin Dashboard
                        </a>
                        <a href="/settings" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors">
                            <i class="fas fa-cog mr-2"></i>Cài Đặt
                        </a>
                        <div class="border-t border-border"></div>
                        <a href="/logout" class="block px-4 py-3 text-red-600 hover:bg-red-50 transition-colors">
                            <i class="fas fa-sign-out-alt mr-2"></i>Đăng Xuất
                        </a>
                    </div>
                </div>
                
                <a href="${pageContext.request.contextPath}/booking.html" class="bg-primary hover:bg-primary/90 text-primary-foreground px-4 py-2 rounded-lg font-medium transition-colors">
                    <i class="fas fa-calendar-plus mr-2"></i>Đặt Lịch
                </a>
            </div>
        </div>
    </div>
</header>

<script>
    // Dropdown functionality
    function toggleDropdown(dropdownId) {
        const dropdown = document.getElementById(dropdownId);
        
        // Close other dropdowns
        document.querySelectorAll('.dropdown-content').forEach(otherDropdown => {
            if (otherDropdown !== dropdown) {
                otherDropdown.classList.add('hidden');
            }
        });
        
        dropdown.classList.toggle('hidden');
    }

    // Close dropdowns when clicking outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.dropdown')) {
            document.querySelectorAll('.dropdown-content').forEach(dropdown => {
                dropdown.classList.add('hidden');
            });
        }
    });

    // Dark mode functionality
    function toggleDarkMode() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        
        // Toggle icons
        const sunIcon = document.getElementById('sunIcon');
        const moonIcon = document.getElementById('moonIcon');
        
        if (newTheme === 'dark') {
            sunIcon.classList.add('hidden');
            moonIcon.classList.remove('hidden');
        } else {
            sunIcon.classList.remove('hidden');
            moonIcon.classList.add('hidden');
        }
    }

    // Load saved theme
    document.addEventListener('DOMContentLoaded', function() {
        const savedTheme = localStorage.getItem('theme') || 'light';
        document.documentElement.setAttribute('data-theme', savedTheme);
        
        // Set initial icon state
        const sunIcon = document.getElementById('sunIcon');
        const moonIcon = document.getElementById('moonIcon');
        
        if (savedTheme === 'dark') {
            sunIcon.classList.add('hidden');
            moonIcon.classList.remove('hidden');
        } else {
            sunIcon.classList.remove('hidden');
            moonIcon.classList.add('hidden');
        }
    });
</script>