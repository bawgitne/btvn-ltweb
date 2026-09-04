<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm (Products)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .product-img { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; }
    </style>
</head>
<body>
<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Quản lý Danh sách Sản phẩm</h2>
        <div>
            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary me-2">Quản lý Danh mục</a>
            <a href="<c:url value='/admin/product/add'/>" class="btn btn-primary">+ Thêm Sản phẩm mới</a>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th class="ps-3">STT</th>
                    <th>Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá bán</th>
                    <th>Danh mục</th>
                    <th>Số lượng</th>
                    <th>Trạng thái</th>
                    <th class="text-center">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listproduct}" var="p" varStatus="STT">
                    <tr>
                        <td class="ps-3 fw-bold">${STT.index + 1}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.images != null && p.images.startsWith('http')}">
                                    <img src="${p.images}" class="product-img" alt="${p.productName}">
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value='/image?fname=${p.images}'/>" class="product-img" alt="${p.productName}">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="fw-semibold">${p.productName}</td>
                        <td class="text-danger fw-bold">
                            <fmt:formatNumber value="${p.price}" pattern="#,##0"/> đ
                        </td>
                        <td>
                            <span class="badge bg-info text-dark">${p.category != null ? p.category.categoryname : 'Chưa phân loại'}</span>
                        </td>
                        <td>${p.quantity}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.status == 1}">
                                    <span class="badge bg-success">Đang bán</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Ngừng bán</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-sm btn-outline-warning me-1">Sửa</a>
                            <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listproduct}">
                    <tr>
                        <td colspan="8" class="text-center py-4 text-muted">Chưa có sản phẩm nào trong hệ thống.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
