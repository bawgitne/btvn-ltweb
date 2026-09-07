<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><decorator:title default="Trang cá nhân User" /></title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f4f6f9;
            color: #1e293b;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-navbar {
            background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.35rem;
            letter-spacing: -0.5px;
        }
        .nav-link {
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.2s ease;
        }
        .nav-link:hover {
            color: #a5b4fc !important;
        }
        .user-avatar-badge {
            width: 38px;
            height: 38px;
            object-fit: cover;
            border: 2px solid #818cf8;
        }
        .main-content-wrapper {
            flex: 1;
            padding-top: 2rem;
            padding-bottom: 3rem;
        }
        footer {
            background-color: #0f172a;
            color: #94a3b8;
            padding: 1.5rem 0;
            font-size: 0.9rem;
            margin-top: auto;
        }
    </style>
    <decorator:head />
</head>
<body>

    <!-- Header / Navbar managed by SiteMesh -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark main-navbar sticky-top">
            <div class="container">
                <a class="navbar-brand text-white d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                    <i class="bi bi-shop text-indigo-400"></i>
                    <span>E-Shop MVC</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="userNavbar">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/home">
                                <i class="bi bi-house-door me-1"></i> Trang chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/product">
                                <i class="bi bi-grid me-1"></i> Sản phẩm
                            </a>
                        </li>
                    </ul>

                    <div class="d-flex align-items-center gap-3">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account}">
                                <div class="dropdown">
                                    <a class="btn btn-outline-light dropdown-toggle d-flex align-items-center gap-2 rounded-pill px-3 py-1" 
                                       href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.account.avatar && !sessionScope.account.avatar.startsWith('http')}">
                                                <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" 
                                                     alt="Avatar" class="rounded-circle user-avatar-badge">
                                            </c:when>
                                            <c:when test="${not empty sessionScope.account.avatar && sessionScope.account.avatar.startsWith('http')}">
                                                <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle user-avatar-badge">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-person-circle fs-5"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="fw-semibold">${sessionScope.account.fullName}</span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 mt-2">
                                        <li>
                                            <a class="dropdown-item d-flex align-items-center gap-2 py-2" href="${pageContext.request.contextPath}/user/profile">
                                                <i class="bi bi-person-gear text-primary"></i> Thông tin cá nhân
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item d-flex align-items-center gap-2 py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                                <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm rounded-pill px-3">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Dynamic Body Container populated by SiteMesh -->
    <main class="main-content-wrapper">
        <decorator:body />
    </main>

    <!-- Footer managed by SiteMesh -->
    <footer>
        <div class="container text-center">
            <p class="mb-1 fw-semibold text-white">&copy; 2026 E-Shop MVC 3-Tier Servlet & JPA</p>
            <p class="mb-0 text-white-50">Quản lý giao diện bằng SiteMesh decorator</p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
