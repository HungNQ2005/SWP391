<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, entity.Episode, entity.Series" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Series movie = (Series) request.getAttribute("movie");
    List<Episode> episodes = (List<entity.Episode>) request.getAttribute("episodes");
    entity.Episode currentEpisode = (entity.Episode) request.getAttribute("currentEpisode");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title><%= movie != null ? movie.getTitle() : "Xem phim"%></title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MovieWatching.css"/>
        <style>
            /* Giữ phòng khi CSS ngoài chưa load */
            body {
                background-color: #111;
                color: #eee;
                font-family: Arial, sans-serif;
            }
            .playlist-grid a {
                color: white;
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 6px;
                background: #333;
            }
            .playlist-grid a.active {
                background: #ff4b2b;
            }
        </style>
    </head>

    <body>

        <!-- Khung xem phim -->
        <div class="watching-section">
            <div class="container">
                <div class="watching-frame">
                    <% if (movie != null) { %>
                    <% if (movie.getTypeId() == 1) {%>
                    <!-- Phim lẻ -->
                    <video id="player" controls poster="<%= movie.getPosteUrl()%>">
                        <source src="<%= request.getContextPath()%>/film?id=<%= movie.getSeriesID()%>" type="video/mp4">
                    </video>
                    <% } else if (currentEpisode != null) {%>
                    <!-- Phim bộ -->
                    <video id="player" controls poster="<%= movie.getPosteUrl()%>">
                        <source src="<%= request.getContextPath()%>/film?id=<%= currentEpisode.getEpisodeId()%>" type="video/mp4">
                    </video>
                    <% } else { %>
                    <p class="text-center text-danger">Không có tập nào!</p>
                    <% } %>
                    <% }%>

                    <div class="overlay">
                        <button class="center-play"><i class="fa-solid fa-circle-play"></i></button>
                    </div>

                    <div class="controls">
                        <button class="play-pause"><i class="fa-solid fa-play"></i></button>
                        <input type="range" class="progress" value="0" max="100"/>

                        <div class="right-controls">
                            <button class="volume"><i class="fa-solid fa-volume-high"></i></button>
                            <button class="fullscreen"><i class="fa-solid fa-expand"></i></button>
                        </div>
                    </div>
                </div>

                <!-- Quảng cáo -->
                <div class="overlay-ad">
                    <p>QC: Banner 30s</p>
                </div>
            </div>

            <!-- Tiêu đề phim -->
            <div class="Movie-inf">
                <div class="Movie-Title">
                    <h1><%= movie != null ? movie.getTitle() : ""%></h1>
                    <p><%= movie != null ? movie.getDescription() : ""%></p>
                </div>
            </div>
        </div>

        <!-- Thông tin phim -->
        <div class="container mt-4">
            <div class="Movie-Poster">
                <img src="<%= movie != null ? movie.getPosteUrl() : ""%>" alt="Poster phim"/>
            </div>

            <div class="Movie-des">
                <p><%= movie != null ? movie.getDescription() : ""%></p>
            </div>
        </div>

        <!-- Playlist -->
        <div class="container mt-4">
            <div class="playlist">
                <p class="playlist-title">Danh sách tập</p>
                <div class="playlist-grid">
                    <% if (movie != null && movie.getTypeId() != 1 && episodes != null) { %>
                    <% for (entity.Episode ep : episodes) {%>
                    <a class="<%= (currentEpisode != null && currentEpisode.getEpisodeId() == ep.getEpisodeId()) ? "active" : ""%>"
                       href="playFilm?seriesId=<%= movie.getSeriesID()%>&epId=<%= ep.getEpisodeId()%>">
                        <%= ep.getEpisodeTitle()%>
                    </a>
                    <% } %>
                    <% }%>
                </div>
            </div>
        </div>

        <!-- Comment section -->
        <div class="container mt-5">
            <div class="side-ad">
                <p>QC: Banner 30s</p>
            </div>
        </div>



        <script>
            const video = document.getElementById("player");
            const playPause = document.querySelector(".play-pause i");
            const progress = document.querySelector(".progress");
            const volume = document.querySelector(".volume i");
            const fullscreen = document.querySelector(".fullscreen i");
            const overlay = document.querySelector(".overlay");
            const centerPlay = document.querySelector(".center-play i");

            if (centerPlay) {
                centerPlay.addEventListener("click", () => {
                    overlay.style.display = "none";
                    video.play();
                    playPause.className = "fa-solid fa-pause";
                });
            }

            document.querySelector(".play-pause").addEventListener("click", () => {
                if (video.paused) {
                    video.play();
                    playPause.className = "fa-solid fa-pause";
                } else {
                    video.pause();
                    playPause.className = "fa-solid fa-play";
                }
            });

            video.addEventListener("timeupdate", () => {
                progress.value = (video.currentTime / video.duration) * 100;
            });

            progress.addEventListener("input", () => {
                video.currentTime = (progress.value / 100) * video.duration;
            });

            document.querySelector(".volume").addEventListener("click", () => {
                video.muted = !video.muted;
                volume.className = video.muted ? "fa-solid fa-volume-xmark" : "fa-solid fa-volume-high";
            });

            document.querySelector(".fullscreen").addEventListener("click", () => {
                if (!document.fullscreenElement) {
                    video.requestFullscreen();
                } else {
                    document.exitFullscreen();
                }
            });
        </script>

    </body>
</html>

