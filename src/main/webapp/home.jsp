<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Trang Chủ</title>--%>
<%--</head>--%>
<%--<body>--%>

<%--&lt;%&ndash; Kiểm tra xem người dùng đã đăng nhập chưa bằng cách xem session &ndash;%&gt;--%>
<%--<% if (session.getAttribute("user") != null) { %>--%>

<%--<h1>Chào mừng trở lại, ${sessionScope.user}!</h1>--%>
<%--<p>Bạn đã đăng nhập thành công.</p>--%>
<%--<a href="logout">Đăng xuất</a>--%>

<%--<% } else { %>--%>

<%--<h1>Bạn chưa đăng nhập!</h1>--%>
<%--<p>Vui lòng đăng nhập để tiếp tục.</p>--%>
<%--<a href="login.jsp">Về trang đăng nhập</a>--%>

<%--<% } %>--%>

<%--</body>--%>
<%--</html>--%>
<%-- Khai báo page và thư viện thẻ JSTL --%>
<%-- Khai báo page và thư viện thẻ JSTL --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'MovingFurniture - Nền tảng cung cấp dịch vụ chuyển đồ'}</title>
    <style>
        /* Toàn bộ CSS của bạn giữ nguyên ở đây */
        /* CSS Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-color: #2563eb;
            --primary-hover: #1d4ed8;
            --secondary-color: #64748b;
            --accent-color: #f59e0b;
            --background: #ffffff;
            --surface: #f8fafc;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border: #e2e8f0;
            --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }

        [data-theme="dark"] {
            --background: #0f172a;
            --surface: #1e293b;
            --text-primary: #f1f5f9;
            --text-secondary: #94a3b8;
            --border: #334155;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            background-color: var(--background);
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* Header Styles */
        .header {
            background: var(--background);
            border-bottom: 1px solid var(--border);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary-color);
            text-decoration: none;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
        }

        .nav-menu a {
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-menu a:hover {
            color: var(--primary-color);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        /* Dropdown Styles */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-toggle {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 0.5rem;
            transition: background-color 0.3s ease;
            position: relative;
        }

        .dropdown-toggle:hover {
            background-color: var(--surface);
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--background);
            border: 1px solid var(--border);
            border-radius: 0.5rem;
            box-shadow: var(--shadow);
            min-width: 200px;
            z-index: 1000;
            display: none;
        }

        .dropdown-menu.show {
            display: block;
        }

        .dropdown-item {
            display: block;
            padding: 0.75rem 1rem;
            color: var(--text-primary);
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .dropdown-item:hover {
            background-color: var(--surface);
        }

        .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ef4444;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Button Styles */
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-hover);
        }

        .btn-secondary {
            background: transparent;
            color: var(--text-primary);
            border: 1px solid var(--border);
        }

        .btn-secondary:hover {
            background: var(--surface);
        }

        /* Hero Section */
        .hero {
            padding: 4rem 0;
            text-align: center;
            background: linear-gradient(135deg, var(--surface) 0%, var(--background) 100%);
        }

        .hero-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .hero h1 {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero p {
            font-size: 1.25rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .hero-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        /* Features Section */
        .features {
            padding: 4rem 0;
        }

        .features-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .features h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background: var(--background);
            border: 1px solid var(--border);
            border-radius: 1rem;
            padding: 2rem;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            background: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: white;
            font-size: 1.5rem;
        }

        /* Footer */
        .footer {
            background: var(--surface);
            padding: 2rem 0;
            border-top: 1px solid var(--border);
            text-align: center;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-menu {
                display: none;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero-actions {
                flex-direction: column;
                align-items: center;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Dark mode icons */
        .theme-toggle .sun-icon {
            display: block;
        }

        .theme-toggle .moon-icon {
            display: none;
        }

        [data-theme="dark"] .theme-toggle .sun-icon {
            display: none;
        }

        [data-theme="dark"] .theme-toggle .moon-icon {
            display: block;
        }
    </style>
</head>
<body>
<header class="header">
    <div class="header-container">
        <a href="#" class="logo">
            <span>📊</span>
            <span>${not empty companyName ? companyName : 'MovingFurniture'}</span>
        </a>

        <nav class="nav-menu">
            <li><a href="#features">Tính năng</a></li>
            <li><a href="#pricing">Bảng Giá</a></li>
            <li><a href="#about">Về chúng tôi</a></li>
            <li><a href="#contact">Liên Hệ</a></li>
        </nav>

        <div class="header-actions">
            <div class="dropdown" id="notificationsDropdown">
                <button class="dropdown-toggle" onclick="toggleDropdown('notificationsDropdown')">
                    <span>🔔</span>
                    <c:if test="${notificationCount > 0}">
                        <span class="badge">${notificationCount}</span>
                    </c:if>
                </button>
                <div class="dropdown-menu">
                    <c:choose>
                        <c:when test="${not empty notifications}">
                            <c:forEach var="notification" items="${notifications}">
                                <a href="#" class="dropdown-item">${notification.message}</a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <a href="#" class="dropdown-item">Người dùng mới đăng kí</a>
                            <a href="#" class="dropdown-item">Bản cập nhật hệ thống có sẵn</a>
                            <a href="#" class="dropdown-item">Báo cáo hàng tháng đã sẵn sàng</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <button class="dropdown-toggle theme-toggle" onclick="toggleTheme()">
                <span class="sun-icon">☀️</span>
                <span class="moon-icon">🌙</span>
            </button>

            <div class="dropdown" id="userDropdown">
                <button class="dropdown-toggle" onclick="toggleDropdown('userDropdown')">
                    <img src="${not empty sessionScope.user.avatarUrl ? sessionScope.user.avatarUrl : pageContext.request.contextPath.concat('/public/placeholder-user.png')}"
                         alt="User Avatar"
                         style="width: 32px; height: 32px; border-radius: 50%;">
                </button>
                <div class="dropdown-menu">
                    <div style="padding: 1rem; border-bottom: 1px solid var(--border);">
                        <div style="font-weight: 600;">${not empty sessionScope.user.fullName ? sessionScope.user.fullName : 'John Doe'}</div>
                        <div style="font-size: 0.875rem; color: var(--text-secondary);">${not empty sessionScope.user.userType ? sessionScope.user.userType : 'Administrator'}</div>
                    </div>
                    <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">👤 Hồ sơ</a>
                    <a href="${pageContext.request.contextPath}/settings" class="dropdown-item">⚙️ Cài đặt</a>
                    <form action="${pageContext.request.contextPath}/logout" method="post">
                        <button type="submit" class="dropdown-item" style="width:100%; text-align:left; border:none; background:none; cursor:pointer;">🚪 Đăng xuất</button>
                    </form>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/booking.jsp" class="btn btn-primary">Bắt đầu</a>
        </div>
    </div>
</header>

<section class="hero">
    <div class="hero-container">
        <h1>${not empty heroTitle ? heroTitle : 'Moving Furniture Nền tảng vận chuyển '}</h1>
        <p>${not empty heroDescription ? heroDescription : ''}</p>
        <div class="hero-actions">


        </div>
    </div>
</section>

<section class="features" id="features">
    <div class="features-container">
        <h2>Các tính năng mạnh mẽ cho doanh nghiệp của bạn</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">⚡</div>
                <h3>Tự động hóa quy trình làm việc
                </h3>
                <p>Tự động hóa các tác vụ lập đi lặp lại và hợp lý hóa quy trình kinh doanh của bạn bằng công cụ quy trình
                    làm việc thông mình của chúng tôi.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">👥</div>
                <h3>Hợp tác nhóm</h3>
                <p>Cho phép cộng tác liền mạch giữa các nhóm với các công cụ quản lý dự án và giao tiếp thời giản thực.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3>Phân tích & Thông tin chỉ tiết</h3>
                <p>Nhận thông tin chỉ tiết hữu ích với phân tích toàn diện và bằng thông tin có thể tùy chỉnh để đưa ra quyết định dựa trên dữ liệu</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔒</div>
                <h3>Bảo mật doanh nghiệp</h3>
                <p>Bảo vệ dữ liệu của bạn bằng tỉnh năng báo mặt cấp doanh nghiệp, các tỉnh năng tuân thủ và kiểm soát truy cập năng cao.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔗</div>
                <h3>Tích hợp API</h3>
                <p>Kết nối với các công cụ hiện có của bạn thông qua API mạnh mẽ và thị trường tích hợp rộng lớn của chúng tôi.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3>Sản sàng cho thiết bị di động</h3>
                <p>Truy cập các công cụ kinh doanh của bạn ở mọi nơi với thiết kế đáp ứng và ứng dụng di động gốc của chúng tôi</p>
            </div>
        </div>
    </div>
</section>

<footer class="footer">
    <div style="max-width: 1200px; margin: 0 auto; padding: 0 1rem;">
        <p>&copy; 2025 ${not empty companyName ? companyName : 'StreamLine'}. Mọi quyền được bảo lưu.</p>
    </div>
</footer>

<script>
    // Dropdown functionality
    function toggleDropdown(dropdownId) {
        const dropdown = document.getElementById(dropdownId);
        const menu = dropdown.querySelector('.dropdown-menu');

        // Close other dropdowns
        document.querySelectorAll('.dropdown-menu').forEach(otherMenu => {
            if (otherMenu !== menu) {
                otherMenu.classList.remove('show');
            }
        });

        menu.classList.toggle('show');
    }

    // Close dropdowns when clicking outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.dropdown')) {
            document.querySelectorAll('.dropdown-menu').forEach(menu => {
                menu.classList.remove('show');
            });
        }
    });

    // Dark mode functionality
    function toggleTheme() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';

        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
    }

    // Load saved theme
    document.addEventListener('DOMContentLoaded', function() {
        const savedTheme = localStorage.getItem('theme') || 'light';
        document.documentElement.setAttribute('data-theme', savedTheme);
    });

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
</script>
</body>
</html>