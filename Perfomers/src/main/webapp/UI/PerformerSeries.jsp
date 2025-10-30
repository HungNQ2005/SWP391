<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Manage Series Performers</title>
        <style>
            body {
                font-family: 'Poppins', 'Helvetica Neue', Helvetica, Arial, sans-serif;
                background-color: #0b0b0b;
                color: #fff;
                margin: 0;
                padding: 0;
            }

            a {
                color: #e50914;
                text-decoration: none;
                transition: color 0.3s;
            }

            a:hover {
                color: #f40612;
            }

            .container {
                display: flex;
                padding: 40px 60px;
                gap: 40px;
                flex-wrap: wrap;
            }

            /* Series Poster */
            .series-column {
                width: 280px;
                flex-shrink: 0;
                margin-top: 6%;
            }

            .series-column img {
                width: 100%;
                border-radius: 14px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.7);
                transition: transform 0.4s ease;
            }

            .series-column img:hover {
                transform: scale(1.03);
            }

            /* Performers Column */
            .performers-column {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 40px;
            }

            /* Add Performer */
            .add-performer {
                display: flex;
                gap: 12px;
                align-items: center;
                background-color: #141414;
                padding: 14px 18px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.5);
            }

            .add-performer input,
            .add-performer select,
            .add-performer button {
                padding: 10px 14px;
                border-radius: 8px;
                border: none;
                font-size: 15px;
            }

            .add-performer input,
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

            /* Performers Grid */
            .performers-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                gap: 20px;
            }

            .performer-card {
                background-color: #141414;
                border-radius: 12px;
                overflow: hidden;
                text-align: center;
                box-shadow: 0 4px 16px rgba(0,0,0,0.6);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                position: relative;
            }

            .performer-card img {
                width: 100%;
                height: 240px;
                object-fit: cover;
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
                margin: 12px 0 6px;
                font-size: 16px;
                font-weight: 600;
                color: #fff;
            }

            .performer-card button {
                background: linear-gradient(135deg, #e50914, #b0060f);
                border: none;
                padding: 8px 18px;
                color: #fff;
                border-radius: 6px;
                cursor: pointer;
                margin-bottom: 12px;
                font-size: 14px;
                font-weight: 500;
                transition: transform 0.3s, background 0.3s;
            }

            .performer-card button:hover {
                background: linear-gradient(135deg, #f40612, #b81d24);
                transform: scale(1.08);
            }

            /* Empty message */
            .performers-grid p {
                grid-column: 1 / -1;
                text-align: center;
                color: #888;
                font-size: 15px;
            }

            /* Pagination */
            .pagination {
                display: flex;
                gap: 10px;
                justify-content: center;
                margin-top: 10px;
            }

            .pagination a {
                padding: 8px 14px;
                background: #1f1f1f;
                color: #fff;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                transition: background 0.3s, transform 0.2s;
            }

            .pagination a.active, .pagination a:hover {
                background: #e50914;
                transform: scale(1.05);
            }

            /* Series Select */
            .series-select {
                padding: 25px 60px 0;
                background-color: #0f0f0f;
            }

            .series-select select {
                padding: 10px 14px;
                border-radius: 8px;
                border: none;
                font-size: 15px;
                background-color: #1c1c1c;
                color: #fff;
                cursor: pointer;
                transition: background 0.3s;
            }

            .series-select select:hover {
                background-color: #292929;
            }


        </style>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    </head>
    <body>
        <a href="performersadmin" class="text-secondary text-decoration-none mb-4 d-inline-block">
            <i class="bi bi-arrow-left"></i> Back to list
        </a>
        <div class="series-select">
            <form method="get" action="performerseries">
                <label>Select Series: </label>
                <select name="seriesId" onchange="this.form.submit()">
                    <option value="" disabled selected>--Choose Series--</option>
                    <c:forEach var="s" items="${seriesList}">
                        <option value="${s.seriesID}" <c:if test="${s.seriesID == selectedSeriesId}">selected</c:if>>
                            ${s.title}
                        </option>
                    </c:forEach>
                </select>
            </form>
        </div>

        <c:if test="${not empty selectedSeriesId}">
            <div class="container">
                <!-- Series Poster -->
                <div class="series-column">
                    <c:forEach var="s" items="${seriesList}">
                        <c:if test="${s.seriesID == selectedSeriesId}">
                            <img src="${s.posteUrl}" alt="${s.title}"/>
                        </c:if>
                    </c:forEach>
                </div>

                <!-- Performers Column -->
                <div class="performers-column">
                    <!-- Add Performer -->
                    <div class="add-performer">
                        <form method="post" action="performerseries">
                            <input type="hidden" name="seriesId" value="${selectedSeriesId}" />
                            <input type="text" id="performerSearch" onkeyup="filterPerformers()" placeholder="Search performer..." />
                            <select id="performerDropdown" name="performerId">
                                <c:forEach var="p" items="${performerList}">
                                    <option value="${p.performer_id}">${p.name}</option>
                                </c:forEach>
                            </select>
                            <button type="submit" name="action" value="add">Add</button>
                        </form>
                    </div>

                    <!-- Assigned Performers Grid -->
                    <div class="performers-grid">
                        <c:forEach var="p" items="${assignedPerformers}">
                            <div class="performer-card">
                                <img src="${p.photo_url}" alt="${p.name}"/>
                                <h4>${p.name}</h4>
                                <form method="post" action="performerseries">
                                    <input type="hidden" name="seriesId" value="${selectedSeriesId}"/>
                                    <input type="hidden" name="performerId" value="${p.performer_id}"/>
                                    <button type="submit" name="action" value="remove">Remove</button>
                                </form>
                            </div>
                        </c:forEach>

                        <c:if test="${empty assignedPerformers}">
                            <p style="color:#999;">No performers assigned yet.</p>
                        </c:if>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <a href="performerseries?seriesId=${selectedSeriesId}&page=${i}"
                                   class="<c:if test='${i == currentPage}'>active</c:if>">${i}</a>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
        <script>
            function filterPerformers() {
                let input = document.getElementById("performerSearch").value.toLowerCase();
                let options = document.getElementById("performerDropdown").options;
                for (let i = 0; i < options.length; i++) {
                    options[i].style.display = options[i].text.toLowerCase().includes(input) ? '' : 'none';
                }
            }
        </script>
    </body>
</html>
