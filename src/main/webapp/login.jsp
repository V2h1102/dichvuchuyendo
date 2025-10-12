<%-- Khai báo page để sử dụng ký tự UTF-8 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moving Furniture - Login</title>

    <%--
      SỬA LỖI 1: Dùng thẻ <link> của HTML thuần.
      request.getContextPath() sẽ tự động lấy đường dẫn gốc của ứng dụng (ví dụ: /furniture_moving_service_swp391).
      Kết quả cuối cùng sẽ là: href="/your_app_name/css/styles.css"
    --%>
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
                    Đăng nhập để truy cập Moving Furniture của bạn.
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
            <div class="mobile-logo">
                <div class="logo-icon mobile">
                    <div class="logo-inner"></div>
                </div>
                <h1 class="logo-text">Moving Furniture</h1>
            </div>
            <div class="form-content">
                <div class="form-header">
                    <h2 class="form-title">Xin Chào</h2>
                    <p class="form-description">Nhập email và mật khẩu của bạn để truy cập vào tài khoản của bạn.</p>
                </div>

                <%--
                  SỬA LỖI 2: Dùng JSP Scriptlet để hiển thị thông báo động.
                  Thay thế cho th:if. Đoạn mã này sẽ kiểm tra xem URL có tham số "error", "logout", "success" hay không.
                --%>
                <% if ("true".equals(request.getParameter("error"))) { %>
                <div style="color: red; margin-bottom: 1rem;">
                    ❌ Email hoặc mật khẩu không hợp lệ!
                </div>
                <% } %>
                <% if ("true".equals(request.getParameter("logout"))) { %>
                <div style="color: green; margin-bottom: 1rem;">
                    ✅ Bạn đã đăng xuất thành công.
                </div>
                <% } %>
                <% if ("true".equals(request.getParameter("success"))) { %>
                <div style="color: green; margin-bottom: 1rem;">
                    🎉 Đăng ký thành công! Vui lòng đăng nhập.
                </div>
                <% } %>

                <%--
                  SỬA LỖI 3: Dùng thẻ <form> của HTML thuần.
                  Action trỏ đến một Servlet có tên là "login".
                --%>
                <form class="login-form" action="login" method="post">
                    <div class="form-group">
                        <label for="email" class="form-label">Email</label>
                        <input
                                type="text"
                                id="email"
                                name="email"
                                placeholder="Nhập Email của bạn"
                                class="form-input"
                                required
                        />
                    </div>
                    <div class="form-group">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <div class="password-input-container">
                            <input
                                    type="password"
                                    id="password"
                                    name="password"
                                    placeholder="Nhập mật khẩu"
                                    class="form-input password-input"
                                    required
                            />
                            <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                <svg class="eye-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                    <circle cx="12" cy="12" r="3"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <div class="form-options">
                        <div class="remember-me">
                            <input type="checkbox" id="remember" name="remember" class="checkbox">
                            <label for="remember" class="checkbox-label">Ghi nhớ đăng nhập</label>
                        </div>
                        <a href="forgot-password" class="forgot-link">Quên mật khẩu?</a>
                    </div>
                    <button type="submit" class="submit-btn">Đăng nhập</button>
                    <div class="divider">
                        <div class="divider-line"></div>
                        <span class="divider-text">Hoặc đăng nhập với</span>
                        <div class="divider-line"></div>
                    </div>
                    <div class="social-buttons">
                        <button type="button" class="social-btn">Google</button>
                        <button type="button" class="social-btn">Apple</button>
                    </div>
                    <div class="form-footer">
                        Bạn chưa có tài khoản?
                        <a href="register" class="link">Đăng ký ngay.</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>