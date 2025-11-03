<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h2>Danh sách tập phim</h2>
<table class="table">
    <tr>
        <th>Tập</th>
        <th>Tiêu đề</th>
        <th>Ngày chiếu</th>
        <th>Giờ chiếu</th>
        <th>Trạng thái</th>
    </tr>
    <c:forEach var="ep" items="${episodes}">
        <tr>
            <td>${ep.episodeNumber}</td>
            <td>${ep.title}</td>
            <td>
                <c:choose>
                    <c:when test="${ep.releaseDate != null}">
                        ${ep.releaseDate}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
            <td>${ep.releaseTime}</td>

            <!-- Hiển thị trạng thái: đã chiếu hoặc sắp chiếu -->
            <td>
                <c:choose>
                    <c:when test="${ep.releaseDate != null && ep.releaseDate <= now}">
                        Đã chiếu
                    </c:when>
                    <c:otherwise>Sắp chiếu</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>
