<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'Dịch Vụ Chuyển Nhà - MoveEasy'}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        background: 'oklch(1 0 0)', foreground: 'oklch(0.35 0 0)', card: 'oklch(0.97 0 0)',
                        'card-foreground': 'oklch(0.35 0 0)', primary: 'oklch(0.45 0.15 162)', 'primary-foreground': 'oklch(1 0 0)',
                        secondary: 'oklch(0.55 0.15 162)', 'secondary-foreground': 'oklch(1 0 0)', muted: 'oklch(0.97 0 0)',
                        'muted-foreground': 'oklch(0.35 0 0)', accent: 'oklch(0.55 0.15 162)', 'accent-foreground': 'oklch(1 0 0)',
                        border: 'oklch(0.9 0 0)', input: 'oklch(1 0 0)', ring: 'oklch(0.45 0.15 162 / 0.5)'
                    }
                }
            }
        }
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body class="bg-background text-foreground">

<header class="bg-background/80 backdrop-blur-sm sticky top-0 z-50 border-b border-border">
    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">
            <a href="${pageContext.request.contextPath}/home.jsp" class="flex items-center gap-2">
                <i class="fas fa-truck text-primary text-2xl"></i>
                <span class="text-xl font-bold text-foreground">MoveEasy</span>
            </a>
            <nav class="hidden md:flex items-center gap-6">
                <a href="#services" class="text-muted-foreground hover:text-primary transition-colors">Dịch Vụ</a>
                <a href="#" class="text-muted-foreground hover:text-primary transition-colors">Bảng Giá</a>
                <a href="#" class="text-muted-foreground hover:text-primary transition-colors">Về Chúng Tôi</a>
            </nav>
            <div class="flex items-center gap-4">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="relative dropdown">
                            <button onclick="toggleDropdown('userDropdownMenu')" class="flex items-center gap-3 p-2 rounded-lg transition-colors hover:bg-muted">
                                <img src="${pageContext.request.contextPath}${not empty sessionScope.user.avatarUrl ? sessionScope.user.avatarUrl : '/public/placeholder-user.png'}" alt="User Avatar" class="w-10 h-10 rounded-full object-cover border-2 border-border">
                                <div class="text-left hidden sm:block">
                                    <div class="font-semibold text-foreground text-sm">${sessionScope.user.fullName}</div>
                                    <div class="text-xs text-muted-foreground">${sessionScope.user.userType}</div>
                                </div>
                            </button>
                            <div id="userDropdownMenu" class="dropdown-content hidden absolute right-0 top-full mt-2 w-64 bg-card border border-border rounded-lg shadow-lg">
                                <div class="p-4 border-b border-border"><div class="font-semibold text-card-foreground">${sessionScope.user.fullName}</div><div class="text-sm text-muted-foreground">${sessionScope.user.email}</div></div>
                                <div class="p-2">
                                    <a href="#" class="flex items-center w-full px-3 py-2 text-sm text-card-foreground rounded-md hover:bg-muted"><i class="fas fa-user-circle w-5 mr-3 text-muted-foreground"></i>Hồ Sơ</a>
                                    <a href="${pageContext.request.contextPath}/admin" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors">
                                        <i class="fas fa-tachometer-alt mr-2"></i>Admin Dashboard
                                    </a>
                                    <a href="/settings" class="block px-4 py-3 text-foreground hover:bg-muted transition-colors">
                                        <i class="fas fa-cog mr-2"></i>Cài Đặt
                                    </a>
                                    <form action="${pageContext.request.contextPath}/logout" method="post" class="w-full">
                                        <button type="submit" class="flex items-center w-full px-3 py-2 text-sm text-red-500 rounded-md hover:bg-red-500/10"><i class="fas fa-sign-out-alt w-5 mr-3"></i>Đăng Xuất</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="hidden sm:inline text-muted-foreground hover:text-primary transition-colors font-medium">Đăng Nhập</a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="bg-primary hover:bg-primary/90 text-primary-foreground px-4 py-2 rounded-lg font-semibold text-sm transition-colors">Đăng Ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>