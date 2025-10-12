<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moving Furniture - Reset Password</title>

    <%-- Sử dụng JSP EL để tạo đường dẫn chính xác --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="login-container">
    <div class="left-panel">
        <div class="left-content">
            <div class="logo-section">
                <div class="logo-icon">
                    <div class="logo-inner"></div>
                </div>
                <h1 class="logo-text">Moving Furniture</h1>
            </div>
            <div class="hero-section">
                <h2 class="hero-title">Quản lý việc vận chuyển của bạn một cách dễ dàng.</h2>
                <p class="hero-description">
                    Lấy lại quyền truy cập vào tài khoản của bạn.
                </p>
            </div>
            <div class="footer-section">
                <span>Copyright © 2025 Moving Furniture Enterprises LTD.</span>
                <span class="privacy-link">Privacy Policy</span>
            </div>
        </div>
    </div>

    <div class="right-panel">
        <div class="form-container">
            <a href="${pageContext.request.contextPath}/login.jsp" class="back-button">
                <svg class="back-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                    <path d="M19 12H5"/>
                    <path d="M12 19l-7-7 7-7"/>
                </svg>
            </a>

            <div class="mobile-logo">
                <div class="logo-icon mobile">
                    <div class="logo-inner"></div>
                </div>
                <h1 class="logo-text">Moving Furniture</h1>
            </div>

            <div class="form-content">
                <div class="form-header">
                    <h2 class="form-title">Quên Mật Khẩu</h2>
                    <p class="form-description">Nhập địa chỉ email của bạn và chúng tôi sẽ gửi cho bạn một liên kết để đặt lại mật khẩu.</p>
                </div>

                <%-- Khu vực hiển thị thông báo thành công hoặc lỗi --%>
                <% if ("true".equals(request.getParameter("success"))) { %>
                <div style="color: green; background-color: #e6f7ec; border: 1px solid #b7ebc9; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                    ✅ Một liên kết đặt lại mật khẩu đã được gửi đến email của bạn.
                </div>
                <% } %>
                <% if ("notfound".equals(request.getParameter("error"))) { %>
                <div style="color: red; margin-bottom: 1rem;">
                    ❌ Không tìm thấy tài khoản nào với email này.
                </div>
                <% } %>

                <%-- Cập nhật form để gửi dữ liệu đến servlet --%>
                <form class="login-form" id="forgotForm" action="forgot-password" method="post">
                    <div class="form-group">
                        <label for="email" class="form-label">Email</label>
                        <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="user@company.com"
                                class="form-input"
                                required
                        />
                    </div>

                    <button type="submit" class="submit-btn">Gửi Liên Kết Đặt Lại</button>

                    <div class="form-footer">
                        Đã nhớ mật khẩu?
                        <a href="${pageContext.request.contextPath}/login.jsp" class="link">Quay về trang đăng nhập.</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>