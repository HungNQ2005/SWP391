<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
                        <a href="${pageContext.request.contextPath}/showFilm?id=${movie.seriesID}" class="btn-watch">
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
        <a href="wishlist?action=addFilmInFavorite&seriesId=${movie.seriesID}" class="btn btn-outline-danger">
            Yêu thích
        </a>


        <!-- Diễn Viên -->
        <div class="col-12 mt-4">
            <div class="Title">
                <h2>Diễn Viên</h2>
            </div>
            <div class="Actor d-flex flex-wrap gap-3">
                <c:forEach var="p" items="${listPerformer}">
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/performer/info?id=${p.performerID}">
                            <img src="${p.photoUrl}" alt="${p.name}" style="width:150px; height:200px; object-fit:cover; border-radius:10px;">
                        </a>
                        <p class="mt-2">${p.name}</p>
                    </div>
                </c:forEach>
            </div>
        </div>

    </body>
</html>