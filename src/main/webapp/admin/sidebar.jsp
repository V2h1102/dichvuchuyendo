<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="sidebar d-flex flex-column flex-shrink-0 p-3 bg-success text-white vh-100" style="width: 240px;">
    <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <span class="fs-4 fw-bold">Furniture Moving</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="DashboardController" class="nav-link text-white ${pageName == 'dashboard' ? 'active bg-secondary' : ''}">
                <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="ItemController" class="nav-link text-white ${pageName == 'items' ? 'active bg-secondary' : ''}">
                <i class="bi bi-box-seam me-2"></i> Items
            </a>
        </li>
        <li>
            <a href="CategoryController" class="nav-link text-white ${pageName == 'categories' ? 'active bg-secondary' : ''}">
                <i class="bi bi-tags me-2"></i> Categories
            </a>
        </li>
        <li>
            <a href="BookingController" class="nav-link text-white ${pageName == 'bookings' ? 'active bg-secondary' : ''}">
                <i class="bi bi-truck me-2"></i> Bookings
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/all-users" class="nav-link text-white ${pageName == 'users' ? 'active bg-secondary' : ''}">
                <i class="bi bi-people me-2"></i> All Users
            </a>
        </li>
    </ul>

    <hr>
    <div class="dropdown">
        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
           data-bs-toggle="dropdown" aria-expanded="false">
            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="" width="32" height="32" class="rounded-circle me-2">
            <strong>
                <c:choose>
                    <c:when test="${not empty sessionScope.user and not empty sessionScope.user.fullName}">
                        ${sessionScope.user.fullName} <%-- Sử dụng fullName --%>
                    </c:when>
                    <c:otherwise>
                        Admin <%-- Giá trị mặc định nếu không đăng nhập hoặc không có tên --%>
                    </c:otherwise>
                </c:choose>
            </strong>
        </a>
        <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
            <li><a class="dropdown-item" href="#">Hồ sơ</a></li>
            <li><a class="dropdown-item" href="#">Cài đặt</a></li>
            <li><hr class="dropdown-divider"></li>
            <li class="nav-item"> <%-- Hoặc thẻ <li> của bạn --%>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="margin: 0;">
                    <button type="submit" class="btn btn-link dropdown-item" style="border: none; text-align: left; width: 100%;">
                        Đăng xuất
                    </button>
                </form>
            </li>
        </ul>
    </div>
</div>
