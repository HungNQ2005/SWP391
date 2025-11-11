<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${movie.title}</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MovieInfo.css"/>
</head>

<body>

<!-- Header -->


<div class="container mt-4">
    <div class="card">
        <img src="${movie.posteUrl}" alt="Poster" class="card-img"/>
        <div class="card-img-overlay d-flex flex-column justify-content-end">
            <h2 class="card-title">${movie.title}</h2>
          
            <div class="poster-box">
                <img src="${movie.posteUrl}" alt="Poster" class="small-overlay"/>
                <a href="playFilm?id=${movie.seriesID}" class="btn-watch">
                    <i class="fa fa-play"></i> Xem ngay
                </a>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12">
            <p class="movie-story">${movie.description}</p>
        </div>
    </div>
</div>



<!-- Diễn Viên -->
<div class="col-12 mt-4">
    <div class="Title">
        <h2>Diễn Viên</h2>
    </div>
    <div class="Actor">
        <a href="#"><img src="${pageContext.request.contextPath}/Images/Banner1.jpg" alt="DV 1"></a>
        <a href="#"><img src="${pageContext.request.contextPath}/Images/Banner2.jpg" alt="DV 2"></a>
        <a href="#"><img src="${pageContext.request.contextPath}/Images/Banner3.jpg" alt="DV 3"></a>
        <a href="#"><img src="${pageContext.request.contextPath}/Images/Banner1.jpg" alt="DV 4"></a>
    </div>
</div>

</body>
</html>