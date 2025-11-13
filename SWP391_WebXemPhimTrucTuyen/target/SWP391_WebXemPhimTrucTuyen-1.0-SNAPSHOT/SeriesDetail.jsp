<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.Episode, java.util.List" %>
<%
    entity.Series series = (entity.Series) request.getAttribute("series");
    List<Episode> episodes = (List<Episode>) request.getAttribute("episodes");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= series.getTitle() %> - Danh sách tập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light">
<div class="container mt-5">
    <h2><%= series.getTitle() %></h2>
    <p><%= series.getDescription() %></p>

    <div class="ratio ratio-16x9 mb-4">
        <iframe id="videoPlayer" src="<%= episodes.isEmpty() ? "" : episodes.get(0).getEpisodeUrl() %>" allowfullscreen></iframe>
    </div>

    <h4>Danh sách tập</h4>
    <ul class="list-group">
        <% for (Episode ep : episodes) { %>
        <li class="list-group-item bg-dark text-light d-flex justify-content-between align-items-center">
                <span>
                    <strong>Tập <%= ep.getEpisodeNumber() %>:</strong> <%= ep.getEpisodeTitle() %>
                </span>
            <button class="btn btn-outline-info btn-sm"
                    onclick="document.getElementById('videoPlayer').src='<%= ep.getEpisodeUrl() %>'">
                Xem
            </button>
        </li>
        <% } %>
    </ul>
</div>
</body>
</html>
