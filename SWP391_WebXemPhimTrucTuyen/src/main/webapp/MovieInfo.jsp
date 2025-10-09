<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>The Conjuring: Nghi L? Cu?i Cùng</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
            />
        <link rel="stylesheet" href="css/Header.css" />
        <link rel="stylesheet" href="css/MovieInfo.css" />
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="include/Header.jsp" />

        <div class="container mt-4">
            <div class="card">
                <img src="${movie.posteUrl}" alt="Poster" class="card-img" />
                <div class="card-img-overlay d-flex flex-column justify-content-end">
                    <h2 class="card-title">${movie.title}</h2>
                    <p class="card-text">${movie.releaseYear} | ${movie.country}</p>
                    <p class="card-text">The Conjuring: Last Rites</p>
                    <p class="card-text">
                        ? 2025 | 1h50m <br />
                        1tr l??t xem
                    </p>
                    <div class="poster-box">
                        <img src="${movie.posteUrl}" alt="Poster nh?" class="small-overlay" />
                        <a href="${movie.trailerUrl}" class="btn-watch" target="_blank">
                            <i class="fa fa-play"></i> Xem trailer
                        </a>
                        <a href="#" class="btn-watch">
                            <i class="fa fa-play"></i> Xem ngay
                        </a>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-12">
                    <p class="movie-story">
                        ${movie.description}
                    </p>
                </div>
            </div>
        </div>

        <div class="col-12 mt-5">
            <div class="Title">
                <h2>Phim T??ng T?</h2>
            </div>
            <div>
                <div class="Tuong-Tu d-flex justify-content-around">
                    <a href="#"><img src="Images/Banner1.jpg" alt="Phim 1" /></a>
                    <a href="#"><img src="Images/Banner2.jpg" alt="Phim 2" /></a>
                    <a href="#"><img src="Images/Banner3.jpg" alt="Phim 3" /></a>
                    <a href="#"><img src="Images/Banner1.jpg" alt="Phim 4" /></a>
                </div>
            </div>
        </div>

        <div class="col-12 mt-5">
            <div class="Title">
                <h2>Di?n Viên</h2>
            </div>
            <div>
                <div class="Actor d-flex justify-content-around">
                    <a href="#"><img src="Images/Banner1.jpg" alt="Di?n viên 1" /></a>
                    <a href="#"><img src="Images/Banner2.jpg" alt="Di?n viên 2" /></a>
                    <a href="#"><img src="Images/Banner3.jpg" alt="Di?n viên 3" /></a>
                    <a href="#"><img src="Images/Banner1.jpg" alt="Di?n viên 4" /></a>
                </div>
            </div>
        </div>
    </body>
</html>
