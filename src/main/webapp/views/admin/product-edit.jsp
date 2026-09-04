<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container my-4" style="max-width: 700px;">
    <div class="card shadow-sm">
        <div class="card-header bg-warning text-dark">
            <h4 class="mb-0 fw-bold">Chỉnh sửa Sản phẩm #${product.productId}</h4>
        </div>
        <div class="card-body p-4">
            <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productId" value="${product.productId}">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên sản phẩm *</label>
                    <input type="text" class="form-control" name="productName" value="${product.productName}" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Giá bán (VNĐ) *</label>
                        <input type="number" step="1000" class="form-control" name="price" value="${product.price}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Số lượng *</label>
                        <input type="number" class="form-control" name="quantity" value="${product.quantity}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Danh mục *</label>
                        <select class="form-select" name="categoryId" required>
                            <c:forEach items="${listcate}" var="cat">
                                <option value="${cat.categoryid}" ${product.category != null && product.category.categoryid == cat.categoryid ? 'selected' : ''}>
                                    ${cat.categoryname}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Trạng thái</label>
                        <select class="form-select" name="status">
                            <option value="1" ${product.status == 1 ? 'selected' : ''}>Đang bán</option>
                            <option value="0" ${product.status == 0 ? 'selected' : ''}>Ngừng bán</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mô tả sản phẩm</label>
                    <textarea class="form-control" name="description" rows="3">${product.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Hình ảnh hiện tại</label><br>
                    <c:choose>
                        <c:when test="${product.images != null && product.images.startsWith('http')}">
                            <img src="${product.images}" style="height: 100px; object-fit: cover; border-radius: 6px;" class="mb-2">
                        </c:when>
                        <c:otherwise>
                            <img src="<c:url value='/image?fname=${product.images}'/>" style="height: 100px; object-fit: cover; border-radius: 6px;" class="mb-2">
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tải lên hình ảnh mới (nếu thay đổi)</label>
                    <input type="file" class="form-control" name="images1" accept="image/*">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Hoặc đường dẫn URL hình ảnh mới</label>
                    <input type="text" class="form-control" name="images" value="${product.images}">
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="<c:url value='/admin/products'/>" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-warning px-4 fw-semibold">Cập nhật sản phẩm</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
