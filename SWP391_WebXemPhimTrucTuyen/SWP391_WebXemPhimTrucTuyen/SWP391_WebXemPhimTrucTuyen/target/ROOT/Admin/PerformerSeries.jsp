<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Manage Series Performers</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
        <link href="../css/managementseries.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/admin/performer" class="text-secondary text-decoration-none mb-4 d-inline-block">
            <i class="bi bi-arrow-left"></i> Quay Lại
        </a>
        <div class="series-select">
            <form method="get" action="${pageContext.request.contextPath}/performer/series">

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

                <div class="series-column">
                    <c:forEach var="s" items="${seriesList}">
                        <c:if test="${s.seriesID == selectedSeriesId}">
                            <img src="${s.posteUrl}" alt="${s.title}"/>
                        </c:if>
                    </c:forEach>
                </div>

                <div class="performers-column">
                    <div class="add-performer">
                        <form method="post" action="${pageContext.request.contextPath}/performer/series">
                            <input type="hidden" name="seriesId" value="${selectedSeriesId}" />
                            <select id="performerDropdown" name="performerId">
                                <option value="" disabled selected>--Choose Performer--</option>
                                <c:forEach var="p" items="${performerList}">

                                    <option value="${p.performerID}">${p.name}</option>
                                </c:forEach>
                            </select>
                            <button type="submit" name="action" value="add">Add</button>
                        </form>
                    </div>


                    <div class="performers-grid">
                        <c:forEach var="p" items="${assignedPerformers}">
                            <div class="performer-card">
                                <img src="${pageContext.request.contextPath}/${p.photoUrl}" alt="${p.name}"/>
                                <h4>${p.name}</h4>
                                <form method="post" action="${pageContext.request.contextPath}/performer/series">
                                    <input type="hidden" name="seriesId" value="${selectedSeriesId}"/>
                                    <input type="hidden" name="performerId" value="${p.performerID}"/>
                                    <button type="submit" name="action" value="remove">Remove</button>
                                </form>
                            </div>
                        </c:forEach>

                        <c:if test="${empty assignedPerformers}">
                            <p style="color:#999;">No performers assigned yet.</p>
                        </c:if>
                    </div>

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
