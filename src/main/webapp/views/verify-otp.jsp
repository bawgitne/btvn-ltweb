<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận mã OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .auth-card { max-width: 440px; margin: 60px auto; border-radius: 12px; border: none; box-shadow: 0 8px 24px rgba(0,0,0,0.08); }
        .auth-card .card-header { background: #10b981; color: white; border-radius: 12px 12px 0 0; text-align: center; padding: 24px; }
        .btn-success { background-color: #10b981; border-color: #10b981; }
        .btn-success:hover { background-color: #059669; }
        .otp-input { letter-spacing: 6px; font-size: 24px; text-align: center; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <div class="card auth-card">
        <div class="card-header">
            <h3 class="mb-0 fw-bold">Kích hoạt tài khoản</h3>
            <p class="small mb-0 mt-1 opacity-75">Nhập mã OTP được gửi đến email của bạn</p>
        </div>
        <div class="card-body p-4">
            <c:if test="${alert != null}">
                <div class="alert alert-danger">${alert}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Địa chỉ Email</label>
                    <input type="email" class="form-control" name="email" value="${email}" placeholder="example@gmail.com" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-semibold">Mã OTP (6 chữ số)</label>
                    <input type="text" class="form-control otp-input" name="code" maxlength="6" placeholder="******" required autofocus>
                    <div class="form-text text-center">Vui lòng kiểm tra hộp thư (hoặc Console Log) để lấy mã OTP</div>
                </div>
                <button type="submit" class="btn btn-success w-100 py-2 fw-semibold">Kích hoạt tài khoản</button>
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
