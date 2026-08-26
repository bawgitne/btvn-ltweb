<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Category</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/app.css"></head><body>
<nav><div class="inner"><b>Admin</b><a href="${pageContext.request.contextPath}/admin/home">Trang admin</a><span class="spacer"></span><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></div></nav>
<div class="container"><div class="card">
<h1>Danh sách Category</h1>
<div class="toolbar">
<form method="get" action="${pageContext.request.contextPath}/admin/category/list">
<div style="flex:1"><label>Tìm kiếm</label><input type="text" name="keyword" value="${keyword}" placeholder="Tên category"></div>
<button type="submit">Tìm</button></form>
<a class="button" href="${pageContext.request.contextPath}/admin/category/add">+ Thêm Category</a>
</div>
<table><thead><tr><th>STT</th><th>Icon</th><th>Tên</th><th>Thao tác</th></tr></thead><tbody>
<c:forEach items="${cateList}" var="cate" varStatus="stt">
<tr><td>${stt.index + 1}</td><td>
<c:choose><c:when test="${not empty cate.icon}">
<c:url value="/image" var="imgUrl"><c:param name="fname" value="${cate.icon}"/></c:url>
<img class="icon" src="${imgUrl}" alt="${cate.name}">
</c:when><c:otherwise><span class="small">Chưa có ảnh</span></c:otherwise></c:choose>
</td><td>${cate.name}</td><td class="actions">
<a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}">Sửa</a>
<a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" onclick="return confirm('Xóa category này?')">Xóa</a>
</td></tr>
</c:forEach>
<c:if test="${empty cateList}"><tr><td colspan="4">Không có dữ liệu.</td></tr></c:if>
</tbody></table>
</div></div></body></html>
