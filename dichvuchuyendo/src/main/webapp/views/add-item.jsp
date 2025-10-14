<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Add New Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f6fa;
        }
        .navbar {
            background-color: #2c3e50;
        }
        .navbar-brand, .nav-link {
            color: #ecf0f1 !important;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .btn-custom {
            background-color: #3498db;
            color: white;
        }
        .btn-custom:hover {
            background-color: #2980b9;
            color: white;
        }
    </style>
</head>
<body>
<!-- 🔹 Navbar -->
<nav class="navbar navbar-expand-lg mb-4">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="ItemController?action=list">Furniture Moving Admin</a>
        <div class="d-flex">
            <a href="ItemController?action=list" class="btn btn-outline-light btn-sm">← Back to Items</a>
        </div>
    </div>
</nav>

<!-- 🔹 Form card -->
<div class="container mt-4" style="max-width: 650px;">
    <div class="card p-4">
        <h3 class="text-center mb-4">Add New Item</h3>
        <form action="ItemController" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Item Name</label>
                <input type="text" class="form-control" name="name" placeholder="Enter item name" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Description</label>
                <textarea class="form-control" name="description" rows="2" placeholder="Enter description"></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Category</label>
                <select class="form-select" name="categoryId" required>
                    <option value="" selected disabled>-- Select Category --</option>
                    <c:forEach var="c" items="${categoryList}">
                        <option value="${c.id}">${c.name}</option>
                    </c:forEach>
                </select>
            </div>


            <div class="mb-3">
                <label class="form-label fw-semibold">Price</label>
                <input type="number" step="0.01" class="form-control" name="price" placeholder="Enter price">
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Status</label>
                <select class="form-select" name="status">
                    <option value="Active">Active</option>
                    <option value="Inactive">Inactive</option>
                </select>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-custom">Add Item</button>
                <a href="ItemController?action=list" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
