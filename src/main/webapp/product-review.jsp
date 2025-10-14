<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="vi" dir="ltr">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="MoveEasy Admin - Quản lý đánh giá dịch vụ chuyển nhà">
    <meta name="keywords" content="admin template, MoveEasy admin, dashboard template, đánh giá dịch vụ">
    <meta name="author" content="MoveEasy Team">
    <link rel="icon" href="assets/images/favicon.png" type="image/x-icon">
    <link rel="shortcut icon" href="assets/images/favicon.png" type="image/x-icon">
    <title>MoveEasy - Đánh Giá Dịch Vụ</title>
    
    <!-- Google font-->
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    
    <!-- Fontawesome css -->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/font-awesome.css">
    
    <!-- Linear Icon css -->
    <link rel="stylesheet" href="assets/css/linearicon.css">
    
    <!-- remixicon css -->
    <link rel="stylesheet" type="text/css" href="assets/css/remixicon.css">
    
    <!-- Data Table css -->
    <link rel="stylesheet" type="text/css" href="assets/css/datatables.css">
    
    <!-- Themify icon css -->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/themify.css">
    
    <!-- Feather icon css -->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/feather-icon.css">
    
    <!-- Plugins css -->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/scrollbar.css">
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/animate.css">
    
    <!-- Bootstrap css -->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/bootstrap.css">
    
    <!-- App css -->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
</head>

<body>
    <!-- tap on top start -->
    <div class="tap-top">
        <span class="lnr lnr-chevron-up"></span>
    </div>
    <!-- tap on tap end -->
    
    <!-- page-wrapper Start -->
    <div class="page-wrapper compact-wrapper" id="pageWrapper">
        <!-- Page Header Start -->
        <div class="page-header">
            <div class="header-wrapper m-0">
                <div class="header-logo-wrapper p-0">
                    <div class="logo-wrapper">
                        <a href="adminindex.jsp">
                            <img class="img-fluid main-logo" src="assets/images/logo/1.png" alt="logo">
                            <img class="img-fluid white-logo" src="assets/images/logo/1-white.png" alt="logo">
                        </a>
                    </div>
                    <div class="toggle-sidebar">
                        <i class="status_toggle middle sidebar-toggle" data-feather="align-center"></i>
                        <a href="adminindex.jsp">
                            <img src="assets/images/logo/1.png" class="img-fluid" alt="">
                        </a>
                    </div>
                </div>
                
                <form class="form-inline search-full" action="javascript:void(0)" method="get">
                    <div class="form-group w-100">
                        <div class="Typeahead Typeahead--twitterUsers">
                            <div class="u-posRelative">
                                <input class="demo-input Typeahead-input form-control-plaintext w-100" type="text" 
                                       placeholder="Tìm kiếm đánh giá..." name="q" title="" autofocus>
                                <i class="close-search" data-feather="x"></i>
                                <div class="spinner-border Typeahead-spinner" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </div>
                            <div class="Typeahead-menu"></div>
                        </div>
                    </div>
                </form>
                
                <div class="nav-right col-6 pull-right right-header p-0">
                    <ul class="nav-menus">
                        <li>
                            <span class="header-search">
                                <i class="ri-search-line"></i>
                            </span>
                        </li>
                        <li class="onhover-dropdown">
                            <div class="notification-box">
                                <i class="ri-notification-line"></i>
                                <span class="badge rounded-pill badge-theme">4</span>
                            </div>
                            <ul class="notification-dropdown onhover-show-div">
                                <li>
                                    <i class="ri-notification-line"></i>
                                    <h6 class="f-18 mb-0">Thông Báo</h6>
                                </li>
                                <li>
                                    <p>
                                        <i class="fa fa-circle me-2 font-primary"></i>Đơn hàng mới cần xử lý <span class="pull-right">10 phút</span>
                                    </p>
                                </li>
                                <li>
                                    <p>
                                        <i class="fa fa-circle me-2 font-success"></i>Đơn hàng hoàn thành<span class="pull-right">1 giờ</span>
                                    </p>
                                </li>
                                <li>
                                    <p>
                                        <i class="fa fa-circle me-2 font-info"></i>Báo cáo tháng<span class="pull-right">3 giờ</span>
                                    </p>
                                </li>
                                <li>
                                    <p>
                                        <i class="fa fa-circle me-2 font-danger"></i>Chuyển nhà hoàn thành<span class="pull-right">6 giờ</span>
                                    </p>
                                </li>
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
                                <img class="user-profile rounded-circle" src="assets/images/users/4.jpg" alt="">
                                <div class="user-name-hide media-body">
                                    <span>Nguyễn Văn A</span>
                                    <p class="mb-0 font-roboto">Quản trị viên<i class="middle ri-arrow-down-s-line"></i></p>
                                </div>
                            </div>
                            <ul class="profile-dropdown onhover-show-div">
                                <li>
                                    <a href="all-users.html">
                                        <i data-feather="users"></i>
                                        <span>Người Dùng</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="order-list.html">
                                        <i data-feather="archive"></i>
                                        <span>Đơn Hàng</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="support-ticket.html">
                                        <i data-feather="phone"></i>
                                        <span>Hỗ Trợ</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="profile-setting.html">
                                        <i data-feather="settings"></i>
                                        <span>Cài Đặt</span>
                                    </a>
                                </li>
                                <li>
                                    <a data-bs-toggle="modal" data-bs-target="#staticBackdrop" href="javascript:void(0)">
                                        <i data-feather="log-out"></i>
                                        <span>Đăng Xuất</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Page Header Ends -->
        
        <!-- Page Body Start -->
        <div class="page-body-wrapper">
            <!-- Page Sidebar Start -->
            <div class="sidebar-wrapper">
                <div id="sidebarEffect"></div>
                <div>
                    <div class="logo-wrapper logo-wrapper-center">
                        <a href="adminindex.jsp" data-bs-original-title="" title="">
                            <img class="img-fluid for-white" src="assets/images/logo/full-white.png" alt="logo">
                        </a>
                        <div class="back-btn">
                            <i class="fa fa-angle-left"></i>
                        </div>
                        <div class="toggle-sidebar">
                            <i class="ri-apps-line status_toggle middle sidebar-toggle"></i>
                        </div>
                    </div>
                    <div class="logo-icon-wrapper">
                        <a href="adminindex.jsp">
                            <img class="img-fluid main-logo main-white" src="assets/images/logo/1-white.png" alt="logo">
                            <img class="img-fluid main-logo main-dark" src="assets/images/logo/logo-white.png" alt="logo">
                        </a>
                    </div>
                    <nav class="sidebar-main">
                        <div class="left-arrow" id="left-arrow">
                            <i data-feather="arrow-left"></i>
                        </div>
                        <div id="sidebar-menu">
                            <ul class="sidebar-links" id="simple-bar">
                                <li class="back-btn"></li>
                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="adminindex.jsp">
                                        <i class="ri-home-line"></i>
                                        <span>Dashboard</span>
                                    </a>
                                </li>
                                <li class="sidebar-list">
                                    <a class="linear-icon-link sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-truck-line"></i>
                                        <span>Dịch Vụ</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="services.html">Danh Sách Dịch Vụ</a>
                                        </li>
                                        <li>
                                            <a href="add-new-service.html">Thêm Dịch Vụ Mới</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-user-3-line"></i>
                                        <span>Khách Hàng</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="all-customers.html">Tất Cả Khách Hàng</a>
                                        </li>
                                        <li>
                                            <a href="add-new-customer.html">Thêm Khách Hàng</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-archive-line"></i>
                                        <span>Đơn Hàng</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="order-list.html">Danh Sách Đơn Hàng</a>
                                        </li>
                                        <li>
                                            <a href="order-detail.html">Chi Tiết Đơn Hàng</a>
                                        </li>
                                        <li>
                                            <a href="order-tracking.html">Theo Dõi Đơn Hàng</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="product-review.jsp">
                                        <i class="ri-star-line"></i>
                                        <span>Đánh Giá Dịch Vụ</span>
                                    </a>
                                </li>
                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="support-ticket.html">
                                        <i class="ri-phone-line"></i>
                                        <span>Hỗ Trợ Khách Hàng</span>
                                    </a>
                                </li>
                                <li class="sidebar-list">
                                    <a class="linear-icon-link sidebar-link sidebar-title" href="javascript:void(0)">
                                        <i class="ri-settings-line"></i>
                                        <span>Cài Đặt</span>
                                    </a>
                                    <ul class="sidebar-submenu">
                                        <li>
                                            <a href="profile-setting.html">Cài Đặt Hồ Sơ</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="sidebar-list">
                                    <a class="sidebar-link sidebar-title link-nav" href="reports.html">
                                        <i class="ri-file-chart-line"></i>
                                        <span>Báo Cáo</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="right-arrow" id="right-arrow">
                            <i data-feather="arrow-right"></i>
                        </div>
                    </nav>
                </div>
            </div>
            <!-- Page Sidebar Ends -->
            
            <!-- product review section start -->
            <div class="page-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card card-table">
                                <!-- Table Start -->
                                <div class="card-body">
                                    <div class="title-header option-title">
                                        <h5>Đánh Giá Dịch Vụ</h5>
                                    </div>
                                    <div>
                                        <div class="table-responsive">
                                            <table class="user-table ticket-table review-table theme-table table" id="table_id">
                                                <thead>
                                                    <tr>
                                                        <th>STT</th>
                                                        <th>Tên Khách Hàng</th>
                                                        <th>Dịch Vụ</th>
                                                        <th>Đánh Giá</th>
                                                        <th>Nhận Xét</th>
                                                        <th>Trạng Thái</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>01</td>
                                                        <td>Trần Thị B</td>
                                                        <td>Chuyển Nhà Tiêu Chuẩn</td>
                                                        <td>
                                                            <ul class="rating">
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td>Dịch vụ rất tốt, nhân viên chuyên nghiệp</td>
                                                        <td class="td-check">
                                                            <i class="ri-checkbox-circle-line"></i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>02</td>
                                                        <td>Lê Văn C</td>
                                                        <td>Chuyển Nhà Cao Cấp</td>
                                                        <td>
                                                            <ul class="rating">
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td>Dịch vụ tốt, giá cả hợp lý</td>
                                                        <td class="td-check">
                                                            <i class="ri-checkbox-circle-line"></i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>03</td>
                                                        <td>Phạm Thị D</td>
                                                        <td>Chuyển Nhà Cơ Bản</td>
                                                        <td>
                                                            <ul class="rating">
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td>Dịch vụ ổn, cần cải thiện thêm</td>
                                                        <td class="td-check">
                                                            <i class="ri-checkbox-circle-line"></i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>04</td>
                                                        <td>Nguyễn Văn E</td>
                                                        <td>Đóng Gói Đồ Đạc</td>
                                                        <td>
                                                            <ul class="rating">
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td>Dịch vụ chưa đạt yêu cầu</td>
                                                        <td class="td-cross">
                                                            <i class="ri-close-circle-line"></i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>05</td>
                                                        <td>Hoàng Thị F</td>
                                                        <td>Lưu Kho Tạm Thời</td>
                                                        <td>
                                                            <ul class="rating">
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td>Dịch vụ tuyệt vời, rất hài lòng</td>
                                                        <td class="td-check">
                                                            <i class="ri-checkbox-circle-line"></i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>06</td>
                                                        <td>Võ Văn G</td>
                                                        <td>Lắp Đặt & Sửa Chữa</td>
                                                        <td>
                                                            <ul class="rating">
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td>Dịch vụ tốt, thợ chuyên nghiệp</td>
                                                        <td class="td-cross">
                                                            <i class="ri-close-circle-line"></i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>07</td>
                                                        <td>Đặng Thị H</td>
                                                        <td>Chuyển Nhà Tiêu Chuẩn</td>
                                                        <td>
                                                            <ul class="rating">
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td>Dịch vụ hoàn hảo, sẽ sử dụng lại</td>
                                                        <td class="td-check">
                                                            <i class="ri-checkbox-circle-line"></i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>08</td>
                                                        <td>Bùi Văn I</td>
                                                        <td>Chuyển Nhà Cơ Bản</td>
                                                        <td>
                                                            <ul class="rating">
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star theme-color"></i>
                                                                </li>
                                                                <li>
                                                                    <i class="fas fa-star"></i>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                        <td>Dịch vụ tốt, giá cả phải chăng</td>
                                                        <td class="td-check">
                                                            <i class="ri-checkbox-circle-line"></i>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <!-- Table End -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Container-fluid Ends -->
                
                <div class="container-fluid">
                    <!-- footer start -->
                    <footer class="footer">
                        <div class="row">
                            <div class="col-md-12 footer-copyright text-center">
                                <p class="mb-0">Copyright 2025 © MoveEasy - Dịch vụ chuyển nhà chuyên nghiệp</p>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>
            <!-- product review section End -->
        </div>
        <!-- Page Body end -->
        
        <!-- Modal start -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <h5 class="modal-title" id="staticBackdropLabel">Đăng Xuất</h5>
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
        <!-- Modal end -->
    </div>
    <!-- page-wrapper end -->
    
    <!-- latest js -->
    <script src="assets/js/jquery-3.6.0.min.js"></script>
    
    <!-- Bootstrap js -->
    <script src="assets/js/bootstrap/bootstrap.bundle.min.js"></script>
    
    <!-- feather icon js -->
    <script src="assets/js/icons/feather-icon/feather.min.js"></script>
    <script src="assets/js/icons/feather-icon/feather-icon.js"></script>
    
    <!-- scrollbar simplebar js -->
    <script src="assets/js/scrollbar/simplebar.js"></script>
    <script src="assets/js/scrollbar/custom.js"></script>
    
    <!-- customizer js -->
    <script src="assets/js/customizer.js"></script>
    
    <!-- Sidebar js -->
    <script src="assets/js/config.js"></script>
    
    <!-- Plugins JS -->
    <script src="assets/js/sidebar-menu.js"></script>
    
    <!-- Data table js -->
    <script src="assets/js/datatables/jquery.dataTables.min.js"></script>
    <script src="assets/js/datatables/custom-basic.js"></script>
    
    <!-- sidebar effect -->
    <script src="assets/js/sidebareffect.js"></script>
    
    <!-- Theme js -->
    <script src="assets/js/script.js"></script>
</body>

</html>
