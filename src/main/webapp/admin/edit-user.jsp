<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi" dir="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - Chỉnh Sửa Người Dùng</title>

    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/vendors/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/remixicon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>
<div class="page-wrapper compact-wrapper" id="pageWrapper">



    <div class="page-body-wrapper">



        <div class="page-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="title-header option-title">
                                            <h5>Chỉnh Sửa Thông Tin Người Dùng</h5>
                                        </div>

                                        <c:if test="${not empty userDetail}">
                                            <form class="theme-form theme-form-2 mega-form" action="${pageContext.request.contextPath}/admin/update-user" method="post">

                                                    <%-- Input ẩn để gửi ID của user đi --%>
                                                <input type="hidden" name="id" value="${userDetail.id}">

                                                <div class="mb-4 row align-items-center">
                                                    <label class="form-label-title col-sm-2 mb-0">Họ và Tên</label>
                                                    <div class="col-sm-10">
                                                        <input class="form-control" type="text" name="fullName" value="${userDetail.fullName}" required>
                                                    </div>
                                                </div>

                                                <div class="mb-4 row align-items-center">
                                                    <label class="form-label-title col-sm-2 mb-0">Email</label>
                                                    <div class="col-sm-10">
                                                        <input class="form-control" type="email" name="email" value="${userDetail.email}" required>
                                                    </div>
                                                </div>

                                                <div class="mb-4 row align-items-center">
                                                    <label class="form-label-title col-sm-2 mb-0">Số Điện Thoại</label>
                                                    <div class="col-sm-10">
                                                        <input class="form-control" type="tel" name="phone" value="${userDetail.phone}" required>
                                                    </div>
                                                </div>

                                                <div class="mb-4 row align-items-center">
                                                    <label class="form-label-title col-sm-2 mb-0">Vai Trò</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-select" name="userType">
                                                            <option value="USER" ${userDetail.userType == 'USER' ? 'selected' : ''}>User</option>
                                                            <option value="STAFF" ${userDetail.userType == 'STAFF' ? 'selected' : ''}>Staff</option>
                                                            <option value="ADMIN" ${userDetail.userType == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="mb-4 row align-items-center">
                                                    <label class="form-label-title col-sm-2 mb-0">Trạng Thái</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-select" name="isActive">
                                                            <option value="true" ${userDetail.active ? 'selected' : ''}>Hoạt động</option>
                                                            <option value="false" ${!userDetail.active ? 'selected' : ''}>Bị khóa</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-10 offset-sm-2">
                                                        <div class="d-flex gap-2">
                                                            <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                                                            <a href="${pageContext.request.contextPath}/admin/all-users" class="btn btn-light">Hủy</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </c:if>
                                        <c:if test="${empty userDetail}">
                                            <div class="alert alert-danger text-center">Không tìm thấy người dùng để chỉnh sửa.</div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid">
                <footer class="footer"><p class="mb-0 text-center">Copyright 2025 © MoveEasy</p></footer>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/sidebar-menu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>