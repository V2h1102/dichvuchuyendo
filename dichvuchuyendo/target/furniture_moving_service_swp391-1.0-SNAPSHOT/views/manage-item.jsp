<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Items</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Manage Items</h2>
        <a href="ItemController?action=add" class="btn btn-primary">Add New Item</a>
    </div>

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
            <th>Price ($)</th>
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
                    <a href="ItemController?action=edit&id=${i.id}" class="btn btn-sm btn-warning">Edit</a>
                    <a href="ItemController?action=delete&id=${i.id}" class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
