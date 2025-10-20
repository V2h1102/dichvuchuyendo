<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi Tiết Hợp Đồng - MoveEasy</title>

  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

  <style>
    /* CSS Variables - Mô phỏng màu sắc từ Tailwind config */
    :root {
      /* Màu nền và chữ */
      --background: oklch(1 0 0); /* Trắng */
      --foreground: oklch(0.35 0 0); /* Xám đậm/Gần đen */
      --muted-foreground: oklch(0.35 0 0); /* Xám đậm/Gần đen */

      /* Màu Card */
      --card: oklch(0.97 0 0); /* Trắng nhạt */
      --card-foreground: oklch(0.35 0 0);

      /* Màu chính (Primary - Tông Xanh/Lục) */
      --primary: oklch(0.45 0.15 162);
      --primary-foreground: oklch(1 0 0); /* Trắng */

      /* Màu viền và input */
      --border: oklch(0.9 0 0); /* Xám nhạt */
      --input: oklch(1 0 0); /* Trắng */
      --ring: oklch(0.45 0.15 162 / 0.5); /* Vòng focus mờ */

      /* Typography */
      --font-sans: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif;
    }

    /* Base styles */
    body {
      font-family: var(--font-sans);
      background-color: var(--background);
      color: var(--foreground);
      margin: 0;
      padding: 0;
      line-height: 1.5;
    }

    .container {
      max-width: 1280px; /* Tương đương mx-auto max-w-7xl */
      margin-left: auto;
      margin-right: auto;
      padding-left: 1rem; /* px-4 */
      padding-right: 1rem; /* px-4 */
    }
    @media (min-width: 640px) { /* sm:px-6 */
      .container {
        padding-left: 1.5rem;
        padding-right: 1.5rem;
      }
    }
    @media (min-width: 1024px) { /* lg:px-8 */
      .container {
        padding-left: 2rem;
        padding-right: 2rem;
      }
    }

    /* Header */
    header {
      position: sticky;
      top: 0;
      z-index: 50;
      width: 100%;
      border-bottom: 1px solid var(--border);
      background-color: var(--background);
      /* backdrop-filter: blur(8px); */
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
    }

    .header-content {
      display: flex;
      height: 4rem; /* h-16 */
      align-items: center;
      justify-content: space-between;
    }

    .logo-group {
      display: flex;
      align-items: center;
      gap: 0.5rem; /* space-x-2 */
    }

    .logo-icon-wrapper {
      width: 2rem; /* w-8 */
      height: 2rem; /* h-8 */
      background-color: var(--primary);
      border-radius: 0.5rem; /* rounded-lg */
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .logo-icon {
      color: var(--primary-foreground);
      font-size: 1rem;
    }

    .logo-text {
      font-size: 1.25rem; /* text-xl */
      font-weight: 700; /* font-bold */
      color: var(--foreground);
    }

    .back-link {
      color: var(--muted-foreground);
      text-decoration: none;
      transition: color 0.15s ease-in-out;
      display: flex;
      align-items: center;
    }

    .back-link:hover {
      color: var(--foreground);
    }

    /* Section styles */
    .section-padding {
      padding-top: 3rem; /* py-12 / 2 */
      padding-bottom: 3rem; /* py-12 / 2 */
    }

    .max-w-2xl {
      max-width: 42rem; /* max-w-2xl */
    }

    .text-center {
      text-align: center;
    }

    .mb-8 {
      margin-bottom: 2rem;
    }

    h1 {
      font-size: 1.875rem; /* text-3xl */
      font-weight: 700;
      color: var(--foreground);
      margin-bottom: 1rem; /* mb-4 */
    }
    @media (min-width: 768px) { /* md:text-4xl */
      h1 {
        font-size: 2.25rem;
      }
    }

    .text-xl {
      font-size: 1.25rem;
    }

    .text-muted-foreground {
      color: var(--muted-foreground);
    }

    /* Card styles */
    .card {
      background-color: var(--card);
      padding: 1.5rem; /* p-6 */
      border-radius: 0.75rem; /* rounded-xl */
      box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05); /* shadow-sm */
      border: 1px solid var(--border);
    }

    .mb-8 {
      margin-bottom: 2rem;
    }

    h2 {
      font-size: 1.25rem; /* text-xl */
      font-weight: 600; /* font-semibold */
      color: var(--card-foreground);
      margin-bottom: 1rem; /* mb-4 */
    }

    .space-y-3 > div {
      margin-top: 0.75rem; /* space-y-3 */
    }
    .space-y-3 > div:first-child {
      margin-top: 0;
    }

    .flex-between {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .font-medium {
      font-weight: 500;
    }

    .summary-total {
      border-top: 1px solid var(--border);
      padding-top: 0.75rem; /* pt-3 */
      margin-top: 0.75rem; /* mt-3 */
    }

    .summary-total > div {
      font-size: 1.125rem; /* text-lg */
      font-weight: 600; /* font-semibold */
    }

    .summary-price {
      color: var(--primary);
    }

    .summary-deposit {
      font-size: 0.875rem; /* text-sm */
      color: var(--muted-foreground);
      margin-top: 0.25rem; /* mt-1 */
    }

    /* Form styles */
    .form-card {
      padding: 2rem; /* p-8 */
    }

    .mb-6 {
      margin-bottom: 1.5rem;
    }

    .grid-2-cols {
      display: grid;
      gap: 1.5rem; /* gap-6 */
    }
    @media (min-width: 768px) { /* md:grid-cols-2 */
      .grid-2-cols {
        grid-template-columns: repeat(2, minmax(0, 1fr));
      }
    }

    label {
      display: block;
      font-size: 0.875rem; /* text-sm */
      font-weight: 500; /* font-medium */
      color: var(--card-foreground);
      margin-bottom: 0.5rem; /* mb-2 */
    }

    input[type="text"],
    input[type="tel"],
    input[type="email"],
    input[type="date"],
    textarea,
    select {
      width: 100%;
      padding: 0.75rem 1rem; /* px-4 py-3 */
      border: 1px solid var(--border);
      border-radius: 0.5rem; /* rounded-lg */
      background-color: var(--input);
      color: var(--foreground);
      transition: box-shadow 0.15s ease-in-out, border-color 0.15s ease-in-out;
      box-sizing: border-box; /* Quan trọng để padding không làm tăng chiều rộng */
      font-family: var(--font-sans); /* Đảm bảo font nhất quán */
    }

    input:focus, textarea:focus, select:focus {
      outline: none;
      border-color: transparent;
      box-shadow: 0 0 0 2px var(--ring); /* focus:ring-2 focus:ring-ring */
    }

    textarea {
      resize: vertical;
    }

    /* Terms and Conditions */
    .terms-checkbox-group {
      display: flex;
      align-items: flex-start;
      margin-bottom: 1.5rem; /* mb-6 */
    }

    .terms-checkbox {
      margin-right: 0.75rem; /* mr-3 */
      height: 1rem; /* h-4 */
      width: 1rem; /* w-4 */
      accent-color: var(--primary); /* Thay thế text-primary */
      border: 1px solid var(--border);
      border-radius: 0.25rem;
      margin-top: 0.125rem; /* mt-1 */
    }

    .terms-text {
      font-size: 0.875rem; /* text-sm */
      color: var(--card-foreground);
    }

    .terms-text a {
      color: var(--primary);
      text-decoration: none;
      transition: text-decoration 0.15s ease-in-out;
    }

    .terms-text a:hover {
      text-decoration: underline;
    }

    /* Button */
    button[type="submit"] {
      width: 100%;
      background-color: var(--primary);
      color: var(--primary-foreground);
      padding-top: 1rem; /* py-4 */
      padding-bottom: 1rem; /* py-4 */
      border-radius: 0.5rem; /* rounded-lg */
      font-weight: 500; /* font-medium */
      font-size: 1.125rem; /* text-lg */
      border: none;
      cursor: pointer;
      transition: background-color 0.15s ease-in-out;
    }

    button[type="submit"]:hover {
      background-color: color-mix(in srgb, var(--primary) 90%, black); /* Mô phỏng hover:bg-primary/90 */
    }
  </style>
</head>
<body>
<header>
  <div class="container">
    <div class="header-content">
      <div class="logo-group">
        <div class="logo-icon-wrapper">
          <i class="fas fa-truck logo-icon"></i>
        </div>
        <span class="logo-text">MoveEasy</span>
      </div>
      <a href="quotation-request.jsp" class="back-link">
        <i class="fas fa-arrow-left" style="margin-right: 0.5rem;"></i>Quay lại Đặt lịch
      </a>
    </div>
  </div>
</header>

<section class="section-padding">
  <div class="container max-w-2xl">
    <div class="text-center mb-8">
      <h1>Thông tin Hợp đồng</h1>
      <p class="text-xl text-muted-foreground">Vui lòng xem lại chi tiết đặt lịch và cung cấp thông tin bổ sung.</p>
    </div>

    <c:if test="${not empty errorMessage}">
      <div style="background-color: #fef2f2; border: 1px solid #fecaca; color: #991b1b; padding: 12px; border-radius: 8px; margin-bottom: 24px;">
        <i class="fas fa-exclamation-triangle" style="margin-right: 8px;"></i>${errorMessage}
      </div>
    </c:if>

    <div class="card mb-8">
      <h2>Tóm tắt Đặt lịch (Mã: ${quotationRequest.quotationID})</h2>
      <div id="booking-summary" class="space-y-3">
        <div class="flex-between"><span class="text-muted-foreground">Địa chỉ Lấy hàng:</span><span class="font-medium">${quotationRequest.pickupAddress}</span></div>
        <div class="flex-between"><span class="text-muted-foreground">Địa chỉ Giao hàng:</span><span class="font-medium">${quotationRequest.dropoffAddress}</span></div>

        <div class="flex-between"><span class="text-muted-foreground">Ngày Chuyển/Giao hàng:</span><span class="font-medium">${quotationRequest.moveDate}</span>
        </div>

        <c:forEach var="item" items="${quotationRequest.itemRequests}" varStatus="loop">
          <div class="flex-between">
            <span class="text-muted-foreground">Món đồ ${loop.index + 1} (${item.furnitureName}):</span>
            <span class="font-medium">${item.quantity} cái</span>
          </div>
        </c:forEach>

        <div class="flex-between">
          <span class="text-muted-foreground">Đồ giá trị cao:</span>
          <span class="font-medium">${quotationRequest.highValueItems ? 'Có' : 'Không'}</span>
        </div>

        <div class="flex-between">
          <span class="text-muted-foreground">Người bốc xếp:</span>
          <span class="font-medium">
        <c:choose>
          <c:when test="${quotationRequest.manpowerOption == 'TWO_MAN'}">2 Người</c:when>
          <c:when test="${quotationRequest.manpowerOption == 'THREE_MAN'}">3 Người</c:when>
          <c:otherwise>Không cần</c:otherwise>
        </c:choose>
    </span>
        </div>

        <div class="summary-total">
          <div class="flex-between"><span>Tổng Chi phí:</span><span class="summary-price">
                        <fmt:formatNumber value="${quotationRequest.totalCost}" type="number" pattern="#,##0"/> VND
                    </span></div>

          <div class="summary-deposit">Yêu cầu đặt cọc 50%:
            <fmt:formatNumber value="${quotationRequest.totalCost * 0.5}" type="number" pattern="#,##0"/> VND
          </div>
        </div>
      </div>
    </div>

    <form id="contract-form" action="${pageContext.request.contextPath}/confirm-contract" method="POST" class="card form-card">
      <h2 class="mb-6">Thông tin Khách hàng</h2>

      <input type="hidden" name="quotationId" value="${quotationRequest.quotationID}">

      <div class="grid-2-cols mb-6">
        <div>
          <label for="customer-name">Tên Khách hàng *</label>
          <input type="text" id="customer-name" name="customerName" required
                 placeholder="Nhập họ tên đầy đủ của bạn" value="${param.customerName}">
        </div>
        <div>
          <label for="customer-phone">Số điện thoại *</label>
          <input type="tel" id="customer-phone" name="customerPhone" required
                 placeholder="Nhập số điện thoại của bạn" value="${param.customerPhone}">
        </div>
      </div>

      <div class="grid-2-cols mb-6">
        <div>
          <label for="receiver-phone">Số điện thoại Người nhận</label>
          <input type="tel" id="receiver-phone" name="receiverPhone"
                 placeholder="Nhập SĐT người nhận (nếu khác)" value="${param.receiverPhone}">
        </div>
      </div>

      <div class="mb-6">
        <label for="special-instructions">Ghi chú </label>
        <textarea id="special-instructions" name="specialInstructions" rows="4"
                  placeholder="Các ghi chú hoặc yêu cầu đặc biệt khác cho đội chuyển nhà">${quotationRequest.specialNotes}</textarea>
      </div>

      <div class="terms-checkbox-group">
        <input type="checkbox" id="terms" name="termsAgreed" required class="terms-checkbox">
        <span class="terms-text">
                  Tôi đồng ý với <a href="#">Điều khoản và Điều kiện</a> và
                  <a href="#">Chính sách Bảo mật</a>. Tôi hiểu rằng cần đặt cọc 50% để xác nhận đặt lịch.
                </span>
      </div>

      <button type="submit">
        Gửi yêu cầu
      </button>
    </form>
  </div>
</section>
</body>
</html>