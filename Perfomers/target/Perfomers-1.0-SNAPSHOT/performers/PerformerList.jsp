<%-- 
Document   : PerformerDetail.
Created on : Oct 8, 2025, 9:15:17 PM
Author     : Vo Thi Phi Yen - CE190428
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Actors</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
        <link href="../css/performerlist.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <main class="container py-5">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4">
                <h1 class="fw-bold display-6 mb-3 mb-md-0">Actors</h1>  </div>

            <div id="actorList" class="d-flex flex-wrap gap-4" style="min-height: 400px">
                <c:forEach var="p" items="${performers}">
                    <article class="actor-card text-center" data-name="${p.name}">
                        <img src="${pageContext.request.contextPath}/${p.photoUrl}" alt="${p.name}">

                        <a href="${pageContext.request.contextPath}/performer/info?id=${p.performerID}"

                           class="actor-name d-block mt-2">${p.name}</a>
                    </article>
                </c:forEach>
            </div>
            <!-- Pagination -->
            <nav aria-label="Page navigation" class="mt-5">
                <ul class="pagination justify-content-center">

                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link bg-dark text-white border-secondary"
                           href="${pageContext.request.contextPath}/performer/list?page=${currentPage - 1}"
                           aria-label="Previous">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>


                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link bg-dark text-white border-secondary"
                               href="${pageContext.request.contextPath}/performer/list?page=${i}">${i}</a>
                        </li>
                    </c:forEach>


                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link bg-dark text-white border-secondary"
                           href="${pageContext.request.contextPath}/performer/list?page=${currentPage + 1}"
                           aria-label="Next">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>

                </ul>
            </nav>

        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
