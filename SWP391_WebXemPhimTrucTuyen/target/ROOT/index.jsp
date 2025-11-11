<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Trang Phim Gì Đó</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link rel="stylesheet" href="css/Header.css" />
        <link rel="stylesheet" href="css/Main.css" />


    </head>

    <body>




        <!-- Banner -->
        <div class="banner">
            <div class="banner-layer active" id="layer1"></div>
            <div class="banner-layer" id="layer2"></div>

            <!-- ThÃ´ng tin phim -->
            <div class="banner-info">
                <h1 id="movie-title">The Conjuring: Nghi Lễ Cuối Cùng</h1>
                <p id="movie-original" class="movie-original">
                    The Conjuring: Last Rites
                </p>
                <p id="movie-meta">2025 | 1h50m |</p>
                <div id="movie-genres" class="genres"></div>
                <p id="movie-desc">
                   “Đến với hồi kết của vũ trụ The Conjuring, Ed và Lorraine Warren đối mặt với thế lực ác quỷ gieo rắc kinh hoàng cho gia đình Smurl...”
                </p>
                <div class="banner-buttons">
                    <a id="watch-now" href="${pageContext.request.contextPath}/series?action=allOfSeries" class="btn btn-light">
                        <i class="fa fa-play"></i> Xem ngay
                    </a>
                </div>
            </div>

            <!-- Carousel -->
            <div class="carousel">
                <img src="Images/Banner1.jpg" alt="Phim 1" onclick="changeBanner('Images/Banner1.jpg')" />
                <img src="Images/Banner2.jpg" alt="Phim 2" onclick="changeBanner('Images/Banner2.jpg')" />
                <img src="Images/Banner3.jpg" alt="Phim 3" onclick="changeBanner('Images/Banner3.jpg')" />
                <img src="Images/Banner3.jpg" alt="Phim 3" onclick="changeBanner('Images/Banner3.jpg')" />
            </div>
        </div>
        <!--Hot + Trending-->
        <div class="Title ">
            <h2>Phim Hot - Trending</h2>
        </div>


        <div>
            <div class="hot-tredinglist">
                <a href="MovieInfo.html?id=1"><img src="Images/Banner1.jpg"></a>
                <a href="MovieInfo.html?id=2"><img src="Images/Banner2.jpg"></a>
                <a href="MovieInfo.html?id=3"><img src="Images/Banner3.jpg"></a>
                <a href="MovieInfo.jsp?id=4"><img src="Images/Banner1.jpg" alt="Phim 4"></a>
            </div>
        </div>
    </div>
    <div class="Title">
        <h2>Top 10</h2>
    </div>

    <div class="top10-wrapper">
        <div class="top10-list" id="top10">
            <a href="MovieInfo.html?id=1"><img src="Images/Banner1.jpg" alt="Phim 1"></a>
            <a href="MovieInfo.html?id=2"><img src="Images/Banner2.jpg" alt="Phim 2"></a>
            <a href="MovieInfo.html?id=3"><img src="Images/Banner3.jpg" alt="Phim 3"></a>
            <a href="MovieInfo.html?id=1"><img src="Images/Banner1.jpg" alt="Phim 4"></a>
            <a href="MovieInfo.html?id=2"><img src="Images/Banner2.jpg" alt="Phim 5"></a>
            <a href="MovieInfo.html?id=3"><img src="Images/Banner3.jpg" alt="Phim 6"></a>
            <a href="MovieInfo.html?id=1"><img src="Images/Banner1.jpg" alt="Phim 7"></a>
            <a href="MovieInfo.html?id=2"><img src="Images/Banner2.jpg" alt="Phim 8"></a>
            <a href="MovieInfo.html?id=3"><img src="Images/Banner3.jpg" alt="Phim 9"></a>
            <a href="MovieInfo.html?id=1"><img src="Images/Banner1.jpg" alt="Phim 10"></a>
        </div>
    </div>
    <script>
        let index = 0;
        const list = document.getElementById("top10");
        const items = document.querySelectorAll("#top10 img");
        const visible = 5; // sá» lÆ°á»£ng hiá»n thá» cÃ¹ng lÃºc
        const total = items.length;

        function slide() {
            index++;
            if (index > total - visible) {
                index = 0; // quay láº¡i Äáº§u khi háº¿t
            }
            const offset = -(index * 220); // 200px + 20px margin
            list.style.transform = `translateX(${offset}px)`;
        }

        setInterval(slide, 3000); // auto trÆ°á»£t má»i 3s

    </script>


    <!--Hot + Trending-->
    <div class="Title ">
        <h2>Phim Bộ</h2>
    </div>


    <div>
        <div class="hot-tredinglist">
            <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 1"></a>
            <a href="#"><img src="/Images/Banner2.jpg" alt="Phim 2"></a>
            <a href="#"><img src="/Images/Banner3.jpg" alt="Phim 3"></a>
            <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 4"></a>
        </div>
    </div>
</div>

<!--Phim Äáº·t Sáº¯c-->
<div class="Title ">
    <h2>Phim Đặc Sắc</h2>
</div>


<div>
    <div class="PhimDacSaclist">
        <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 1"></a>
        <a href="#"><img src="/Images/Banner2.jpg" alt="Phim 2"></a>
        <a href="#"><img src="/Images/Banner3.jpg" alt="Phim 3"></a>
        <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 4"></a>
        <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 1"></a>
        <a href="#"><img src="/Images/Banner2.jpg" alt="Phim 2"></a>
        <a href="#"><img src="/Images/Banner3.jpg" alt="Phim 3"></a>
    </div>
</div>
</div>



</body>

</html>