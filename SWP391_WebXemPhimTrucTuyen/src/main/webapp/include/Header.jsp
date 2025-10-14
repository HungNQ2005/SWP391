<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-bg fixed-top">
        <div class="container-fluid">
            <!--logo-->
            <a class="navbar-brand" href="Main.html" aria-label="Trang chủ MyWebsite">
                <img
                    src="../Images/logo.png"
                    alt="MyWebsite logo"
                    width="60"
                    height="60"
                    />
            </a>

            <!--search-->
            <form class="d-flex" role="search" action="search" method="get">
                <div class="search-box-wrapper">
                    <input
                        class="form-control rounded-pill search-box"
                        type="search"
                        name="query"
                        placeholder="Tìm kiếm phim, diễn viên"
                        aria-label="Search"
                        />
                    <i class="fa-solid fa-magnifying-glass search-icon"></i>
                </div>
            </form>

            <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
                >
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-5">
                    <li class="nav-item"><a class="nav-link" href="Main.html">Trang chủ</a></li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#">Thể loại</a>
                        <ul class="dropdown-menu multi-column">
                            <c:forEach var="cat" items="${listCategory}">
                                <li>
                                    <a class="dropdown-item
                                       ${cat.category_id == selectedCategory ? 'active' : ''}"
                                       href="series?action=filterByCategory&categoryId=${cat.category_id}">
                                        ${cat.name}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>

                    <li class="nav-item"><a class="nav-link" href="#">Phim bộ</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Phim lẻ</a></li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button">
                            Quốc gia
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Việt Nam</a></li>
                            <li><a class="dropdown-item" href="#">Hàn Quốc</a></li>
                            <li><a class="dropdown-item" href="#">Mỹ</a></li>
                            <li><a class="dropdown-item" href="#">Nhật Bản</a></li>
                            <li><a class="dropdown-item" href="#">Trung Quốc</a></li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">Lịch chiếu</a>
                    </li>
                </ul>
            </div>

            <!-- Kiểm tra đăng nhập -->
            <c:choose>
                <c:when test="${empty sessionScope.guest}">
                    <!-- Nếu chưa đăng nhập -->
                    <a href="${pageContext.request.contextPath}/user?action=sendLogin" class="btn login-btn">
                        <i class="fa-solid fa-user me-2"></i> Đăng nhập
                    </a>
                </c:when>

                <c:otherwise>
                    <!-- Nếu đã đăng nhập -->
                    <div class="dropdown d-flex align-items-center">


                        <!-- Nút Quyền Admin -->
                        <c:if test="${sessionScope.guest.user_level eq 'Admin'}">
                            <a href="${pageContext.request.contextPath}/admin?action=sendAccountDashboard"
                               class="btn btn-warning me-3 fw-bold">
                                <i class="fa-solid fa-user-shield me-2"></i> Quyền Admin
                            </a>
                        </c:if>
                        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userMenu"
                           data-bs-toggle="dropdown" aria-expanded="false">

                            <!-- Hiển thị avatar -->
                            <img src="${pageContext.request.contextPath}/${sessionScope.guest.avatar_url}"
                                 alt="Avatar"
                                 class="rounded-circle me-2"
                                 width="45" height="45"
                                 onerror="this.src='${pageContext.request.contextPath}/Images/default-avatar.png'">

                            <!-- Hiển thị tên người dùng -->
                            <span class="text-white fw-bold">${sessionScope.guest.username}</span>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userMenu">
                            <li><a class="dropdown-item" href="profile.jsp">Trang cá nhân</a></li>
                            <li><a class="dropdown-item" href="#">Danh sách phim của tôi</a></li>
                            <li><a class="dropdown-item" href="updateAvatar.jsp">Update avatar</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/user?action=logout">
                                    <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:otherwise>

            </c:choose>

        </div>
    </nav>
    <style>
        .navbar img.rounded-circle {
            object-fit: cover;
            border: 2px solid #fff;
            transition: transform 0.2s ease;
        }

        .navbar img.rounded-circle:hover {
            transform: scale(1.1);
        }

    </style>
</header>
