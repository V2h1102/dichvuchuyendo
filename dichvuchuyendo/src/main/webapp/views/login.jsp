<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="text-center mb-4">Đăng nhập</h3>
                    <form action="../login" method="post">
                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label>Mật khẩu</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <button class="btn btn-primary w-100">Đăng nhập</button>
                    </form>
                    <p class="text-danger text-center mt-2">
                        ${error}
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

