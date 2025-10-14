<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- BƯỚC 1: Khai báo thư viện JSTL core với URI đúng cho Tomcat 10+ --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi" dir="ltr">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%-- BƯỚC 2: Hiển thị tiêu đề trang động từ Servlet --%>
    <title>${!empty pageTitle ? pageTitle : 'MoveEasy - Admin Dashboard'}</title>

    <%-- BƯỚC 3: Sửa lại TOÀN BỘ đường dẫn tài nguyên (CSS, JS, ảnh) --%>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png" type="image/x-icon">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/linearicon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vendors/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vendors/themify.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ratio.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/remixicon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vendors/feather-icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vendors/scrollbar.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vendors/animate.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vendors/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/vector-map.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vendors/slick.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <div class="page-wrapper compact-wrapper" id="pageWrapper">
        <div class="page-header">
            <div class="header-wrapper m-0">
                <div class="header-logo-wrapper p-0">
                    <div class="logo-wrapper">
                        <%-- Sửa link trang chủ trỏ về servlet /admin --%>
                        <a href="${pageContext.request.contextPath}/admin">
                            <img class="img-fluid main-logo" src="${pageContext.request.contextPath}/images/logo/1.png" alt="logo">
                        </a>
                    </div>
                    <div class="toggle-sidebar">
                        <i class="status_toggle middle sidebar-toggle" data-feather="align-center"></i>
                        <a href="${pageContext.request.contextPath}/admin">
                            <img src="${pageContext.request.contextPath}/images/logo/1.png" class="img-fluid" alt="">
                        </a>
                    </div>
                </div>

                <div class="nav-right col-6 pull-right right-header p-0">
                    <ul class="nav-menus">
                        <li class="onhover-dropdown">
                            <div class="notification-box">
                                <i class="ri-notification-line"></i>
                                <%-- BƯỚC 4: Hiển thị số lượng thông báo động --%>
                                <span class="badge rounded-pill badge-theme">${!empty notificationCount ? notificationCount : 0}</span>
                            </div>
                            <ul class="notification-dropdown onhover-show-div">
                                <li>
                                    <i class="ri-notification-line"></i>
                                    <h6 class="f-18 mb-0">Thông Báo</h6>
                                </li>
                                <%-- BƯỚC 5: Dùng JSTL để lặp qua danh sách thông báo --%>
                                <c:choose>
                                    <c:when test="${not empty notifications}">
                                        <c:forEach var="notification" items="${notifications}">
                                            <li>
                                                <p><i class="fa fa-circle me-2 font-primary"></i>${notification}<span class="pull-right">10 phút</span></p>
                                            </li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <li><p>Không có thông báo mới.</p></li>
                                    </c:otherwise>
                                </c:choose>
                                <li>
                                    <a class="btn btn-primary" href="javascript:void(0)">Xem tất cả thông báo</a>
                                </li>
                            </ul>
                        </li>

                        <li>
                            <div class="mode">
                                <i class="ri-moon-line"></i>
                            </div>
                        </li>
                        <li class="profile-nav onhover-dropdown pe-0 me-0">
                            <div class="media profile-media">
                                <%-- BƯỚC 6: Hiển thị thông tin người dùng động --%>
                                <img class="user-profile rounded-circle" src="${pageContext.request.contextPath}${!empty user.avatar ? user.avatar :'/images/user/1.jpg'}" alt="User Avatar">
                                <div class="user-name-hide media-body">
                                    <span>${!empty user.name ? user.name : 'Admin User'}</span>
                                    <p class="mb-0 font-roboto">${!empty user.role ? user.role : 'Administrator'}<i class="middle ri-arrow-down-s-line"></i></p>
                                </div>
                            </div>
                            <ul class="profile-dropdown onhover-show-div">
                                <li><a href="#"><i data-feather="users"></i><span>Người Dùng</span></a></li>
                                <li><a href="#"><i data-feather="archive"></i><span>Đơn Hàng</span></a></li>
                                <li><a href="#"><i data-feather="settings"></i><span>Cài Đặt</span></a></li>
                                <li><a data-bs-toggle="modal" data-bs-target="#staticBackdrop" href="javascript:void(0)"><i data-feather="log-out"></i><span>Đăng Xuất</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="page-body-wrapper">
            <div class="sidebar-wrapper">
                <div>
                    <div class="logo-wrapper logo-wrapper-center">
                        <a href="${pageContext.request.contextPath}/admin">
                            <img class="img-fluid for-white" src="${pageContext.request.contextPath}/images/logo/full-white.png" alt="logo">
                        </a>
                    </div>
                    <nav class="sidebar-main">
                         <div id="sidebar-menu">
                            <ul class="sidebar-links" id="simple-bar">
                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="${pageContext.request.contextPath}/admin">
                                        <i class="ri-home-line"></i>
                                        <span>Dashboard</span>
                                    </a>
                                </li>
                                </ul>
                        </div>
                    </nav>
                </div>
            </div>

            <div class="page-body">
                <div class="container-fluid">
                    <div class="row">
                        <%-- BƯỚC 7: Hiển thị dữ liệu dashboard động --%>
                        <div class="col-sm-6 col-xxl-3 col-lg-6">
                            <div class="main-tiles card o-hidden">
                                <div class="custome-1-bg card-body">
                                    <div class="media static-top-widget">
                                        <div class="media-body p-0"><span class="m-0">Tổng Doanh Thu</span>
                                            <h4 class="mb-0 counter">${dashboardData.totalRevenue} VND</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xxl-3 col-lg-6">
                            <div class="main-tiles card o-hidden">
                                <div class="custome-2-bg card-body">
                                    <div class="media static-top-widget">
                                        <div class="media-body p-0"><span class="m-0">Tổng Đơn Hàng</span>
                                            <h4 class="mb-0 counter">${dashboardData.totalOrders}</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xxl-3 col-lg-6">
                            <div class="main-tiles card o-hidden">
                                <div class="custome-3-bg card-body">
                                    <div class="media static-top-widget">
                                        <div class="media-body p-0"><span class="m-0">Đơn Chờ Xử Lý</span>
                                            <h4 class="mb-0 counter">${dashboardData.pendingOrders}</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xxl-3 col-lg-6">
                            <div class="main-tiles card o-hidden">
                                <div class="custome-4-bg card-body">
                                    <div class="media static-top-widget">
                                        <div class="media-body p-0"><span class="m-0">Khách Hàng</span>
                                            <h4 class="mb-0 counter">${dashboardData.activeCustomers}</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-12">
                            <div class="card o-hidden card-hover">
                                <div class="card-header"><h4>Đơn Hàng Gần Đây</h4></div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table border-0">
                                            <thead>
                                                <tr>
                                                    <th>ID Đơn Hàng</th>
                                                    <th>Khách Hàng</th>
                                                    <th>Dịch Vụ</th>
                                                    <th>Ngày Đặt</th>
                                                    <th>Trạng Thái</th>
                                                    <th>Thành Tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <%-- BƯỚC 8: Dùng JSTL để lặp qua danh sách đơn hàng --%>
                                            <c:choose>
                                                <c:when test="${not empty recentOrders}">
                                                    <c:forEach var="order" items="${recentOrders}">
                                                        <tr>
                                                            <td>#${order.id}</td>
                                                            <td>${order.customer}</td>
                                                            <td>${order.service}</td>
                                                            <td>${order.date}</td>
                                                            <td>${order.status}</td>
                                                            <td class="theme-color">${order.amount} VND</td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr><td colspan="6">Không có đơn hàng nào gần đây.</td></tr>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <h5 class="modal-title">Đăng Xuất</h5>
                    <p>Bạn có chắc chắn muốn đăng xuất?</p>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="button-box">
                        <button type="button" class="btn btn--no" data-bs-dismiss="modal">Không</button>
                        <button type="button" class="btn btn--yes btn-primary">Có</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/icons/feather-icon/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/icons/feather-icon/feather-icon.js"></script>
    <script src="${pageContext.request.contextPath}/js/scrollbar/simplebar.js"></script>
    <script src="${pageContext.request.contextPath}/js/scrollbar/custom.js"></script>
    <script src="${pageContext.request.contextPath}/js/config.js"></script>
    <script src="${pageContext.request.contextPath}/js/sidebar-menu.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>

</html>