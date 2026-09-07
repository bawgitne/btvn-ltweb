<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ Sơ Cá Nhân - Cập Nhật Profile</title>
    <style>
        .profile-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            background: #ffffff;
            overflow: hidden;
        }
        .profile-header {
            background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
            padding: 2.5rem 2rem;
            color: #ffffff;
            text-align: center;
        }
        .avatar-wrapper {
            position: relative;
            width: 130px;
            height: 130px;
            margin: 0 auto 1rem auto;
        }
        .avatar-img {
            width: 130px;
            height: 130px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #ffffff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            background-color: #e2e8f0;
        }
        .btn-upload-label {
            position: absolute;
            bottom: 4px;
            right: 4px;
            background: #4f46e5;
            color: #ffffff;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid #ffffff;
            transition: all 0.2s ease;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .btn-upload-label:hover {
            background: #4338ca;
            transform: scale(1.08);
        }
        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            color: #475569;
        }
        .form-control:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 0.25rem rgba(99, 102, 241, 0.15);
        }
        .badge-role {
            background-color: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(4px);
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">

            <!-- Alerts / Messages -->
            <c:if test="${not empty msg}">
                <div class="alert alert-success alert-dismissible fade show rounded-3 mb-4 shadow-sm" role="alert">
                    <i class="bi bi-check-circle-fill me-2 fs-5 align-middle"></i>
                    <span>${msg}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show rounded-3 mb-4 shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5 align-middle"></i>
                    <span>${error}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Main Profile Card -->
            <div class="card profile-card mb-5">
                <div class="profile-header">
                    <div class="avatar-wrapper">
                        <c:choose>
                            <c:when test="${not empty user.avatar && !user.avatar.startsWith('http')}">
                                <img id="avatarPreview" src="${pageContext.request.contextPath}/image?fname=${user.avatar}" alt="Avatar" class="avatar-img">
                            </c:when>
                            <c:when test="${not empty user.avatar && user.avatar.startsWith('http')}">
                                <img id="avatarPreview" src="${user.avatar}" alt="Avatar" class="avatar-img">
                            </c:when>
                            <c:otherwise>
                                <img id="avatarPreview" src="https://via.placeholder.com/130?text=User" alt="Avatar" class="avatar-img">
                            </c:otherwise>
                        </c:choose>
                        <label for="imagesInput" class="btn-upload-label" title="Tải ảnh mới">
                            <i class="bi bi-camera-fill"></i>
                        </label>
                    </div>
                    <h3 class="fw-bold mb-1">${user.fullName}</h3>
                    <p class="text-white-50 mb-2">@${user.userName}</p>
                    <span class="badge-role">
                        <i class="bi bi-shield-check me-1"></i>
                        <c:choose>
                            <c:when test="${user.roleid == 1}">Quản Trị Viên (Admin)</c:when>
                            <c:when test="${user.roleid == 2}">Quản Lý (Manager)</c:when>
                            <c:otherwise>Thành Viên (User)</c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="card-body p-4 p-md-5">
                    <h5 class="fw-bold text-dark mb-4 pb-2 border-bottom">
                        <i class="bi bi-person-lines-fill text-primary me-2"></i>Cập Nhật Thông Tin Profile
                    </h5>

                    <!-- Multipart Form for Profile Update -->
                    <form action="${pageContext.request.contextPath}/user/profile/update" method="post" enctype="multipart/form-data">
                        
                        <!-- File Input (Hidden, triggered by camera button or visible picker) -->
                        <input type="file" id="imagesInput" name="images" accept="image/*" class="d-none" onchange="previewImage(this)">

                        <div class="row g-3">
                            <!-- Full Name Field -->
                            <div class="col-md-6">
                                <label for="fullname" class="form-label">Họ và Tên <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-secondary"></i></span>
                                    <input type="text" class="form-control border-start-0 ps-0" id="fullname" name="fullname" 
                                           value="${user.fullName}" required placeholder="Nhập họ và tên">
                                </div>
                            </div>

                            <!-- Phone Field -->
                            <div class="col-md-6">
                                <label for="phone" class="form-label">Số Điện Thoại</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-telephone text-secondary"></i></span>
                                    <input type="text" class="form-control border-start-0 ps-0" id="phone" name="phone" 
                                           value="${user.phone}" placeholder="Nhập số điện thoại">
                                </div>
                            </div>

                            <!-- File upload preview control line -->
                            <div class="col-12">
                                <label class="form-label">Ảnh đại diện (Avatar / Images)</label>
                                <div class="input-group">
                                    <input type="file" class="form-control" name="avatarFile" id="imagesInputVisible" accept="image/*" onchange="syncAndPreview(this)">
                                </div>
                                <div class="form-text text-muted">
                                    <i class="bi bi-info-circle me-1"></i>Hỗ trợ các định dạng JPG, PNG, GIF. Kích thước file tối đa 10MB.
                                </div>
                            </div>

                            <!-- Read-only fields -->
                            <div class="col-md-6 mt-4">
                                <label class="form-label">Tên Đăng Nhập (Username)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-at text-secondary"></i></span>
                                    <input type="text" class="form-control bg-light border-start-0 ps-0 text-muted" value="${user.userName}" readonly>
                                </div>
                            </div>

                            <div class="col-md-6 mt-4">
                                <label class="form-label">Địa Chỉ Email</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-secondary"></i></span>
                                    <input type="email" class="form-control bg-light border-start-0 ps-0 text-muted" value="${user.email}" readonly>
                                </div>
                            </div>

                            <div class="col-md-6 mt-3">
                                <label class="form-label">Ngày Thâm Niên (Ngày tạo)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-calendar-event text-secondary"></i></span>
                                    <input type="text" class="form-control bg-light border-start-0 ps-0 text-muted" 
                                           value="${user.createdDate}" readonly>
                                </div>
                            </div>

                            <div class="col-md-6 mt-3">
                                <label class="form-label">Trạng Thái Tài Khoản</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-check-circle text-secondary"></i></span>
                                    <input type="text" class="form-control bg-light border-start-0 ps-0 text-success fw-semibold" 
                                           value="${user.status == 1 ? 'Đã kích hoạt' : 'Chưa kích hoạt'}" readonly>
                                </div>
                            </div>
                        </div>

                        <!-- Submit Buttons -->
                        <div class="d-flex justify-content-end gap-3 mt-4 pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-4 rounded-pill">
                                <i class="bi bi-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4 rounded-pill shadow-sm">
                                <i class="bi bi-floppy me-1"></i> Lưu thay đổi JPA
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    function previewImage(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function syncAndPreview(visibleInput) {
        if (visibleInput.files && visibleInput.files[0]) {
            const hiddenInput = document.getElementById('imagesInput');
            hiddenInput.files = visibleInput.files;
            previewImage(visibleInput);
        }
    }
</script>
</body>
</html>
