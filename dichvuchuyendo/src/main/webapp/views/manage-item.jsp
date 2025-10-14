<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Items</title>
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="d-flex">

    <!-- Sidebar -->
    <jsp:include page="sidebar.jsp" />

    <!-- Main Content -->
    <div class="container-fluid" style="margin-left:50px;">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
            <div class="container-fluid">
                <h4 class="mt-2">Manage Items</h4>
                <a href="ItemController?action=add" class="btn btn-success">
                    <i class="bi bi-plus-circle"></i> Add New Item
                </a>
            </div>
        </nav>

        <div class="p-4">

            <!-- Search Form -->
            <form class="row g-3 mb-3" method="get" action="ItemController">
                <input type="hidden" name="action" value="list">

                <div class="col-md-6">
                    <input type="text" class="form-control" name="search"
                           placeholder="Search by item name..."
                           value="${param.search != null ? param.search : ''}">
                </div>

                <div class="col-md-4">
                    <select class="form-select" name="statusFilter">
                        <option value="">-- All Status --</option>
                        <option value="active" <c:if test="${param.statusFilter == 'active'}">selected</c:if>>Active</option>
                        <option value="inactive" <c:if test="${param.statusFilter == 'inactive'}">selected</c:if>>Inactive</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search"></i> Search
                    </button>
                </div>
            </form>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <table class="table table-bordered table-hover table-striped">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Category</th>
                    <th>Weight (kg)</th>
                    <th>Volume (m³)</th>
                    <th>Service Price (vnd)</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="i" items="${list}">
                    <tr>
                        <td>${i.id}</td>
                        <td>${i.name}</td>
                        <td>${i.description}</td>
                        <td>${i.categoryName}</td>
                        <td>${i.weightKg}</td>
                        <td>${i.volumeM3}</td>
                        <td>${i.basePrice}</td>
                        <td>
                            <c:choose>
                                <c:when test="${i.active}">Active</c:when>
                                <c:otherwise>Inactive</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="ItemController?action=edit&id=${i.id}" class="btn btn-sm btn-warning">
                                <i class="bi bi-pencil-square"></i> Edit
                            </a>
                            <a href="ItemController?action=delete&id=${i.id}" class="btn btn-sm btn-danger"
                               onclick="return confirm('Are you sure you want to delete this item?');">
                                <i class="bi bi-trash"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
