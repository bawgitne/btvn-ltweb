<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Trang chủ</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css"></head><body>
<nav><div class="inner"><b>MVC 3-Tier</b><span class="spacer"></span>
<c:choose><c:when test="${sessionScope.account == null}">
<a href="${pageContext.request.contextPath}/login">Đăng nhập</a><a href="${pageContext.request.contextPath}/register">Đăng ký</a>
</c:when><c:otherwise><span>${sessionScope.account.fullName}</span><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></c:otherwise></c:choose>
</div></nav>
<div class="container"><div class="card"><h1>Trang chủ</h1><p>Đăng nhập/đăng ký theo MVC2 + kiến trúc 3 tầng.</p></div></div>
</body></html>
