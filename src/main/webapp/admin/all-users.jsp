<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi" dir="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - Quản Lý Người Dùng</title>

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
                    <div class="col-sm-12">
                        <div class="card card-table">
                            <div class="card-body">
                                <div class="title-header option-title">
                                    <h5>Tất Cả Người Dùng</h5>
                                    <a href="#" class="btn btn-theme">Thêm Người Dùng Mới</a>
                                </div>
                                <div class="table-responsive table-product">
                                    <table class="table all-package theme-table" id="table_id">
                                        <thead>
                                        <tr>
                                            <th>Người Dùng</th>
                                            <th>Họ Tên</th>
                                            <th>Số Điện Thoại</th>
                                            <th>Email</th>
                                            <th>Hành Động</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%-- KIỂM TRA NẾU DANH SÁCH RỖNG --%>
                                        <c:if test="${empty userList}">
                                            <tr>
                                                <td colspan="7" class="text-center py-5">Không có dữ liệu người dùng.</td>
                                            </tr>
                                        </c:if>

                                        <%-- Vòng lặp JSTL để duyệt qua danh sách người dùng --%>
                                        <c:forEach var="user" items="${userList}">
                                            <tr>
                                                <td>
                                                    <div class="table-image">
                                                        <img src="${pageContext.request.contextPath}/assets/images/users/1.jpg" class="img-fluid" alt="">
                                                    </div>
                                                </td>
                                                <td>${user.fullName}</td>
                                                <td>${user.phone}</td>
                                                <td>${user.email}</td>
<%--                                                <td>${user.userType}</td>--%>
<%--                                                <td>--%>
<%--                                                    <c:choose>--%>
<%--                                                        <c:when test="${user.active}">--%>
<%--                                                            <span class="badge badge-light-success">Hoạt động</span>--%>
<%--                                                        </c:when>--%>
<%--                                                        <c:otherwise>--%>
<%--                                                            <span class="badge badge-light-danger">Bị khóa</span>--%>
<%--                                                        </c:otherwise>--%>
<%--                                                    </c:choose>--%>
<%--                                                </td>--%>
                                                <td>
                                                    <ul>
                                                        <li><a href="#"><i class="ri-eye-line"></i></a></li>
                                                        <li><a href="#"><i class="ri-pencil-line"></i></a></li>
                                                        <li><a href="#"><i class="ri-delete-bin-line"></i></a></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
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