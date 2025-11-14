<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
    <head>
        <title>Manage Series Performers</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
 
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #0b0b0b;
                color: #fff;
                margin: 0;
                padding: 24px;
            }
            a {
                color: #e50914;
                text-decoration: none;
                transition: color 0.3s;
            }
            a:hover {
                color: #f40612;
            }

            .back-btn {
                font-size: 15px;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                margin-left: 10px;
                margin-bottom: 20px;
                color: #888;
            }

            .series-select {
                margin-left: 10px;
                margin-bottom: 30px;
            }
            .series-select form {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .series-select select {
                padding: 6px 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
                min-width: 200px;
                background-color: #1c1c1c;
                color: #fff;
                cursor: pointer;
                transition: background 0.3s;
            }
            .series-select select:hover {
                background-color: #292929;
            }

            .container-flex {
                display: flex;
                gap: 40px;
                margin-left: 10px;
            }

            .series-column {
                width: 250px;
            }
            .series-column img {
                width: 100%;
                border-radius: 10px;
            }

            .performers-column {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 40px;
            }

            .add-performer {
                display: flex;
                gap: 12px;
                align-items: center;
                background-color: #141414;
                padding: 14px 18px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.5);
            }
            .add-performer select, .add-performer button {
                padding: 10px 14px;
                border-radius: 8px;
                border: none;
                font-size: 15px;
            }
            .add-performer select {
                flex: 1;
                background-color: #1f1f1f;
                color: #fff;
            }
            .add-performer button {
                background: linear-gradient(135deg, #e50914, #b0060f);
                color: #fff;
                cursor: pointer;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: transform 0.2s, background 0.3s;
            }
            .add-performer button:hover {
                background: linear-gradient(135deg, #f40612, #b81d24);
                transform: scale(1.05);
            }

            .performers-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
                gap: 20px;
            }
            .performer-card {
                background-color: #141414;
                border-radius: 12px;
                overflow: hidden;
                text-align: center;
                box-shadow: 0 4px 16px rgba(0,0,0,0.6);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .performer-card img {
                width: 100%;
                height: 160px;
                object-fit: cover;
                border-radius: 8px;
                transition: transform 0.3s;
            }
            .performer-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.7);
            }
            .performer-card:hover img {
                transform: scale(1.05);
            }
            .performer-card h4 {
                margin: 10px 0;
                font-size: 15px;
                font-weight: 500;
                color: #fff;
            }
            .performer-card button {
                background: linear-gradient(135deg, #e50914, #b0060f);
                border: none;
                padding: 6px 12px;
                color: #fff;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                transition: transform 0.3s, background 0.3s;
            }
            .performer-card button:hover {
                background: linear-gradient(135deg, #f40612, #b81d24);
                transform: scale(1.08);
            }

            .performers-grid p {
                grid-column: 1 / -1;
                text-align: center;
                color: #999;
                font-size: 15px;
            }

            .pagination {
                display: flex;
                gap: 10px;
                justify-content: center;
                margin-top: 20px;
            }
            .pagination a {
                padding: 6px 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                text-decoration: none;
                color: #333;
                transition: background 0.3s, transform 0.2s;
            }
            .pagination a.active, .pagination a:hover {
                background: #007bff;
                color: white;
                transform: scale(1.05);
            }

            .toast-bg-success {
                background-color: #198754 !important;
            }
            .toast-bg-danger {
                background-color: #dc3545 !important;
            }
        </style>
    </head>
    <body>

        <!-- Back button -->
        <a href="${pageContext.request.contextPath}/admin/performer" class="back-btn">
            <i class="bi bi-arrow-left"></i> Quay Lại
        </a>

        <!-- Series select -->
        <div class="series-select">
            <form method="get" action="${pageContext.request.contextPath}/performer/series">
                <label>Chọn Series:</label>
                <select name="seriesId" onchange="this.form.submit()">
                    <option value="" disabled selected>--Chọn Series--</option>
                    <c:forEach var="s" items="${seriesList}">
                        <option value="${s.seriesID}" <c:if test="${s.seriesID == selectedSeriesId}">selected</c:if>>
                            ${s.title}
                        </option>
                    </c:forEach>
                </select>
            </form>
        </div>

        <c:if test="${not empty selectedSeriesId}">
            <div class="container-flex">
                <!-- Poster -->
                <div class="series-column">
                    <c:forEach var="s" items="${seriesList}">
                        <c:if test="${s.seriesID == selectedSeriesId}">
                            <img src="${s.posteUrl}" alt="${s.title}">
                        </c:if>
                    </c:forEach>
                </div>

                <!-- Performers -->
                <div class="performers-column">
                    <!-- Add -->
                    <div class="add-performer">
                        <form method="post" action="${pageContext.request.contextPath}/performer/series">
                            <input type="hidden" name="seriesId" value="${selectedSeriesId}" />
                            <select name="performerId">
                                <option value="" disabled selected>--Choose Performer--</option>
                                <c:forEach var="p" items="${performerList}">
                                    <option value="${p.performerID}">${p.name}</option>
                                </c:forEach>
                            </select>
                            <button type="submit" name="action" value="add">Thêm</button>
                        </form>
                    </div>

                    <!-- Performer cards -->
                    <div class="performers-grid">
                        <c:forEach var="p" items="${assignedPerformers}">
                            <div class="performer-card">
                                <img src="${pageContext.request.contextPath}/${p.photoUrl}" alt="${p.name}">
                                <h4>${p.name}</h4>
                                <form method="post" action="${pageContext.request.contextPath}/performer/series">
                                    <input type="hidden" name="seriesId" value="${selectedSeriesId}">
                                    <input type="hidden" name="performerId" value="${p.performerID}">
                                    <button type="submit" name="action" value="remove">Xóa</button>
                                </form>
                            </div>
                        </c:forEach>

                        <c:if test="${empty assignedPerformers}">
                            <p>Chưa có diễn viên nào.</p>
                        </c:if>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <a href="${pageContext.request.contextPath}/performer/series?seriesId=${selectedSeriesId}&page=${i}"
                                   class="<c:if test='${i == currentPage}'>active</c:if>">${i}</a>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>

        <!-- Toast -->
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 9999">
            <div id="toastMessage" class="toast align-items-center text-white border-0" role="alert">
                <div class="d-flex">
                    <div id="toastText" class="toast-body"></div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto"
                            data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

        <script>
            function showToast(message, type) {
                const toastEl = document.getElementById('toastMessage');
                const toastText = document.getElementById('toastText');

                toastEl.classList.remove("toast-bg-success", "toast-bg-danger");
                toastEl.classList.add(type === "success" ? "toast-bg-success" : "toast-bg-danger");

                toastText.innerText = message;
                const toast = new bootstrap.Toast(toastEl, {delay: 2500});
                toast.show();
            }
        </script>

        <!-- Auto show toast from session -->
        <c:if test="${not empty sessionScope.toastMessage}">
            <script>showToast("${sessionScope.toastMessage}", "${sessionScope.toastType}");</script>
            <c:remove var="toastMessage" scope="session"/>
            <c:remove var="toastType" scope="session"/>
        </c:if>

    </body>
</html>
