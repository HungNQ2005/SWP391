<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Trang Phim gì đó</title>
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
    <div id="header-placeholder"></div>
    <script>
      fetch("include/Header.html")
        .then((res) => res.text())
        .then((data) => {
          document.getElementById("header-placeholder").innerHTML = data;
        });
    </script>

    <div class="card">
      <img src="${movie.poster}" alt="Poster" class="card-img" />
      <div class="card-img-overlay d-flex flex-column justify-content-end">
        <h2 class="card-title">${movie.title}</h2>
        <p class="card-text">${movie.original}</p>
        <p class="card-text">🔥 ${movie.meta} | <br />⭐ ${movie.star}</p>
        <div class="poster-box">
          <img src="${movie.poster}" alt="Poster" class="small-overlay" />
          <a href="#" class="btn-watch">
            <i class="fa fa-play"></i> Xem ngay
          </a>
        </div>
      </div>
    </div>
    <div class="row mt-4">
      <div class="col-12">
        <p class="movie-desc">
          Lâu đài vô cực là một mê cung vô tận, với những không gian liên tục
          biến đổi...
        </p>
      </div>
    </div>
  </body>
</html>

<div class="row mt-4">
  <div class="col-12">
    <p class="movie-story">${movie.story}</p>
  </div>
</div>
<div>
  <div class="col-12">
    <div class="Title">
      <h2>Phim Tương Tự</h2>
    </div>
  </div>
</div>
