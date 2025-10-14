<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex flex-column flex-shrink-0 p-3 bg-secondary text-white vh-100" style="width: 240px;">
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
            <a href="UserController" class="nav-link text-white ${pageName == 'users' ? 'active bg-secondary' : ''}">
                <i class="bi bi-people me-2"></i> Users
            </a>
        </li>
    </ul>

    <hr>
    <div class="dropdown">
        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
           data-bs-toggle="dropdown" aria-expanded="false">
            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="" width="32" height="32" class="rounded-circle me-2">
            <strong>${sessionScope.user != null ? sessionScope.user.name : "Admin"}</strong>
        </a>
        <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
            <li><a class="dropdown-item" href="#">Profile</a></li>
            <li><a class="dropdown-item" href="#">Settings</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="LogoutServlet">Logout</a></li>
        </ul>
    </div>
</div>
