<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đã xảy ra lỗi</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; background-color: #f8fafc; margin: 0; }
        .error-container { text-align: center; padding: 40px; background-color: white; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        h1 { font-size: 2rem; color: #dc2626; }
        p { color: #475569; font-size: 1.1rem; }
        a { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #2563eb; color: white; text-decoration: none; border-radius: 8px; }
    </style>
</head>
<body>
<div class="error-container">
    <h1>😕 Đã có lỗi xảy ra</h1>
    <p>Hệ thống gặp phải một sự cố không mong muốn. Vui lòng thử lại sau.</p>
    <a href="${pageContext.request.contextPath}/login.jsp">Về trang đăng nhập</a>
</div>
</body>
</html>