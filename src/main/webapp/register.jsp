<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moving Furniture - Register</title>

    <%-- Thay thế th:href bằng cú pháp JSP --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <%-- JavaScript để kiểm tra mật khẩu khớp nhau --%>
    <script>
        // Chờ cho toàn bộ trang được tải xong
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.getElementById("registerForm");
            const password = document.getElementById("password");
            const confirmPassword = document.getElementById("confirmPassword");

            form.addEventListener("submit", function (event) {
                // Nếu mật khẩu không khớp
                if (password.value !== confirmPassword.value) {
                    event.preventDefault(); // Chặn form gửi đi
                    alert("❌ Mật khẩu và Xác nhận mật khẩu không khớp!");
                    confirmPassword.focus(); // Tập trung vào ô xác nhận mật khẩu
                }
            });
        });
    </script>
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
                    Tạo tài khoản để bắt đầu hành trình của bạn với chúng tôi.
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
                    <h2 class="form-title">Tạo tài khoản</h2>
                    <p class="form-description">Tạo một tài khoản mới để bắt đầu với Moving Furniture.</p>
                </div>

                <%-- Thêm khu vực để hiển thị thông báo lỗi từ Servlet (ví dụ: email đã tồn tại) --%>
                <% if ("exists".equals(request.getParameter("error"))) { %>
                <div style="color: red; margin-bottom: 1rem;">
                    ❌ Email này đã được sử dụng!
                </div>
                <% } %>

                <%-- Form đăng ký, đã loại bỏ Thymeleaf và thêm id="registerForm" --%>
                <form class="login-form" id="registerForm" action="register" method="post">

                    <div class="form-group">
                        <label for="fullName" class="form-label">Họ và tên đầy đủ</label>
                        <input
                                type="text"
                                id="fullName"
                                name="fullName"
                                placeholder="Nhập họ và đầy đủ tên"
                                class="form-input"
                                required
                        />
                    </div>

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

                    <div class="form-group">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input
                                type="tel"
                                id="phone"
                                name="phone"
                                placeholder="Nhập số điện thoại"
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
                                    name="password" <%-- ✅ QUAN TRỌNG: Gửi mật khẩu thô, việc băm là của backend --%>
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

                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                        <div class="password-input-container">
                            <input
                                    type="password"
                                    id="confirmPassword"
                                    name="confirmPassword"
                                    placeholder="Xác nhận mật khẩu"
                                    class="form-input password-input"
                                    required
                            />
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                <svg class="eye-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                    <circle cx="12" cy="12" r="3"/>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">Tạo tài khoản</button>

                    <div class="divider">
                        <div class="divider-line"></div>
                        <span class="divider-text">Hoặc tiếp tục với</span>
                        <div class="divider-line"></div>
                    </div>

                    <div class="social-buttons">
                        <button type="button" class="social-btn">Google</button>
                        <button type="button" class="social-btn">Apple</button>
                    </div>

                    <div class="form-footer">
                        Bạn đã có tài khoản?
                        <a href="login.jsp" class="link">Đăng nhập.</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>