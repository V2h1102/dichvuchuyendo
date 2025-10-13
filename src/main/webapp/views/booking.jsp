<!DOCTYPE html>
<html lang="vi">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>

    <meta charset="UTF-8" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt Dịch Vụ Chuyển Đồ - MoveEasy</title>


    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />

    <style>
        /* ========= Design Tokens ========= */
        :root {
            --background: oklch(1 0 0);
            --foreground: oklch(0.35 0 0);
            --card: oklch(0.97 0 0);
            --card-foreground: oklch(0.35 0 0);
            --primary: oklch(0.45 0.15 162);
            --primary-foreground: oklch(1 0 0);
            --secondary: oklch(0.55 0.15 162);
            --secondary-foreground: oklch(1 0 0);
            --muted: oklch(0.97 0 0);
            --muted-foreground: oklch(0.35 0 0);
            --accent: oklch(0.55 0.15 162);
            --accent-foreground: oklch(1 0 0);
            --border: oklch(0.9 0 0);
            --input: oklch(1 0 0);
            --ring: color-mix(in oklab, var(--primary) 50%, transparent);
            --radius: 12px;
            --shadow: 0 2px 10px rgba(0, 0, 0, .06);
            --shadow-lg: 0 10px 30px rgba(0, 0, 0, .08);
            --container: 900px;
        }

        /* ========= Resets & Base ========= */
        * {
            box-sizing: border-box;
        }

        html,
        body {
            height: 100%;
        }

        body {
            margin: 0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, "Helvetica Neue", Arial, "Noto Sans", "Apple Color Emoji", "Segoe UI Emoji";
            background: var(--background);
            color: var(--foreground);
            line-height: 1.5;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        img,
        svg {
            display: block;
            max-width: 100%;
        }

        button {
            font: inherit;
        }

        /* ========= Layout ========= */
        .header {
            position: sticky;
            top: 0;
            z-index: 50;
            width: 100%;
            backdrop-filter: blur(6px);
            background: color-mix(in oklab, var(--background) 95%, transparent);
            border-bottom: 1px solid var(--border);
        }

        .container {
            max-width: var(--container);
            margin: 0 auto;
            padding: 0 16px;
        }

        .header-inner {
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 700;
            font-size: 20px;
        }

        .logo {
            width: 32px;
            height: 32px;
            background: var(--primary);
            color: var(--primary-foreground);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .back-link {
            color: var(--muted-foreground);
        }

        .back-link:hover {
            color: var(--foreground);
        }

        .section {
            padding: 48px 0;
        }

        .title-wrap {
            text-align: center;
            margin-bottom: 24px;
        }

        .title {
            font-weight: 800;
            font-size: clamp(28px, 2.8vw, 36px);
            margin: 0 0 8px;
        }

        .subtitle {
            font-size: 18px;
            color: var(--muted-foreground);
            margin: 0;
        }

        /* ========= Card / Form (Chỉnh sửa để liền mạch hơn) ========= */
        .card {
            background: var(--card);
            color: var(--card-foreground);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 24px;
            box-shadow: var(--shadow);
        }

        /* Tiêu đề nhóm form mới */
        .form-heading {
            font-size: 18px;
            font-weight: 600;
            color: var(--card-foreground);
            margin: 0 0 16px;
            padding-bottom: 8px;
            border-bottom: 1px solid var(--border);
        }

        .grid {
            display: grid;
            gap: 16px;
        }

        @media (min-width: 768px) {
            .grid-2 {
                grid-template-columns: 1fr 1fr;
            }
        }

        .label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .input,
        .select,
        .checkbox,
        .textarea {
            width: 100%;
            background: var(--input);
            color: var(--foreground);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 12px 14px;
            outline: none;
            transition: box-shadow .15s ease, border-color .15s ease;
            font-family: inherit; /* Thêm để textarea dùng font body */
        }

        /* CSS cho textarea */
        .textarea {
            min-height: 100px;
            resize: vertical;
        }

        .input:focus,
        .select:focus,
        .textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px var(--ring);
        }

        .checkbox {
            width: auto;
            padding: 0;
            height: 18px;
            width: 18px;
            vertical-align: middle;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 16px;
            border: 0;
            border-radius: 10px;
            cursor: pointer;
            transition: transform .06s ease, filter .2s ease;
            font-weight: 600;
        }

        .btn:active {
            transform: translateY(1px);
        }

        .btn-primary {
            background: var(--primary);
            color: var(--primary-foreground);
        }

        .btn-primary:hover {
            filter: brightness(1.03);
        }

        .btn-ghost {
            background: transparent;
            color: var(--primary);
        }

        .btn-ghost:hover {
            filter: brightness(0.95);
        }

        .items-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        .items-stack {
            display: grid;
            gap: 12px;
        }

        .item-row {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 12px;
            box-shadow: var(--shadow);
        }

        .item-row-inner {
            display: grid;
            grid-template-columns: 1fr 110px auto;
            gap: 12px;
            align-items: end;
        }

        .qty-input {
            text-align: center;
        }

        .muted-box {
            background: color-mix(in oklab, var(--muted) 50%, transparent);
            border-radius: 12px;
            padding: 16px;
            border: 1px solid var(--border);
        }

        .price-line {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .total {
            font-size: 24px;
            font-weight: 800;
            color: var(--primary);
        }

        .muted {
            color: var(--muted-foreground);
            font-size: 14px;
        }

        .alert {
            border-radius: 10px;
            padding: 12px 14px;
            border: 1px solid;
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .alert-error {
            background: #fef2f2;
            border-color: #fecaca;
            color: #991b1b;
        }

        .alert-success {
            background: #f0fdf4;
            border-color: #bbf7d0;
            color: #166534;
        }

        .actions {
            margin-top: 18px;
        }

        .submit {
            width: 100%;
            padding: 14px;
            font-size: 16px;
        }

        .label-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
        }

        .label-group span {
            flex: 1;
        }

        .label-group select {
            width: 50%;
            max-width: 200px;
        }

        .sr-only {
            position: absolute;
            width: 1px;
            height: 1px;
            margin: -1px;
            border: 0;
            padding: 0;
            white-space: nowrap;
            clip-path: inset(50%);
            clip: rect(0 0 0 0);
            overflow: hidden;
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
            <a href="/index.jsp" class="back-link"><i class="fas fa-arrow-left" style="margin-right:6px;"></i>Quay lại
                Trang Chủ</a>
        </div>
    </div>
</header>

<section class="section">
    <div class="container" style="max-width: 600px;">
        <div class="title-wrap">
            <h1 class="title">Đặt Dịch Vụ Chuyển Nhà</h1>
            <p class="subtitle">Vui lòng điền chi tiết bên dưới để bắt đầu báo giá dịch vụ chuyển đồ.</p>
        </div>

        <form id="booking-form" action="/booking" method="post" class="card">
            <h3 class="form-heading">Thông tin Vận chuyển</h3>
            <div class="grid grid-2" style="margin-bottom: 16px;">
                <div>
                    <label class="label" for="pickup-address">Địa chỉ Lấy hàng *</label>
                    <input class="input" type="text" id="pickup-address" name="pickupAddress" required
                           placeholder="Nhập địa chỉ lấy hàng" />
                </div>
                <div>
                    <label class="label" for="dropoff-address">Địa chỉ Giao hàng *</label>
                    <input class="input" type="text" id="dropoff-address" name="dropoffAddress" required
                           placeholder="Nhập địa chỉ giao hàng" />
                </div>
            </div>

            <div class="grid grid-2" style="margin-bottom: 24px;">
                <div>
                    <label class="label" for="move-date">Ngày Chuyển *</label>
                    <input class="input" type="date" id="move-date" name="moveDate" required />
                </div>
            </div>

            <h3 class="form-heading" style="margin-top: 24px;">Đồ đạc cần Chuyển</h3>
            <div style="margin-bottom: 24px;">
                <div class="items-header">
                    <h4 style="margin:0; font-size:16px; font-weight:700;">Danh sách Đồ đạc</h4>

                    <button class="btn btn-primary" type="button" id="add-item-btn">
                        <i class="fas fa-plus"></i><span>Thêm Đồ mới</span>
                    </button>
                </div>

                <div class="items-stack" id="items-list">

                    <c:if test="${not empty booking.itemRequests}">
                        <c:forEach var="it" items="${booking.itemRequests}" varStatus="st">
                            <div class="item-row">
                                <div class="item-row-inner">
                                    <div>
                                        <label class="label">Chọn Đồ đạc</label>
                                        <select class="select" name="itemRequests[${st.index}].itemId">
                                            <option value="">Chọn một món đồ...</option>

                                            <c:forEach var="entry" items="${furnitureGroups}">
                                                <optgroup label="<c:out value='${entry.key}'/>">
                                                    <c:forEach var="ft" items="${entry.value}">
                                                        <option value="<c:out value='${ft.furnitureTypeID}'/>"
                                                                <c:if test="${ft.furnitureTypeID == it.itemId}">selected</c:if>>
                                                            <c:out value="${ft.name}"/>
                                                        </option>
                                                    </c:forEach>
                                                </optgroup>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div>
                                        <label class="label">Số lượng</label>
                                        <input class="input qty-input" type="number" min="1"
                                               name="itemRequests[${st.index}].quantity"
                                               value="<c:out value='${it.quantity}'/>"/>
                                    </div>
                                    <div style="align-self:center;">
                                        <button class="btn btn-ghost remove-item-btn" type="button" title="Xóa món đồ này">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <c:if test="${empty booking.itemRequests}">
                        <div class="item-row">
                            <div class="item-row-inner">
                                <div>
                                    <label class="label">Chọn Đồ đạc</label>
                                    <select class="select" name="itemRequests[0].itemId">
                                        <option value="">Chọn một món đồ...</option>

                                        <c:forEach var="entry" items="${furnitureGroups}">
                                            <optgroup label="<c:out value='${entry.key}'/>">
                                                <c:forEach var="ft" items="${entry.value}">
                                                    <option value="<c:out value='${ft.furnitureTypeID}'/>">
                                                        <c:out value="${ft.name}"/>
                                                    </option>
                                                </c:forEach>
                                            </optgroup>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div>
                                    <label class="label">Số lượng</label>
                                    <input class="input qty-input" type="number" min="1" name="itemRequests[0].quantity" value="1"/>
                                </div>
                                <div style="align-self:center;">
                                    <button class="btn btn-ghost remove-item-btn" type="button" title="Xóa món đồ này">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <div class="item-row" id="item-row-template" style="display: none;">
                        <div class="item-row-inner">
                            <div>
                                <label class="label">Chọn Đồ đạc</label>
                                <select class="select" name="itemIds_template">
                                    <option value="">Chọn một món đồ...</option>

                                    <c:forEach var="entry" items="${furnitureGroups}">
                                        <optgroup label="<c:out value='${entry.key}'/>">
                                            <c:forEach var="ft" items="${entry.value}">
                                                <option value="<c:out value='${ft.furnitureTypeID}'/>">
                                                    <c:out value="${ft.name}"/>
                                                </option>
                                            </c:forEach>
                                        </optgroup>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="label">Số lượng</label>
                                <input class="input qty-input" type="number" min="1" name="quantities_template"
                                       value="1" />
                            </div>
                            <div style="align-self:center;">
                                <button class="btn btn-ghost remove-item-btn" type="button"
                                        title="Xóa món đồ này">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>


                    <div id="empty-list-message" class="muted"
                         style="text-align:center; padding:28px; display: none;">
                        <i class="fas fa-box-open" style="font-size:36px; opacity:.5; margin-bottom:8px;"></i>
                        <p style="margin:0;">Chưa có đồ nào được thêm. Nhấn “Thêm Đồ mới” để bắt đầu.</p>
                    </div>

                </div>
            </div>

            <h3 class="form-heading" style="margin-top: 24px;">Dịch vụ Bổ sung</h3>

            <div style="margin-bottom: 16px;">
                <label class="label" for="voucher">Mã Giảm Giá (Tùy chọn)</label>
                <input class="input" type="text" id="voucher" name="voucherCode"
                       placeholder="Nhập mã giảm giá (nếu có)" />
            </div>

            <div style="margin-bottom: 24px;">
                <label class="label" for="special-notes">Ghi Chú & Yêu Cầu Đặc Biệt (Tùy chọn)</label>
                <textarea class="textarea" id="special-notes" name="specialNotes"
                          placeholder="Ví dụ: Cần tháo lắp Tivi, có thang máy ở cả hai đầu, cần chuyển lúc 6h sáng,..."></textarea>
            </div>
            <div style="margin-bottom: 24px;">
                <h4 style="margin:0 0 8px; font-size:16px; font-weight:700;">Tùy chọn Đặc biệt</h4>

                <label class="label-group">
                    <input class="checkbox" type="checkbox" id="high-value" name="highValueItems" />
                    <span>
                            Đồ đạc giá trị cao (dễ vỡ/đắt tiền) - +đ100k
                        </span>
                </label>

                <div class="label-group" style="margin-top: 8px;">
                    <label for="manpower-service" class="sr-only">Dịch vụ Bốc xếp</label>
                    <span>Thêm Người Bốc xếp (Hỗ trợ tại cả hai đầu)</span>
                    <select class="select" id="manpower-service" name="manpowerOption"
                            style="width:auto; max-width:200px; padding: 12px 6px;">
                        <option value="NONE">Không cần</option>
                        <option value="TWO_MAN">2 Người (+₫3000000)</option>
                        <option value="THREE_MAN">3 Người (+₫4000000)</option>
                    </select>
                </div>
            </div>

            <h3 class="form-heading" style="margin-top: 24px;">Tổng Hợp Báo Giá</h3>
            <div class="muted-box" style="margin-bottom: 24px;">
                <div class="price-line">
                    <span style="font-size: 16px; font-weight:700;">Tổng Cộng:</span>
                    <span class="total">
                            $50.00
                        </span>
                </div>
                <div class="muted" style="margin-top:8px;">
                    <div>Phí cơ bản: $50</div>
                </div>
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-primary submit">
                    Tiếp tục đến Chi tiết Hợp đồng
                </button>
            </div>
        </form>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const itemsList = document.getElementById('items-list');
        const addItemBtn = document.getElementById('add-item-btn');
        const itemTemplate = document.getElementById('item-row-template');
        let itemIndex = itemsList.querySelectorAll('.item-row').length;

        // Hàm cập nhật tên thuộc tính cho việc submit form
        function updateItemNames(itemRow, index) {
            // Đổi name của select và input số lượng để backend nhận diện là một list/array
            const select = itemRow.querySelector('select[name$="_template"]');
            const input = itemRow.querySelector('input[name$="_template"]');

            if (select) {
                select.name = `itemRequests[${index}].itemId`; // hoặc chỉ là itemIds
            }
            if (input) {
                input.name = `itemRequests[${index}].quantity`; // hoặc chỉ là quantities
            }
            // Có thể thêm hidden input cho trạng thái xóa nếu cần
            // Ví dụ: <input type="hidden" name="itemRequests[${index}].status" value="NEW"/>
        }

        // Xóa món đồ
        function removeItem(button) {
            const itemRow = button.closest('.item-row');
            itemRow.remove();
            // Tùy chọn: cần sắp xếp lại index cho tất cả các item còn lại nếu sử dụng index trong tên thuộc tính (itemRequests[${index}])
        }

        // Thêm món đồ
        addItemBtn.addEventListener('click', () => {
            const newItem = itemTemplate.cloneNode(true);
            newItem.id = ''; // Xóa id template
            newItem.style.display = 'block';

            // Lấy index mới (chỉ sử dụng nếu bạn cần index liên tục)
            const currentIndex = itemIndex++;
            updateItemNames(newItem, currentIndex);

            // Gán sự kiện cho nút xóa mới
            const removeButton = newItem.querySelector('.remove-item-btn');
            removeButton.addEventListener('click', (e) => {
                removeItem(e.target);
            });

            itemsList.appendChild(newItem);
        });

        // Gán sự kiện xóa cho các món đồ đã có sẵn (nếu có)
        itemsList.querySelectorAll('.remove-item-btn').forEach(button => {
            button.addEventListener('click', (e) => {
                removeItem(e.target);
            });
        });

    });
</script>
</body>

</html>