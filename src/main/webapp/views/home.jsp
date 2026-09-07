<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Cửa Hàng Trực Tuyến</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .hero-banner { background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%); color: white; border-radius: 16px; padding: 40px; }
        .product-card { border: none; border-radius: 12px; transition: transform 0.2s, box-shadow 0.2s; height: 100%; }
        .product-card:hover { transform: translateY(-4px); box-shadow: 0 12px 24px rgba(0,0,0,0.12); }
        .product-img-wrapper { height: 220px; overflow: hidden; border-radius: 12px 12px 0 0; background: #eef2f7; display: flex; align-items: center; justify-content: center; }
        .product-img-wrapper img { width: 100%; height: 100%; object-fit: cover; }
        .price-tag { color: #dc2626; font-weight: 700; font-size: 1.15rem; }
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/product">Tất cả sản phẩm</a></li>
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

<!-- Main Container -->
<div class="container my-4">
    <!-- Hero Banner -->
    <div class="hero-banner mb-5 text-center text-md-start d-flex justify-content-between align-items-center flex-wrap">
        <div>
            <h1 class="fw-extrabold display-5 mb-2">Chào mừng đến với E-Shop</h1>
            <p class="lead opacity-90 mb-4">Khám phá các sản phẩm công nghệ mới nhất với mức giá hấp dẫn nhất!</p>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-light btn-lg fw-bold text-primary px-4 shadow-sm">
                Xem tất cả sản phẩm <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>
        <div class="d-none d-md-block fs-1 opacity-50 px-4">
            <i class="bi bi-bag-heart-fill display-1"></i>
        </div>
    </div>

    <!-- Section 10 Sản phẩm mới nhất -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-0">10 Sản phẩm mới nhất</h3>
            <p class="text-muted small">Cập nhật những mặt hàng mới về cửa hàng</p>
        </div>
        <a href="${pageContext.request.contextPath}/product" class="text-primary text-decoration-none fw-semibold">
            Xem thêm (${totalProducts != null ? totalProducts : 'Tất cả'}) <i class="bi bg-chevron-right"></i>
        </a>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4 mb-5">
        <c:forEach items="${top10Products}" var="p">
            <div class="col">
                <div class="card product-card shadow-sm">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                        <div class="product-img-wrapper">
                            <c:choose>
                                <c:when test="${p.images != null && p.images.startsWith('http')}">
                                    <img src="${p.images}" alt="${p.productName}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/image?fname=${p.images}" alt="${p.productName}">
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </a>
                    <div class="card-body d-flex flex-column">
                        <span class="badge bg-secondary mb-2 w-auto me-auto">${p.category != null ? p.category.categoryname : 'Chung'}</span>
                        <h6 class="card-title text-truncate mb-2">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-dark text-decoration-none fw-bold" title="${p.productName}">
                                ${p.productName}
                            </a>
                        </h6>
                        <div class="mt-auto d-flex justify-content-between align-items-center">
                            <span class="price-tag"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> đ</span>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm btn-outline-primary rounded-circle" title="Xem chi tiết">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty top10Products}">
            <div class="col-12 text-center py-5 text-muted">
                <i class="bi bi-inbox display-4 d-block mb-2"></i>
                Chưa có sản phẩm nào. Vui lòng vào trang Admin để tạo mới.
            </div>
        </c:if>
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
