<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Manager</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css"></head><body>
<nav><div class="inner"><b>Manager</b><span class="spacer"></span><a href="${pageContext.request.contextPath}/user/profile">Profile (${sessionScope.account.fullName})</a><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></div></nav>
<div class="container"><div class="card"><h1>Manager Home</h1><p>Xin chào ${sessionScope.account.fullName}.</p></div></div>
</body></html>
