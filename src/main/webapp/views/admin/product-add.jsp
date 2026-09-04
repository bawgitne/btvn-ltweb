<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Sản phẩm mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container my-4" style="max-width: 700px;">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Thêm Sản phẩm Mới</h4>
        </div>
        <div class="card-body p-4">
            <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên sản phẩm *</label>
                    <input type="text" class="form-control" name="productName" placeholder="Nhập tên sản phẩm" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Giá bán (VNĐ) *</label>
                        <input type="number" step="1000" class="form-control" name="price" placeholder="100000" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Số lượng trong kho *</label>
                        <input type="number" class="form-control" name="quantity" value="10" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Danh mục sản phẩm *</label>
                        <select class="form-select" name="categoryId" required>
                            <option value="">-- Chọn Danh mục --</option>
                            <c:forEach items="${listcate}" var="cat">
                                <option value="${cat.categoryid}">${cat.categoryname}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Trạng thái</label>
                        <select class="form-select" name="status">
                            <option value="1">Đang bán (Hoạt động)</option>
                            <option value="0">Ngừng bán (Khóa)</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mô tả sản phẩm</label>
                    <textarea class="form-control" name="description" rows="3" placeholder="Mô tả chi tiết sản phẩm..."></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tải lên hình ảnh sản phẩm</label>
                    <input type="file" class="form-control" name="images1" accept="image/*">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Hoặc nhập URL hình ảnh (nếu không tải file)</label>
                    <input type="text" class="form-control" name="images" placeholder="https://example.com/image.jpg">
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="<c:url value='/admin/products'/>" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-primary px-4">Lưu sản phẩm</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
