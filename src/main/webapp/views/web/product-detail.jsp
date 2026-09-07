<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.productName} - Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .product-detail-img { width: 100%; max-height: 450px; object-fit: cover; border-radius: 12px; }
        .price-large { font-size: 2.2rem; color: #dc2626; font-weight: 800; }
        .detail-card { border: none; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.06); }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-shop me-2"></i>E-Shop MVC
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/product">Tất cả sản phẩm</a></li>
                <c:if test="${sessionScope.account != null}">
                    <li class="nav-item"><a class="nav-link text-info fw-semibold" href="${pageContext.request.contextPath}/user/profile"><i class="bi bi-person-badge me-1"></i>Hồ sơ cá nhân</a></li>
                </c:if>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                    <li class="nav-item"><a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/products">Trang Admin</a></li>
                </c:if>
            </ul>
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light me-2">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Đăng ký</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-outline-light me-2 d-inline-flex align-items-center gap-2 rounded-pill px-3" title="Xem & Cập nhật Profile">
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.avatar && !sessionScope.account.avatar.startsWith('http')}">
                                    <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" alt="Avatar" style="width: 28px; height: 28px; object-fit: cover; border-radius: 50%;">
                                </c:when>
                                <c:when test="${not empty sessionScope.account.avatar && sessionScope.account.avatar.startsWith('http')}">
                                    <img src="${sessionScope.account.avatar}" alt="Avatar" style="width: 28px; height: 28px; object-fit: cover; border-radius: 50%;">
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-person-circle fs-6"></i>
                                </c:otherwise>
                            </c:choose>
                            <span>${sessionScope.account.fullName}</span>
                            <span class="badge bg-primary ms-1">Profile</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-pill px-3">Đăng xuất</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div class="container my-5">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product" class="text-decoration-none">Sản phẩm</a></li>
            <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
        </ol>
    </nav>

    <div class="card detail-card p-4 bg-white">
        <div class="row g-4 align-items-center">
            <!-- Product Image -->
            <div class="col-md-5 text-center">
                <c:choose>
                    <c:when test="${product.images != null && product.images.startsWith('http')}">
                        <img src="${product.images}" class="product-detail-img shadow-sm" alt="${product.productName}">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/image?fname=${product.images}" class="product-detail-img shadow-sm" alt="${product.productName}">
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Product Info -->
            <div class="col-md-7">
                <span class="badge bg-info text-dark px-3 py-2 fs-6 mb-2">
                    <i class="bi bi-tag-fill me-1"></i>${product.category != null ? product.category.categoryname : 'Danh mục chung'}
                </span>
                <h1 class="fw-bold display-6 mb-3">${product.productName}</h1>

                <div class="price-large mb-3">
                    <fmt:formatNumber value="${product.price}" pattern="#,##0"/> đ
                </div>

                <div class="mb-4">
                    <span class="badge ${product.quantity > 0 ? 'bg-success' : 'bg-danger'} px-2 py-1">
                        ${product.quantity > 0 ? 'Còn hàng' : 'Hết hàng'} (${product.quantity} sản phẩm trong kho)
                    </span>
                    <c:if test="${product.status == 1}">
                        <span class="badge bg-primary ms-2 px-2 py-1">Đang kinh doanh</span>
                    </c:if>
                </div>

                <hr class="my-4">

                <h5 class="fw-bold mb-2">Mô tả sản phẩm:</h5>
                <p class="text-muted leading-relaxed mb-4">
                    <c:choose>
                        <c:when test="${not empty product.description}">
                            ${product.description}
                        </c:when>
                        <c:otherwise>
                            Sản phẩm chất lượng cao, chính hãng với đầy đủ chế độ bảo hành.
                        </c:otherwise>
                    </c:choose>
                </p>

                <div class="d-flex gap-3 mt-4">
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary btn-lg px-4">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại
                    </a>
                    <button class="btn btn-primary btn-lg px-5 shadow-sm" onclick="alert('Đã thêm sản phẩm vào giỏ hàng thành công!')">
                        <i class="bi bi-cart-plus me-2"></i> Mua ngay
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="bg-white border-top py-4 mt-auto">
    <div class="container text-center text-muted small">
        <p class="mb-0">© 2026 E-Shop MVC Project. All rights reserved.</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
