<%-- 
    Document   : WishList.jsp
    Created on : Oct 14, 2025, 12:10:51 PM
    Author     : Chau Tan Cuong - CE190026
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    />
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    />

<!-- Custom CSS -->
<link href="css/WishList.css" rel="stylesheet" type="text/css"/>
</head>

<body>
    <!-- Header -->
    <div id="header-placeholder"></div>

    <!-- Page Content -->
    <div class="container py-5">
        <div class="account-wrapper">
            <div class="account-container d-flex">
                <!-- Sidebar -->
                <aside class="sidebar p-3">
                    <h3>Quản lí tài khoản</h3>
                    <ul>
                        <li class="active" onclick="window.location.href = 'WatchList.html'">
                            <i class="fa-solid fa-plus"></i> Watch List
                        </li>
                    </ul>
                </aside>

                <!-- Watch List Content -->
                <main class="account-info flex-grow-1 p-3">
                    <h2>Watch List</h2>
                    <div class="d-flex flex-wrap gap-4">
                        <c:forEach var="m" items="${favorites}">
                            <div class="movie-card text-center">
                                <a href="series?action=sendMovieInfo&id=${m.seriesID}">
                                    <img
                                        src="${m.posteUrl}"
                                        alt="${m.title}"
                                        class="img-fluid rounded"
                                        style="max-width: 180px"
                                        />
                                </a>
                                <a href="series?action=sendMovieInfo&id=${m.seriesID}">
                                    <p>${m.title}</p>
                                </a> 
                                <br>
                                <!-- Nút xóa -->
                                <a href="wishlist?action=removeFilmInFavorite&seriesId=${m.seriesID}"
                                   class="btn btn-sm btn-danger mt-2"
                                   onclick="return confirm('Bạn có chắc muốn xóa phim này khỏi danh sách yêu thích không?');">
                                    <i class="bi bi-trash"></i> Xóa
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="mb-0">Watch List</h2>
                        <a href="${pageContext.request.contextPath}/series?action=allOfSeries" class="btn btn-exit">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp; Trở về
                        </a>
                    </div>
                </main>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container text-center small">
            © 2025 MovieWeb. All Rights Reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>