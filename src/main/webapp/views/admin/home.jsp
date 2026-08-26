<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Admin</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css"></head><body>
<nav><div class="inner"><b>Admin</b><a href="${pageContext.request.contextPath}/admin/category/list">Quản lý Category</a><span class="spacer"></span><span>${sessionScope.account.fullName}</span><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></div></nav>
<div class="container"><div class="card"><h1>Admin Home</h1><p>Chọn <b>Quản lý Category</b> để thực hiện CRUD.</p></div></div>
</body></html>
