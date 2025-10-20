<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>

<head>
  <title>My Quotations</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
        rel="stylesheet">
  <style>
    /* 💡 SỬA: Đặt chiều cao 100% cho body và dùng flexbox */
    body,
    html {
      height: 100%;
      margin: 0;
    }

    /* 💡 THÊM: Sử dụng flex-grow để div nội dung chiếm hết không gian */
    .main-content-wrapper {
      display: flex;
      flex-direction: column;
      height: 100vh;
      /* Chiều cao toàn bộ Viewport */
    }

    /* 💡 SỬA: Thiết lập chiều cao cho container chứa bảng để cuộn */
    .fullscreen-table-container {
      /* Tính toán chiều cao:
100vh (toàn màn hình)
- Chiều cao Navbar (giả định 60px)
- Padding (2 lần 16px/p-4)
- Chiều cao Form tìm kiếm (giả định 80px)
-> Sử dụng flexbox để đơn giản hóa việc này */
      flex-grow: 1;
      /* Cho phép nó mở rộng hết mức có thể */
      overflow-y: auto;
      /* Cho phép cuộn */
      padding: 0 1rem;
      /* Giữ padding ngang */
    }

    .table {
      width: 100% !important;
      table-layout: auto;
      margin-bottom: 0;
      /* Loại bỏ margin-bottom mặc định của bảng */
    }

    .table th,
    .table td {
      vertical-align: middle;
      text-align: center;
    }

    .table thead th {
      position: sticky;
      top: 0;
      background-color: #212529;
      color: #fff;
      z-index: 2;
    }
  </style>
</head>

<body>
<div class="main-content-wrapper">

  <div class="container-fluid p-0 d-flex flex-column flex-grow-1">

    <nav
            class="navbar navbar-expand-lg navbar-light bg-light border-bottom ps-4 pe-4 flex-shrink-0">
      <div class="container-fluid">
        <h4 class="mt-2">My Quotations</h4>
      </div>
    </nav>

    <div class="p-4 d-flex flex-column flex-grow-1">

      <form class="row g-3 mb-4 flex-shrink-0" method="get" action="QuotationServlet">
        <input type="hidden" name="action" value="list-user">
        <div class="col-md-5">
          <input type="text" class="form-control" name="search"
                 placeholder="Search by Quotation ID..."
                 value="${param.search != null ? param.search : ''}">
        </div>
        <div class="col-md-4">
          <select class="form-select" name="statusFilter">
            <option value="">-- All Status --</option>
            <option value="pending" <c:if test="${param.statusFilter == 'pending'}">selected
            </c:if>>Pending</option>
            <option value="accepted" <c:if test="${param.statusFilter == 'accepted'}">
              selected</c:if>>Accepted</option>
            <option value="rejected" <c:if test="${param.statusFilter == 'rejected'}">
              selected</c:if>>Rejected</option>
            <option value="completed" <c:if test="${param.statusFilter == 'completed'}">
              selected</c:if>>Completed</option>
          </select>
        </div>
        <div class="col-md-3">
          <button type="submit" class="btn btn-primary w-100">
            <i class="bi bi-search"></i> Search
          </button>
        </div>
      </form>

      <c:if test="${not empty error}">
        <div class="alert alert-danger flex-shrink-0">${error}</div>
      </c:if>
      <c:if test="${not empty successMessage}">
        <div class="alert alert-success flex-shrink-0">${successMessage}</div>
      </c:if>

      <div class="fullscreen-table-container">
        <table class="table table-bordered table-hover table-striped">
          <thead class="table-dark">
          <tr>
            <th>Mã Quotation</th>
            <th>Total Price</th>
            <th>Trạng Thái</th>
            <th>Thao tác</th>
          </tr>
          </thead>

          <tbody>
          <c:forEach var="q" items="${quotationList}">
            <tr>
              <td>${q.quotationID}</td>
              <td>
                <fmt:formatNumber value="${q.totalCost}" pattern="#,##0" /> VND
              </td>
              <td>
                <c:choose>
                  <c:when test="${q.status == 'ACCEPTED'}"><span
                          class="badge bg-success">Đã xác nhận</span></c:when>
                  <c:when test="${q.status == 'REJECTED'}"><span
                          class="badge bg-danger">Từ chối</span></c:when>
                  <c:when test="${q.status == 'PENDING'}"><span
                          class="badge bg-warning text-dark">Chờ xử lý</span>
                  </c:when>
                  <c:otherwise><span class="badge bg-secondary">${q.status}</span>
                  </c:otherwise>
                </c:choose>
              </td>

              <td class="text-center">
                <c:choose>
                  <c:when test="${q.status == 'ACCEPTED'}">
                    <a href="${pageContext.request.contextPath}/contract?quotationId=${q.quotationID}"
                       class="btn btn-sm btn-success">
                      <i class="bi bi-wallet"></i> Thanh toán
                    </a>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/quotation-detail?quotationId=${q.quotationID}"
                       class="btn btn-sm btn-info text-white">
                      <i class="bi bi-eye"></i> Xem Chi tiết
                    </a>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty quotationList}">
            <tr>
              <td colspan="4" class="text-center">Không tìm thấy báo giá nào.</td>
            </tr>
          </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>