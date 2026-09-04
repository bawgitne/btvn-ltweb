<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Sản phẩm - E-Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .product-card { border: none; border-radius: 12px; transition: transform 0.2s, box-shadow 0.2s; height: 100%; }
        .product-card:hover { transform: translateY(-4px); box-shadow: 0 12px 24px rgba(0,0,0,0.12); }
        .product-img-wrapper { height: 230px; overflow: hidden; border-radius: 12px 12px 0 0; background: #eef2f7; display: flex; align-items: center; justify-content: center; }
        .product-img-wrapper img { width: 100%; height: 100%; object-fit: cover; }
        .price-tag { color: #dc2626; font-weight: 700; font-size: 1.2rem; }
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
                        <span class="text-light me-3"><i class="bi bi-person-circle me-1"></i>${sessionScope.account.fullName}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Đăng xuất</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div class="container my-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h2 class="fw-bold mb-1">Tất cả Sản phẩm</h2>
            <p class="text-muted mb-0">Hiển thị 6 sản phẩm mỗi trang (Tổng số ${totalProducts} sản phẩm)</p>
        </div>
        <span class="badge bg-primary fs-6 px-3 py-2">Trang ${currentPage} / ${totalPages}</span>
    </div>

    <!-- Product Grid (6 products per page) -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mb-5">
        <c:forEach items="${products}" var="p">
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
                    <div class="card-body d-flex flex-column p-4">
                        <span class="badge bg-info text-dark mb-2 w-auto me-auto">${p.category != null ? p.category.categoryname : 'Danh mục'}</span>
                        <h5 class="card-title text-truncate mb-2">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-dark text-decoration-none fw-bold" title="${p.productName}">
                                ${p.productName}
                            </a>
                        </h5>
                        <p class="text-muted small text-truncate mb-3">${p.description}</p>
                        <div class="mt-auto d-flex justify-content-between align-items-center">
                            <span class="price-tag"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> đ</span>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-primary px-3">
                                Chi tiết <i class="bi bi-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty products}">
            <div class="col-12 text-center py-5 text-muted">
                <i class="bi bi-bag-x display-3 d-block mb-3"></i>
                Không tìm thấy sản phẩm nào trên trang này.
            </div>
        </c:if>
    </div>

    <!-- Pagination Controls (Phân trang 6sp/trang) -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="mb-5">
            <ul class="pagination justify-content-center">
                <!-- Previous Button -->
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">Trắc trước</a>
                </li>

                <!-- Page Numbers -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                    </li>
                </c:forEach>

                <!-- Next Button -->
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">Trang tiếp</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

<footer class="bg-white border-top py-4 mt-auto">
    <div class="container text-center text-muted small">
        <p class="mb-0">© 2026 E-Shop MVC Project. All rights reserved.</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
