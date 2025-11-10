<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${movie.title}</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MovieWatching.css"/>
</head>

<body>

<!-- Header -->

<!-- Khung xem phim -->
<div class="watching-section">
    <div class="container">
        <div class="watching-frame">
            <video id="player" src="${pageContext.request.contextPath}/Images/demo.mp4"></video>

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
            <h1>${movie.title}</h1>
            <p>${movie.original}</p>
        </div>
    </div>
</div>

<!-- Thông tin phim -->
<div class="container mt-4">
    <div class="Movie-Poster">
        <img src="${pageContext.request.contextPath}/Images/Banner.jpg" alt="Poster phim"/>
    </div>

    <div class="Movie-des">
        <p>${movie.story}</p>
    </div>
</div>

<!-- Playlist -->
<div class="container mt-4">
    <div class="playlist">
        <p class="playlist-title">Danh sách tập</p>

        <div class="playlist-grid">
            <c:forEach var="ep" items="${episodes}" varStatus="loop">
                <div class="playlist-item ${loop.first ? 'active' : ''}">
                    ${ep.number}
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Comment section -->
<div class="container mt-5">
    <div class="comment-section">
        <h3 class="comment-title">Bình luận</h3>

        <div class="comment-form">
            <textarea class="comment-input" placeholder="Nhập bình luận của bạn..."></textarea>
            <button class="comment-btn">Gửi</button>
        </div>

        <!-- Render comment từ backend -->
        <c:forEach var="cmt" items="${comments}">
            <div class="comment-item">
                <div class="comment-user">${cmt.userName}</div>
                <div class="comment-text">${cmt.content}</div>
                <div class="comment-time">${cmt.time}</div>
            </div>
        </c:forEach>

    </div>
    <div class="side-ad">
        <p>QC: Banner 30s</p>
    </div>
</div>

<!-- Phim Tương Tự -->
<div class="container mt-5">
    <div class="col-12">
        <div class="Title"><h2>Phim Tương Tự</h2></div>

        <div class="Tuong-Tu">
            <a href="#"><img src="${pageContext.request.contextPath}/Images/Banner1.jpg"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/Images/Banner2.jpg"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/Images/Banner3.jpg"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/Images/Banner1.jpg"></a>
        </div>
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

    centerPlay.addEventListener("click", () => {
        overlay.style.display = "none";
        video.play();
        playPause.className = "fa-solid fa-pause";
    });

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
