<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .auth-card { max-width: 440px; margin: 60px auto; border-radius: 12px; border: none; box-shadow: 0 8px 24px rgba(0,0,0,0.08); }
        .auth-card .card-header { background: #f59e0b; color: white; border-radius: 12px 12px 0 0; text-align: center; padding: 24px; }
        .btn-warning { background-color: #f59e0b; border-color: #f59e0b; color: white; }
        .btn-warning:hover { background-color: #d97706; color: white; }
    </style>
</head>
<body>
<div class="container">
    <div class="card auth-card">
        <div class="card-header">
            <h3 class="mb-0 fw-bold">Quên mật khẩu</h3>
            <p class="small mb-0 mt-1 opacity-75">Nhập email đăng ký để nhận mã xác nhận OTP</p>
        </div>
        <div class="card-body p-4">
            <c:if test="${alert != null}">
                <div class="alert alert-danger">${alert}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Email tài khoản</label>
                    <input type="email" class="form-control" name="email" placeholder="nhapemail@gmail.com" required autofocus>
                </div>
                <button type="submit" class="btn btn-warning w-100 py-2 fw-semibold">Gửi mã OTP qua Mail</button>
            </form>

            <hr class="my-4">
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/login" class="text-secondary text-decoration-none">Nhớ mật khẩu? Đăng nhập ngay</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
