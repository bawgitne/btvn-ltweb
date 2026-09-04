<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .auth-card { max-width: 420px; margin: 60px auto; border-radius: 12px; border: none; box-shadow: 0 8px 24px rgba(0,0,0,0.08); }
        .auth-card .card-header { background: #4f46e5; color: white; border-radius: 12px 12px 0 0; text-align: center; padding: 24px; }
        .btn-primary { background-color: #4f46e5; border-color: #4f46e5; }
        .btn-primary:hover { background-color: #4338ca; }
    </style>
</head>
<body>
<div class="container">
    <div class="card auth-card">
        <div class="card-header">
            <h3 class="mb-0 fw-bold">Đăng nhập</h3>
            <p class="small mb-0 mt-1 opacity-75">Chào mừng bạn quay trở lại</p>
        </div>
        <div class="card-body p-4">
            <c:if test="${msg != null}"><div class="alert alert-success">${msg}</div></c:if>
            <c:if test="${alert != null}"><div class="alert alert-danger">${alert}</div></c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tài khoản / Email</label>
                    <input type="text" class="form-control" name="username" placeholder="Nhập tên đăng nhập hoặc email" required>
                </div>
                <div class="mb-3">
                    <div class="d-flex justify-content-between">
                        <label class="form-label fw-semibold">Mật khẩu</label>
                        <a href="${pageContext.request.contextPath}/forgot-password" class="small text-primary text-decoration-none">Quên mật khẩu?</a>
                    </div>
                    <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu" required>
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="remember" name="remember">
                    <label class="form-check-label" for="remember">Ghi nhớ đăng nhập</label>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">Đăng nhập</button>
            </form>

            <hr class="my-4">
            <div class="text-center">
                <span>Chưa có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-primary text-decoration-none">Đăng ký ngay</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
