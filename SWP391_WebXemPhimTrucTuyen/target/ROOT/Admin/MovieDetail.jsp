<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${movie.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-white">

<div class="container py-5">
    <div class="row">
        <div class="col-md-4 text-center">
            <img src="${movie.posteUrl}" alt="${movie.title}" class="img-fluid rounded shadow">
        </div>

        <div class="col-md-8">
            <h2>${movie.title}</h2>
            <p><strong>Thể loại:</strong> ${movie.categoryName}</p>
            <p><strong>Quốc gia:</strong> ${movie.countryName}</p>
            <p><strong>Năm phát hành:</strong> ${movie.releaseYear}</p>
            <p><strong>Loại:</strong> ${movie.typeId == 1 ? "Phim lẻ" : "Phim bộ"}</p>
            <hr>
            <p>${movie.description}</p>

            <c:if test="${not empty movie.trailerUrl}">
                <div class="ratio ratio-16x9 mt-3">
                    <iframe src="${movie.trailerUrl}" allowfullscreen></iframe>
                </div>
            </c:if>

            <a href="home.jsp" class="btn btn-secondary mt-3">⬅ Quay lại</a>
        </div>
    </div>
</div>

</body>
</html>
