<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .auth-card { max-width: 440px; margin: 60px auto; border-radius: 12px; border: none; box-shadow: 0 8px 24px rgba(0,0,0,0.08); }
        .auth-card .card-header { background: #3b82f6; color: white; border-radius: 12px 12px 0 0; text-align: center; padding: 24px; }
        .btn-primary { background-color: #3b82f6; border-color: #3b82f6; }
        .btn-primary:hover { background-color: #2563eb; }
        .otp-input { letter-spacing: 4px; font-size: 20px; text-align: center; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <div class="card auth-card">
        <div class="card-header">
            <h3 class="mb-0 fw-bold">Đặt lại mật khẩu</h3>
            <p class="small mb-0 mt-1 opacity-75">Nhập mã OTP và mật khẩu mới của bạn</p>
        </div>
        <div class="card-body p-4">
            <c:if test="${alert != null}">
                <div class="alert alert-danger">${alert}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/reset-password" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Địa chỉ Email</label>
                    <input type="email" class="form-control" name="email" value="${email}" placeholder="example@gmail.com" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Mã OTP xác nhận</label>
                    <input type="text" class="form-control otp-input" name="code" maxlength="6" placeholder="******" required autofocus>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu mới</label>
                    <input type="password" class="form-control" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Xác nhận mật khẩu mới</label>
                    <input type="password" class="form-control" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">Cập nhật mật khẩu</button>
            </form>

            <hr class="my-4">
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/login" class="text-secondary text-decoration-none">Quay lại Đăng nhập</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
