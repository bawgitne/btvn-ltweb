<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Đăng nhập</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css"></head>
<body>
<div class="container auth"><div class="card">
    <h2>Đăng nhập vào hệ thống</h2>
    <c:if test="${param.registered == '1'}"><div class="success">Đăng ký thành công. Hãy đăng nhập.</div></c:if>
    <c:if test="${alert != null}"><div class="alert">${alert}</div></c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <label>Tài khoản</label>
        <input type="text" name="username" placeholder="Tài khoản" required>
        <label>Mật khẩu</label>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <label style="font-weight:normal"><input type="checkbox" name="remember"> Nhớ tài khoản (30 phút)</label>
        <button type="submit">Đăng nhập</button>
    </form>
    <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký</a></p>
    <p class="small">Demo admin: admin / 123456</p>
</div></div>
</body></html>
