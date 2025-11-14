<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Trang Phim Gì Đó</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="css/Header.css">
        <link rel="stylesheet" href="css/Main.css">
    </head>

    <body>

        <!-- Banner -->
        <div class="banner">
            <!-- 2 layer để fade mượt -->
            <div class="banner-layer active" id="layer1"></div>
            <div class="banner-layer" id="layer2"></div>

            <!-- Info -->
            <div class="banner-info">
                <h1 id="movie-title"></h1>
                <p id="movie-original" class="movie-original"></p>
                <p id="movie-meta"></p>
                <div id="movie-genres" class="genres"></div>
                <p id="movie-desc"></p>
                <div class="banner-buttons">
                    <a href="series">
                        <input type="hidden" name="movieId" value="1">
                        <button type="submit" class="btn btn-light">
                            <i class="fa fa-play"></i> Xem ngay
                        </button>
                    </a>
                </div>
            </div>

            <!-- Carousel nhỏ -->
            <div class="carousel" id="carousel">
                <img src="Images/Banner1.jpg" data-img="Images/Banner1.jpg">
                <img src="Images/Banner2.jpg" data-img="Images/Banner2.jpg">
                <img src="Images/Banner3.jpg" data-img="Images/Banner3.jpg">
            </div>
        </div>

        <script>
            var movies = {
                "Images/Banner1.jpg": {id: 1, title: "Stranger Things", original: "The Conjuring: Last Rites", meta: "2025 | 1h50m", genres: ["Kinh dị", "Tâm lý"], desc: "Ed và Lorraine Warren đối mặt với thế lực ác quỷ gieo rắc kinh hoàng..."},
                "Images/Banner2.jpg": {id: 2, title: "Squid Game", original: "Avengers: Legacy", meta: "2024 | 2h30m", genres: ["Hành động", "Kinh dị"], desc: "Đội Avengers thế hệ mới tiếp tục hành trình bảo vệ Trái Đất..."},
                "Images/Banner3.jpg": {id: 3, title: "Breaking Bad", original: "Inside Out 2", meta: "2023 | 1h40m", genres: ["Drama", "Tội Phạm"], desc: "Những cảm xúc quen thuộc trở lại cùng nhiều cảm xúc mới..."}
            };

            var layer1 = document.getElementById("layer1");
            var layer2 = document.getElementById("layer2");
            var currentLayer = layer1;
            var nextLayer = layer2;
            var titleEl = document.getElementById("movie-title");
            var originalEl = document.getElementById("movie-original");
            var metaEl = document.getElementById("movie-meta");
            var genresEl = document.getElementById("movie-genres");
            var descEl = document.getElementById("movie-desc");
            var movieIdInput = document.querySelector("input[name='movieId']");
            var carouselImgs = document.querySelectorAll("#carousel img");

            function updateBanner(imageUrl) {
                var movie = movies[imageUrl];
                if (!movie)
                    return;

                // Set layer tiếp theo
                nextLayer.style.backgroundImage = "url('" + imageUrl + "')";
                nextLayer.classList.add("active");
                currentLayer.classList.remove("active");

                // Swap
                [currentLayer, nextLayer] = [nextLayer, currentLayer];

                // Update info
                titleEl.innerText = movie.title;
                originalEl.innerText = movie.original;
                metaEl.innerText = movie.meta;
                descEl.innerText = movie.desc;

                // Genres
                var genresHtml = "";
                for (var i = 0; i < movie.genres.length; i++) {
                    var g = movie.genres[i];
                    genresHtml += '<a href="Genre.jsp?name=' + encodeURIComponent(g) + '" class="genre-tag">' + g + '</a>';
                }
                genresEl.innerHTML = genresHtml;

                movieIdInput.value = movie.id;
            }

            // Gán click
            carouselImgs.forEach(function (img) {
                img.addEventListener("click", function () {
                    updateBanner(this.dataset.img);
                });
            });

            // Khởi tạo banner
            window.onload = function () {
                updateBanner("Images/Banner1.jpg");
            };
        </script>

    </body>
</html>