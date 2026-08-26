<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Thêm Category</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css"></head><body>
<nav><div class="inner"><b>Admin</b><a href="${pageContext.request.contextPath}/admin/category/list">Danh sách Category</a></div></nav>
<div class="container"><div class="card"><h1>Thêm Category</h1>
<c:if test="${alert != null}"><div class="alert">${alert}</div></c:if>
<form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
<label>Tên danh mục</label><input type="text" name="name" required>
<label>Ảnh đại diện</label><input type="file" name="icon" accept="image/*">
<br><button type="submit">Thêm</button> <a class="button secondary" href="${pageContext.request.contextPath}/admin/category/list">Hủy</a>
</form></div></div></body></html>
