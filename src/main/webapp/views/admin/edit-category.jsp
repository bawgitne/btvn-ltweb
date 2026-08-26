<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Sửa Category</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css"></head><body>
<nav><div class="inner"><b>Admin</b><a href="${pageContext.request.contextPath}/admin/category/list">Danh sách Category</a></div></nav>
<div class="container"><div class="card"><h1>Sửa Category</h1>
<c:if test="${alert != null}"><div class="alert">${alert}</div></c:if>
<form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
<input type="hidden" name="id" value="${category.id}">
<label>Tên danh mục</label><input type="text" name="name" value="${category.name}" required>
<c:if test="${not empty category.icon}"><c:url value="/image" var="imgUrl"><c:param name="fname" value="${category.icon}"/></c:url>
<p><img class="icon" src="${imgUrl}" alt="${category.name}"></p></c:if>
<label>Ảnh đại diện mới (bỏ trống để giữ ảnh cũ)</label><input type="file" name="icon" accept="image/*">
<br><button type="submit">Lưu</button> <a class="button secondary" href="${pageContext.request.contextPath}/admin/category/list">Hủy</a>
</form></div></div></body></html>
