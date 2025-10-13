<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Chọn Đơn vị Vận chuyển - MoveEasy</title>

  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

  <style>
    /* ========= Design Tokens (Giữ nguyên từ các trang trước) ========= */
    :root {
      --background: oklch(1 0 0);
      --foreground: oklch(0.35 0 0);
      --card: oklch(0.97 0 0);
      --card-foreground: oklch(0.35 0 0);
      --primary: oklch(0.45 0.15 162);
      --primary-foreground: oklch(1 0 0);
      --muted: oklch(0.97 0 0);
      --muted-foreground: oklch(0.35 0 0);
      --border: oklch(0.9 0 0);
      --input: oklch(1 0 0);
      --ring: color-mix(in oklab, var(--primary) 50%, transparent);
      --radius: 12px;
      --shadow: 0 2px 10px rgba(0, 0, 0, .06);
      --container: 900px;
    }

    /* ========= Base & Layout (Giữ nguyên) ========= */
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, "Helvetica Neue", Arial, "Noto Sans", "Apple Color Emoji", "Segoe UI Emoji";
      background: var(--background);
      color: var(--foreground);
      line-height: 1.5;
    }
    a { color: inherit; text-decoration: none; }
    button { font: inherit; }
    .header {
      position: sticky; top: 0; z-index: 50; width: 100%;
      background: color-mix(in oklab, var(--background) 95%, transparent);
      border-bottom: 1px solid var(--border);
    }
    .container { max-width: 600px; margin: 0 auto; padding: 0 16px; }
    .header-inner { display: flex; align-items: center; justify-content: space-between; height: 64px; }
    .brand { display: flex; align-items: center; gap: 8px; font-weight: 700; font-size: 20px; }
    .logo {
      width: 32px; height: 32px; background: var(--primary);
      color: var(--primary-foreground); border-radius: 10px;
      display: flex; align-items: center; justify-content: center;
    }
    .back-link { color: var(--muted-foreground); }
    .back-link:hover { color: var(--foreground); }
    .section { padding: 48px 0; }
    .title-wrap { text-align: center; margin-bottom: 24px; }
    .title { font-weight: 800; font-size: clamp(28px, 2.8vw, 36px); margin: 0 0 8px; }
    .subtitle { font-size: 18px; color: var(--muted-foreground); margin: 0; }
    .card {
      background: var(--card); color: var(--card-foreground);
      border: 1px solid var(--border); border-radius: var(--radius);
      padding: 24px; box-shadow: var(--shadow);
    }

    /* ========= Carrier Selection Specific Styles ========= */
    .carrier-option {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: var(--input); /* Nền trắng */
      border: 2px solid var(--border);
      border-radius: 12px;
      padding: 16px;
      cursor: pointer;
      transition: border-color 0.15s ease, box-shadow 0.15s ease;
      margin-bottom: 12px;
    }

    .carrier-option:hover {
      border-color: var(--primary);
    }

    /* CSS cho radio button ẩn */
    .carrier-radio {
      position: absolute;
      opacity: 0;
      pointer-events: none;
    }

    /* CSS khi radio button được chọn */
    .carrier-radio:checked + .carrier-option {
      border-color: var(--primary);
      box-shadow: 0 0 0 4px var(--ring);
      background: var(--muted);
    }

    .carrier-info {
      display: flex;
      align-items: center;
      gap: 16px;
    }

    .carrier-logo {
      width: 48px;
      height: 48px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--muted);
      border-radius: 8px;
      font-size: 20px;
      color: var(--primary);
    }

    .carrier-details h4 {
      margin: 0;
      font-size: 18px;
      font-weight: 700;
    }

    .carrier-details p {
      margin: 4px 0 0;
      font-size: 14px;
      color: var(--muted-foreground);
    }

    .carrier-price {
      text-align: right;
    }

    .final-price {
      font-size: 24px;
      font-weight: 800;
      color: var(--primary);
    }

    .base-rate {
      font-size: 14px;
      color: var(--muted-foreground);
    }

    .actions {
      margin-top: 24px;
    }

    .btn-primary {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 100%;
      padding: 14px;
      border: 0;
      border-radius: 10px;
      cursor: pointer;
      transition: transform .06s ease, filter .2s ease;
      font-weight: 600;
      background: var(--primary);
      color: var(--primary-foreground);
      font-size: 16px;
    }
    .btn-primary:hover {
      filter: brightness(1.03);
    }
  </style>
</head>

<body>

<header class="header">
  <div class="container">
    <div class="header-inner">
      <div class="brand">
        <div class="logo"><i class="fas fa-truck"></i></div>
        <span>MoveEasy</span>
      </div>
      <a href="booking.jsp" class="back-link"><i class="fas fa-arrow-left" style="margin-right:6px;"></i>Quay lại
        Đặt lịch</a>
    </div>
  </div>
</header>

<section class="section">
  <div class="container">
    <div class="title-wrap">
      <h1 class="title">Chọn Đơn vị Vận chuyển</h1>
      <p class="subtitle">Khối lượng đơn hàng của bạn yêu cầu loại xe **${quotationRequest.vehicleTypeDescription}**. Vui lòng chọn đối tác vận chuyển phù hợp.</p>
    </div>

    <form id="carrier-form" action="confirm-contract" method="post" class="card">

      <input type="hidden" name="quotationId" value="${quotationRequest.id}" />
      <input type="hidden" name="baseRate" value="${quotationRequest.baseRate}" />
      <input type="hidden" name="itemCost" value="${quotationRequest.itemCost}" />
      <input type="hidden" name="surcharge" value="${quotationRequest.surcharge}" />
      <input type="hidden" name="discount" value="${quotationRequest.discount}" />

      <h3 style="margin-bottom: 16px; font-weight: 600;">Các lựa chọn sẵn có</h3>

      <div class="carrier-list">

        <c:forEach var="carrier" items="${availableCarriers}" varStatus="loop">
          <div>
            <input class="carrier-radio" type="radio" id="carrier-${loop.index}"
                   name="selectedCarrierId" value="${carrier.id}" required
                   <c:if test="${loop.index == 0}">checked</c:if>
                   data-total-price="${carrier.totalPrice}"
                   data-carrier-fee="${carrier.carrierFee}">

            <label for="carrier-${loop.index}" class="carrier-option">
              <div class="carrier-info">
                <div class="carrier-logo"><i class="<c:out value="${carrier.iconClass}" />"></i></div>
                <div class="carrier-details">
                  <h4>${carrier.name}</h4>
                  <p>${carrier.estimatedDeliveryTime}</p>
                </div>
              </div>
              <div class="carrier-price">
                <div class="final-price">$${carrier.totalPrice}</div>
                <div class="base-rate">Phí đơn vị: $${carrier.carrierFee}</div>
              </div>
            </label>
          </div>
        </c:forEach>

        <c:if test="${empty availableCarriers}">
          <div class="card" style="text-align: center; color: #ef4444; border-color: #fecaca;">
            Không tìm thấy đơn vị vận chuyển nào phù hợp cho tuyến đường này.
          </div>
        </c:if>

      </div>

      <div class="actions">
        <button type="submit" class="btn-primary">
          Xác nhận & Tiếp tục đến Hợp đồng
        </button>
      </div>
    </form>
  </div>
</section>

</body>

</html>