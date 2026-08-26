<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Đăng ký</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css"></head>
<body>
<div class="container auth"><div class="card">
    <h2>Tạo tài khoản mới</h2>
    <c:if test="${alert != null}"><div class="alert">${alert}</div></c:if>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <label>Tài khoản</label><input type="text" name="username" value="${param.username}" required>
        <label>Mật khẩu</label><input type="password" name="password" required>
        <label>Email</label><input type="email" name="email" value="${param.email}" required>
        <label>Họ tên</label><input type="text" name="fullname" value="${param.fullname}" required>
        <label>Số điện thoại</label><input type="tel" name="phone" value="${param.phone}">
        <button type="submit">Đăng ký</button>
    </form>
    <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
</div></div>
</body></html>
