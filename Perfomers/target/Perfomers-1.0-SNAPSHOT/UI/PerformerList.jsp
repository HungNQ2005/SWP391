<%-- 
    Document   : PerformerList.jsp
    Created on : Oct 7, 2025, 1:45:10 PM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Actors</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
            />
        <link href="http://localhost:8080/Perfomers/asset/css/PerformerList.css" rel="stylesheet" type="text/css"/>
    <body>
        <main class="container py-5">
            <div
                class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4"
                >
                <h1 class="fw-bold display-6 mb-3 mb-md-0">Actors</h1>

                <div class="input-group search-bar">
                    <input
                        type="text"
                        id="searchInput"
                        class="form-control bg-dark text-light border-danger"
                        placeholder="Search actor name..."
                        />
                    <span class="input-group-text bg-danger border-0">
                        <i class="bi bi-search"></i>
                    </span>
                </div>
            </div>
            <!-- Actor List -->
            <div
                id="actorList"
                class="d-flex flex-wrap gap-4"
                style="min-height: 400px"
                >
                <c:forEach var="p" items="${performers}">
                    <article class="actor-card text-center" data-name="${p.name}">
                        <img
                            src="${p.photo_url}"
                            alt="${p.name}"
                            />
                        <a href="${pageContext.request.contextPath}/performerInformation?id=${p.performer_id}"
                           class="actor-name d-block mt-2">${p.name}</a>

                    </article>
                </c:forEach>
            </div>

            <nav aria-label="Page navigation" class="mt-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item">
                        <a class="page-link bg-dark text-white border-secondary" href="#" aria-label="Previous">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>
                    <li class="page-item active">
                        <span class="page-link bg-secondary border-secondary">1</span>
                    </li>
                    <li class="page-item">
                        <a class="page-link bg-dark text-white border-secondary" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link bg-dark text-white border-secondary" href="#">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link bg-dark text-white border-secondary" href="#" aria-label="Next">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </main>

        <script>
            document.getElementById("searchInput").addEventListener("keyup", function () {
                const query = this.value.toLowerCase();
                const actors = document.querySelectorAll("#actorList .actor-card");

                actors.forEach((actor) => {
                    const name = actor.dataset.name.toLowerCase();
                    actor.style.display = name.includes(query) ? "block" : "none";
                });
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
