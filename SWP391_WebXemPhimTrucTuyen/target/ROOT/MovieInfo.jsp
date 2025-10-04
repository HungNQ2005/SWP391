<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <title>Trang Phim gì đó</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link rel="stylesheet" href="css/Header.css" />
        <link rel="stylesheet" href="css/MovieInfo.css" />
    </head>
</head>

<body>
    <!-- Header -->
    <div id="header-placeholder"></div>
    <script>
        fetch("include/Header.jsp")
                .then((res) => res.text())
                .then((data) => {
                    document.getElementById("header-placeholder").innerHTML = data;
                });
    </script>
    <div class="" id="movie-info">
        <!-- Thông tin phim sẽ render ở đây -->
    </div>

    <script>
        // Lấy id từ URL (vd: MovieInfo.html?id=2)
        const params = new URLSearchParams(window.location.search);
        const movieId = params.get("id");

        // Dữ liệu phim (có thể thay bằng fetch từ JSON hoặc API sau này)
        const movies = {
            1: {
                title: "The Conjuring: Nghi Lễ Cuối Cùng",
                original: "The Conjuring: Last Rites",
                meta: "2025 | 1h50m",
                desc: "Ed và Lorraine Warren đối mặt với thế lực ác quỷ gieo rắc kinh hoàng...",
                poster: "Images/Banner1.jpg",
                genres: ["Kinh dị", "Tâm lý"],
                star: ["1tr"],
                story: ["Đến với hồi kết của vũ trụ The Conjuring, The Conjuring: Nghi Lễ Cuối Cùng theo chân cặp đôi trừ tà Ed và Lorraine Warrent đối mặt với một thế lực ác quỷ, kẻ đã reo rắc nỗi kinh hoàng cho gia đình Smurl trong suốt hơn một thập kỷ. Bộ phim lần này cũng được dựa trên một trong những vụ án có thật mà gia đình Warren đã trải qua."]
            },
            2: {
                title: "Avengers: Legacy",
                original: "Avengers: Legacy",
                meta: "2024 | 2h30m",
                desc: "Đội Avengers thế hệ mới tiếp tục hành trình bảo vệ Trái Đất khỏi hiểm họa vũ trụ...",
                poster: "Images/Banner2.jpg",
                genres: ["Hành động", "Viễn tưởng"],
                star: ["1tr"]
            },
            3: {
                title: "Inside Out 2",
                original: "Inside Out 2",
                meta: "2023 | 1h40m",
                desc: "Những cảm xúc quen thuộc trở lại cùng nhiều cảm xúc mới trong cuộc phiêu lưu đầy ý nghĩa...",
                poster: "Images/Banner3.jpg",
                genres: ["Hoạt hình", "Hài hước"],
                star: ["1tr"]
            }
        };

        const container = document.getElementById("movie-info");
        const movie = movies[movieId];

        if (movie) {
            container.innerHTML = `
        
         <div class="card">
          <img src="${movie.poster}" alt="Poster" class="card-img" />
          <div class="card-img-overlay d-flex flex-column justify-content-end">
              <h2 class="card-title">${movie.title}</h2>
              <p class="card-text">${movie.original}</p>
              <p class="card-text">🔥 ${movie.meta} | <br>⭐ ${movie.star}</p>
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
      <p class="movie-story">${movie.story}</p>
    </div>
  </div>
  <div>
    <div class="col-12">
      <div class="Title">
        <h2>Phim Tương Tự</h2>
      </div>
      <div>
      <div class="Tuong-Tu">
        <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 1"></a>
        <a href="#"><img src="/Images/Banner2.jpg" alt="Phim 2"></a>
        <a href="#"><img src="/Images/Banner3.jpg" alt="Phim 3"></a>
        <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 4"></a>
      </div>
    </div>
    </div>
    <div>
    <div class="col-12">
      <div class="Title">
        <h2>Diễn Viên</h2>
      </div>
      <div>
      <div class="Actor">
        <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 1"></a>
        <a href="#"><img src="/Images/Banner2.jpg" alt="Phim 2"></a>
        <a href="#"><img src="/Images/Banner3.jpg" alt="Phim 3"></a>
        <a href="#"><img src="/Images/Banner1.jpg" alt="Phim 4"></a>
      </div>
    </div>
    </div>
  </div>

        `;
        } else {
            container.innerHTML = `<h2>Phim không tồn tại!</h2>`;
        }
    </script>
</body>

</html>