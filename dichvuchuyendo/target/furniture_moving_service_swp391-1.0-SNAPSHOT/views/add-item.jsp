<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Add New Item</title>
</head>
<body>
<h2>Add New Item</h2>
<form action="ItemController" method="post">
    <label>Name:</label><input type="text" name="name" required><br>
    <label>Description:</label><input type="text" name="description"><br>
    <label>Category:</label><input type="text" name="category"><br>
    <label>Price:</label><input type="number" step="0.01" name="price"><br>
    <label>Status:</label>
    <select name="status">
        <option>Active</option>
        <option>Inactive</option>
    </select><br>
    <input type="submit" value="Add Item">
</form>
</body>
</html>
