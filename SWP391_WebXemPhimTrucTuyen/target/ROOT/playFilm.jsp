<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, entity.Episode, entity.Series" %>

<%
    Series movie = (Series) request.getAttribute("movie");
    String filmUrl = (String) request.getAttribute("filmUrl");
    List<Episode> episodes = (List<entity.Episode>) request.getAttribute("episodes");
    entity.Episode currentEpisode = (entity.Episode) request.getAttribute("currentEpisode");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xem phim - <%= movie != null ? movie.getTitle() : "" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #111;
            color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: #1c1c1c;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px #000;
        }
        h2, h4 {
            text-align: center;
            color: #fff;
        }
        video {
            width: 100%;
            border-radius: 10px;
            margin: 20px 0;
            outline: none;
        }
        .episode-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
        }
        .episode-btn {
            padding: 10px 16px;
            background: #333;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: 0.2s;
        }
        .episode-btn:hover, .episode-btn.active {
            background: #ff4b2b;
            color: white;
        }
        .back-btn {
            display: inline-block;
            color: #ccc;
            margin-bottom: 10px;
            text-decoration: none;
        }
        .back-btn:hover {
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <a href="home" class="back-btn">← Quay lại trang chủ</a>

    <h2><%= movie != null ? movie.getTitle() : "" %></h2>

    <%
        if (movie.getTypeId() == 1) {
            // Phim lẻ
    %>
    <video controls poster="<%= movie.getPosteUrl() %>">
        <source src="<%= request.getContextPath() %>/film?id=<%= movie.getSeriesID() %>" type="video/mp4">
    </video>

    <%
    } else {
        // Phim bộ
        if (currentEpisode != null) {
    %>
    <h4>Tập hiện tại: <%= currentEpisode.getEpisodeTitle() %></h4>

    <video controls poster="<%= movie.getPosteUrl() %>">
        <source src="<%= request.getContextPath() %>/film?id=<%= currentEpisode.getEpisodeId() %>" type="video/mp4">
    </video>

    <h5 class="text-center mt-3 mb-2">Danh sách tập:</h5>
    <div class="episode-list">
        <% for (entity.Episode ep : episodes) { %>
        <a class="episode-btn <%= (currentEpisode.getEpisodeId() == ep.getEpisodeId()) ? "active" : "" %>"
           href="playFilm?seriesId=<%= movie.getSeriesID() %>&epId=<%= ep.getEpisodeId() %>">
            <%= ep.getEpisodeTitle() %>
        </a>
        <% } %>
    </div>
    <%
            } else {
                out.print("<p class='text-center text-danger'>Không có tập nào!</p>");
            }
        }
    %>
</div>

</body>
</html>
