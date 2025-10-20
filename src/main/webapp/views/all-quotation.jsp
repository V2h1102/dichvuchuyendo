<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>Manage Quotations</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="d-flex">

<%--  <jsp:include page="side-bar.jsp"/>--%>

  <div class="container-fluid p-0">
    <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom ps-4 pe-4">
      <div class="container-fluid">
        <h4 class="mt-2">Manage Quotations</h4>
      </div>
    </nav>

    <div class="p-4">

      <form class="row g-3 mb-4" method="get" action="QuotationController">
        <input type="hidden" name="action" value="list">

        <div class="col-md-5">
          <input type="text" class="form-control" name="search"
                 placeholder="Search by Customer Name or Quotation ID..."
                 value="${param.search != null ? param.search : ''}">
        </div>

        <div class="col-md-4">
          <select class="form-select" name="statusFilter">
            <option value="">-- All Status --</option>
            <option value="pending" <c:if test="${param.statusFilter == 'pending'}">selected</c:if>>Pending</option>
            <option value="accepted" <c:if test="${param.statusFilter == 'accepted'}">selected</c:if>>Accepted</option>
            <option value="rejected" <c:if test="${param.statusFilter == 'rejected'}">selected</c:if>>Rejected</option>
            <option value="completed" <c:if test="${param.statusFilter == 'completed'}">selected</c:if>>Completed</option>
          </select>
        </div>

        <div class="col-md-3">
          <button type="submit" class="btn btn-primary w-100">
            <i class="bi bi-search"></i> Search
          </button>
        </div>
      </form>

      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>
      <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
      </c:if>

      <table class="table table-bordered table-hover table-striped">
        <thead class="table-dark">
        <tr>
          <th>Mã Quotation</th>
          <th>Tên Khách Hàng</th>
          <th>Total Price Gốc</th>
          <th>Total Price (Admin)</th>
          <th>Trạng Thái</th>
          <th>Thao Tác</th>
          <th>Actions</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="q" items="${quotationList}">
          <tr>
            <td>${q.quotationID}</td>
            <td>${q.customerName}</td>

              <%-- Định dạng tiền tệ gốc do khách hàng gửi --%>
            <td>
              <fmt:formatNumber value="${q.originalTotalPrice}" type="currency" currencySymbol="VND"/>
            </td>

              <%-- Định dạng tiền tệ đã được admin chỉnh sửa --%>
            <td class="fw-bold text-success">
              <fmt:formatNumber value="${q.adminTotalPrice}" type="currency" currencySymbol="VND"/>
            </td>

            <td>
              <c:choose>
                <c:when test="${q.status == 'accepted'}"><span class="badge bg-success">Chấp Nhận</span></c:when>
                <c:when test="${q.status == 'rejected'}"><span class="badge bg-danger">Từ Chối</span></c:when>
                <c:when test="${q.status == 'pending'}"><span class="badge bg-warning text-dark">Chờ Xử Lý</span></c:when>
                <c:otherwise><span class="badge bg-secondary">${q.status}</span></c:otherwise>
              </c:choose>
            </td>

              <%-- Cột Thao Tác 1: Xem chi tiết và Update Price --%>
            <td>
              <a href="QuotationController?action=view-detail&id=${q.quotationID}" class="btn btn-sm btn-info text-white me-1">
                <i class="bi bi-eye"></i> Xem Chi Tiết
              </a>

              <button type="button" class="btn btn-sm btn-warning" data-bs-toggle="modal"
                      data-bs-target="#updatePriceModal" data-quotation-id="${q.quotationID}"
                      data-current-price="${q.adminTotalPrice}">
                <i class="bi bi-currency-dollar"></i> Update Total
              </button>
            </td>

              <%-- Cột Thao Tác 2: Chấp nhận/Từ chối --%>
            <td>
              <c:if test="${q.status == 'pending'}">
                <a href="QuotationController?action=accept&id=${q.quotationID}"
                   class="btn btn-sm btn-success me-1"
                   onclick="return confirm('Xác nhận CHẤP NHẬN báo giá này?');">
                  <i class="bi bi-check-circle"></i> Chấp Nhận
                </a>

                <a href="QuotationController?action=reject&id=${q.quotationID}"
                   class="btn btn-sm btn-danger"
                   onclick="return confirm('Xác nhận TỪ CHỐI báo giá này?');">
                  <i class="bi bi-x-circle"></i> Từ Chối
                </a>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty quotationList}">
          <tr>
            <td colspan="7" class="text-center">Không tìm thấy báo giá nào.</td>
          </tr>
        </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div class="modal fade" id="updatePriceModal" tabindex="-1" aria-labelledby="updatePriceModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-warning text-dark">
        <h5 class="modal-title" id="updatePriceModalLabel">Cập nhật Tổng giá</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="QuotationController" method="post">
        <input type="hidden" name="action" value="update-price">
        <input type="hidden" name="quotationId" id="modalQuotationId">
        <div class="modal-body">
          <div class="mb-3">
            <label for="newPrice" class="form-label">Tổng giá mới (VND)</label>
            <input type="number" step="1000" min="0" class="form-control" id="newPrice" name="newPrice" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
          <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
  var updatePriceModal = document.getElementById('updatePriceModal');
  updatePriceModal.addEventListener('show.bs.modal', function (event) {
    var button = event.relatedTarget;
    var quotationId = button.getAttribute('data-quotation-id');
    var currentPrice = button.getAttribute('data-current-price');

    var modalQuotationId = updatePriceModal.querySelector('#modalQuotationId');
    var newPriceInput = updatePriceModal.querySelector('#newPrice');

    modalQuotationId.value = quotationId;
    newPriceInput.value = currentPrice; // Đặt giá trị hiện tại vào ô input
  });
</script>

</body>
</html>