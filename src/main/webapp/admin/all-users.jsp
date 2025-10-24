<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> <%-- Use Jakarta Core Taglib --%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản Lý Người Dùng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            display: flex;
            min-height: 100vh; /* Ensure body takes full height */
            overflow-x: hidden; /* Prevent horizontal scroll on body */
        }
        .sidebar { /* Target the included sidebar */
            position: fixed; /* Keep sidebar fixed on screen */
            top: 0;
            left: 0;
            height: 100vh; /* Make sidebar full viewport height */
            width: 240px; /* Explicit width */
            z-index: 1000;
            overflow-y: auto; /* Add scroll if sidebar content is too long */
        }
        .main-content {
            flex-grow: 1;
            padding: 1.5rem;
            margin-left: 240px; /* Make space for the fixed sidebar */
            min-height: 100vh; /* Ensure content area can also grow */
            overflow-x: auto; /* Scroll content horizontally if needed */
        }
    </style>
</head>
<body>

<%-- ✅ ĐÃ XÓA <div class="d-flex"> THỪA --%>

<%-- Make sure sidebar.jsp is in the correct location (e.g., /webapp/admin/sidebar.jsp) --%>
<%-- VÀ sidebar.jsp PHẢI CÓ class="sidebar" ở thẻ ngoài cùng --%>
<jsp:include page="sidebar.jsp" />

<div class="main-content">
    <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom mb-4">
        <div class="container-fluid">
            <h4 class="mt-2">Quản Lý Người Dùng</h4>
            <a href="${pageContext.request.contextPath}/admin/add-user" class="btn btn-success">
                <i class="bi bi-plus-circle me-1"></i> Thêm Người Dùng Mới
            </a>
        </div>
    </nav>

    <div class="table-responsive table-product">
        <table class="table table-bordered table-hover table-striped align-middle">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Họ Tên</th>
                <th>Email</th>
                <th>Số Điện Thoại</th>
                <th>Vai Trò</th>
                <th>Trạng Thái</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty userList}">
                <tr>
                    <td colspan="8" class="text-center py-4">Không có dữ liệu người dùng.</td>
                </tr>
            </c:if>
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.fullName}</td>
                    <td>${user.email}</td>
                    <td>${user.phone}</td>
                    <td>${user.userType}</td>
                    <td>
                        <c:choose>
                            <c:when test="${user.active}">
                                <span class="badge bg-success">Hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Bị khóa</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/view-user?id=${user.id}" class="btn btn-sm btn-info me-1" title="Xem">
                            <i class="bi bi-eye"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/edit-user?id=${user.id}" class="btn btn-sm btn-warning me-1" title="Sửa">
                            <i class="bi bi-pencil-square"></i>
                        </a>
                        <a href="javascript:void(0);" onclick="showDeleteModal(${user.id}, '${user.fullName}')" class="btn btn-sm btn-danger" title="Xóa">
                            <i class="bi bi-trash"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div> <%-- End responsive wrapper --%>

</div> <%-- End main-content --%>

<%-- ✅ ĐÃ XÓA </div> THỪA --%>

<div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
    <%-- ... (Nội dung modal giữ nguyên) ... --%>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteUserModalLabel">Xác Nhận Xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Hành động này sẽ xóa người dùng <strong id="userNameToDelete"></strong>. Bạn không thể hoàn tác!
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form action="${pageContext.request.contextPath}/admin/delete-user" method="post" class="d-inline">
                    <input type="hidden" name="userId" id="userIdToDelete">
                    <button type="submit" class="btn btn-danger">Xác Nhận Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function showDeleteModal(userId, userName) {
        document.getElementById('userIdToDelete').value = userId;
        const nameElement = document.getElementById('userNameToDelete');
        nameElement.textContent = userName;
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteUserModal'));
        deleteModal.show();
    }
</script>

</body>
</html>