<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moving Furniture - Đặt Lại Mật Khẩu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="login-container">
    <div class="left-panel">
        <div class="left-content">
            <div class="logo-section">
                <div class="logo-icon"><div class="logo-inner"></div></div>
                <h1 class="logo-text">Moving Furniture</h1>
            </div>
            <div class="hero-section">
                <h2 class="hero-title">Tạo mật khẩu mới của bạn</h2>
                <p class="hero-description">
                    Vui lòng nhập mật khẩu mới mạnh và an toàn.
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
            <div class="form-content">
                <div class="form-header">
                    <h2 class="form-title">Đặt Lại Mật Khẩu</h2>
                    <p class="form-description">Nhập và xác nhận mật khẩu mới của bạn.</p>
                </div>

                <%-- Khu vực hiển thị thông báo lỗi từ Servlet --%>
                <% if ("invalid_token".equals(request.getParameter("error"))) { %>
                <div style="color: red; margin-bottom: 1rem;">❌ Token không hợp lệ hoặc đã hết hạn. Vui lòng thử lại.</div>
                <% } %>
                <% if ("password_mismatch".equals(request.getParameter("error"))) { %>
                <div style="color: red; margin-bottom: 1rem;">❌ Mật khẩu và xác nhận mật khẩu không khớp.</div>
                <% } %>

                <form class="login-form" id="resetPasswordForm" action="reset-password" method="post">

                    <%-- ✅ BƯỚC QUAN TRỌNG: Input ẩn để gửi token về server --%>
                    <%-- ${param.token} sẽ tự động lấy giá trị token từ URL --%>
                    <input type="hidden" name="token" value="${param.token}">

                    <div class="form-group">
                        <label for="newPassword" class="form-label">Mật khẩu mới</label>
                        <div class="password-input-container">
                            <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" class="form-input password-input" required />
                            <button type="button" class="password-toggle" onclick="togglePassword('newPassword')">
                                <svg class="eye-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                            </button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                        <div class="password-input-container">
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu mới" class="form-input password-input" required />
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                <svg class="eye-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">Đặt Lại Mật Khẩu</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script>
    // JavaScript để kiểm tra mật khẩu khớp nhau trước khi gửi
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("resetPasswordForm");
        const newPassword = document.getElementById("newPassword");
        const confirmPassword = document.getElementById("confirmPassword");

        form.addEventListener("submit", function (event) {
            if (newPassword.value !== confirmPassword.value) {
                event.preventDefault(); // Chặn form gửi đi
                alert("❌ Mật khẩu và Xác nhận mật khẩu không khớp!");
                confirmPassword.focus();
            }
        });
    });
</script>
</body>
</html>