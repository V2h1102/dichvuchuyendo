<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi" dir="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - Chi Tiết Người Dùng</title>

    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/vendors/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/vendors/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/vendors/feather-icon.css">
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
                                            <h5>Chi Tiết Người Dùng</h5>
                                            <a href="${pageContext.request.contextPath}/admin/all-users" class="btn btn-primary">Quay Lại Danh Sách</a>
                                        </div>

                                        <%-- Kiểm tra xem userDetail có tồn tại không --%>
                                        <c:if test="${not empty userDetail}">
                                            <div class="row">
                                                <div class="col-md-4 text-center">
                                                    <img class="img-fluid rounded-circle" src="${pageContext.request.contextPath}/assets/images/users/1.jpg" alt="User Avatar">
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="table-responsive">
                                                        <table class="table table-bordered">
                                                            <tbody>
                                                            <tr>
                                                                <th scope="row" style="width: 30%;">ID Người Dùng</th>
                                                                <td>${userDetail.id}</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">Họ và Tên</th>
                                                                <td>${userDetail.fullName}</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">Email</th>
                                                                <td>${userDetail.email}</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">Số Điện Thoại</th>
                                                                <td>${userDetail.phone}</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">Vai Trò</th>
                                                                <td>${userDetail.userType}</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">Trạng Thái</th>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${userDetail.active}">
                                                                            <span class="badge badge-light-success">Hoạt động</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="badge badge-light-danger">Bị khóa</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
<%--                                                    <div class="mt-4">--%>
<%--                                                        <a href="${pageContext.request.contextPath}/admin/edit-user?id=${userDetail.id}" class="btn btn-secondary">Chỉnh Sửa</a>--%>
<%--                                                    </div>--%>
                                                </div>
                                            </div>
                                        </c:if>

                                        <c:if test="${empty userDetail}">
                                            <div class="alert alert-danger text-center" role="alert">
                                                Không tìm thấy thông tin người dùng!
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid">
                <footer class="footer">
                    <p class="mb-0 text-center">Copyright 2025 © MoveEasy</p>
                </footer>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/icons/feather-icon/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/icons/feather-icon/feather-icon.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/sidebar-menu.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>