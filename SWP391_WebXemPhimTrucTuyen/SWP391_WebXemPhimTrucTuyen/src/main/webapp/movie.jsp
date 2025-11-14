<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>TV Shows</title>
        <!-- Bootstrap & Icons -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
            />
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/Header.css" />
        <link rel="stylesheet" href="css/footer.css" />
        <link rel="stylesheet" href="css/series.css" />
    </head>

    <body class="bg-dark text-white">
        <!-- Header -->
        <jsp:include page="/include/Header.jsp" />


        <!-- Banner -->
        <section
            id="banner"
            class="banner d-flex align-items-center justify-content-center mt-5"
            >
            <div class="banner-overlay text-center">
                <h2 id="banner-title" class="fw-bold"></h2>
                <p id="banner-desc" class="mb-0"></p>
            </div>
        </section>

        <!-- Main Content -->
        <main class="container py-4">
            <!-- Filter Button -->
            <div class="mb-4 d-flex justify-content-between align-items-center">
                <h1 class="text-white fw-bold display-4 mb-0">Movies</h1>
              
            </div>
            <c:if test="${not empty searchQuery}">
                <h2 class="text-warning">Kết quả tìm kiếm cho: "${searchQuery}"</h2>
                <c:if test="${empty listSeries}">
                    <p class="text-light">Không tìm thấy phim nào phù hợp.</p>
                </c:if>
            </c:if>


            <!-- Movie List -->
            <div class="movie-row d-flex flex-nowrap overflow-auto gap-3 pb-3">
                <!-- Movie Card -->
                <c:forEach var="s" items="${listSeries}">
                    <article class="movie-card bg-dark border-0 text-center">
                        <div class="position-relative" style="width: 160px">
                            <a href="series?action=sendMovieInfo&id=${s.seriesID}">
                                <img src="${s.posteUrl}" class="card-img-top" alt="${s.title}" />
                            </a>
                        </div>
                        <div class="card-body p-2">
                            <a href="series?action=sendMovieInfo&id=${s.seriesID}"
                               class="text-light"
                               style="text-decoration: none">
                                ${s.title}
                            </a>
                        </div>
                    </article>
                </c:forEach>


            </div>


            <!-- Pagination -->
            <div class="d-flex justify-content-center my-4">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link bg-dark text-white border-secondary"
                                   href="series?action=allOfSeries&page=${currentPage - 1}">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <li class="page-item ${p == currentPage ? 'active' : ''}">
                                <a class="page-link ${p == currentPage ? 'bg-warning text-dark border-warning' : 'bg-dark text-white border-secondary'}"
                                   href="series?action=allOfSeries&page=${p}">
                                        ${p}
                                </a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link bg-dark text-white border-secondary"
                                   href="series?action=allOfSeries&page=${currentPage + 1}">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>

        </main>

        <!-- Footer -->
        <footer>
            <div id="footer-placeholder"></div>
        </footer>

        <!-- JS -->
        <script>


            // Filter toggle
            const toggleBtn = document.getElementById("toggleFilter");
            const closeBtn = document.getElementById("closeFilter");
            const filterPanel = document.getElementById("filterPanel");

            toggleBtn.addEventListener("click", () => {
                filterPanel.classList.toggle("d-none");
            });

            closeBtn.addEventListener("click", () => {
                filterPanel.classList.add("d-none");
            });
        </script>
        <script src="${pageContext.request.contextPath}/js/banner.js"></script>
        <script src="${pageContext.request.contextPath}/js/ViewMovieBanner.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
