<%-- 
    Document   : moviePage.jsp
    Created on : Oct 3, 2025, 6:28:56 PM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>TV Shows</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    />
    <link href="../css/moviePage.css" rel="stylesheet" type="text/css"/>
  </head>
  <body class="bg-dark text-white">
    <div class="container py-4">
      <!-- Filter Button -->
      <div class="mb-4 d-flex justify-content-between align-items-center">
        <h1 class="text-white fw-bold display-4 mb-0">Movie</h1>
        <button class="btn btn-danger" id="toggleFilter">
          <i class="bi bi-funnel"></i> Filter
        </button>
      </div>
      <!-- Filter Panel -->
      <div class="bg-dark text-light p-3 rounded d-none" id="filterPanel">
        <div class="mb-3">
          <strong>Country:</strong><br />
          <button class="btn btn-sm btn-danger">All</button>
          <button class="btn btn-sm btn-outline-light">USA</button>
          <button class="btn btn-sm btn-outline-light">UK</button>
          <button class="btn btn-sm btn-outline-light">Canada</button>
          <button class="btn btn-sm btn-outline-light">Korea</button>
          <button class="btn btn-sm btn-outline-light">Japan</button>
        </div>

        <div class="mb-3">
          <strong>Type:</strong><br />
          <button class="btn btn-sm btn-danger">All</button>
          <button class="btn btn-sm btn-outline-light">Movie</button>
          <button class="btn btn-sm btn-outline-light">TV Show</button>
        </div>

        <div class="mb-3">
          <strong>Rating:</strong><br />
          <button class="btn btn-sm btn-danger">All</button>
          <button class="btn btn-sm btn-outline-light">P (All ages)</button>
          <button class="btn btn-sm btn-outline-light">K (Under 13)</button>
          <button class="btn btn-sm btn-outline-light">T13 (13+)</button>
          <button class="btn btn-sm btn-outline-light">T16 (16+)</button>
          <button class="btn btn-sm btn-outline-light">T18 (18+)</button>
        </div>

        <div class="mb-3">
          <strong>Genre:</strong><br />
          <button class="btn btn-sm btn-danger">All</button>
          <button class="btn btn-sm btn-outline-light">Action</button>
          <button class="btn btn-sm btn-outline-light">Comedy</button>
          <button class="btn btn-sm btn-outline-light">Drama</button>
          <button class="btn btn-sm btn-outline-light">Romance</button>
          <button class="btn btn-sm btn-outline-light">Animation</button>
          <button class="btn btn-sm btn-outline-light">Fantasy</button>
          <button class="btn btn-sm btn-outline-light">Thriller</button>
        </div>

        <div class="mb-3">
          <strong>Year:</strong><br />
          <button class="btn btn-sm btn-danger">All</button>
          <button class="btn btn-sm btn-outline-light">2025</button>
          <button class="btn btn-sm btn-outline-light">2024</button>
          <button class="btn btn-sm btn-outline-light">2023</button>
          <button class="btn btn-sm btn-outline-light">2022</button>
        </div>
        <div class="d-flex gap-2">
          <button class="btn btn-danger btn-sm">Apply Filter</button>
          <button class="btn btn-secondary btn-sm" id="closeFilter">
            Close
          </button>
        </div>
      </div>

      <!-- Movie list -->
      <!-- Thay row bằng movie-row -->
      <div class="movie-row d-flex flex-nowrap overflow-auto gap-3 pb-3">
        <div class="movie-card bg-dark border-0 text-center">
          <div class="position-relative" style="width: 160px">
            <img
              src="https://cdn.tienphong.vn/images/a6bf4f60924201126af6849ca45a3980e76ea1ce783b7b7bfe465da8d1f4abc5c29d8716f52125769ad840e1780a57a57ab20850633b51c487ed4f58cbd794757f47056751f810994bff90fe42fcd757/kimetsu-no-yaiba-135-9897.jpg"
              class="card-img-top"
              alt="Tên phim"
            />
            <span
              class="badge bg-secondary position-absolute bottom-0 start-0 m-2"
            >
              Episode 1
            </span>
          </div>
          <div class="card-body p-2">
            <a href="#" class="text-light" style="text-decoration: none"
              >Thanh gươm diệt quỷ</a
            >
          </div>
        </div>

          <div class="movie-card bg-dark border-0 text-center">
          <div class="position-relative" style="width: 160px">
            <img
              src="https://cdn.tienphong.vn/images/a6bf4f60924201126af6849ca45a3980e76ea1ce783b7b7bfe465da8d1f4abc5c29d8716f52125769ad840e1780a57a57ab20850633b51c487ed4f58cbd794757f47056751f810994bff90fe42fcd757/kimetsu-no-yaiba-135-9897.jpg"
              class="card-img-top"
              alt="Tên phim"
            />
            <span
              class="badge bg-secondary position-absolute bottom-0 start-0 m-2"
            >
              Episode 1
            </span>
          </div>
          <div class="card-body p-2">
            <a href="#" class="text-light" style="text-decoration: none"
              >Thanh gươm diệt quỷ</a
            >
          </div>
        </div>
        <!-- Copy thêm các card phim ở đây -->
      
        <div class="movie-card bg-dark border-0 text-center">
          <div class="position-relative" style="width: 160px">
            <img
              src="https://tse1.mm.bing.net/th/id/OIP.6lUcLR57NjVPn5ab85IolwHaKR?rs=1&pid=ImgDetMain&o=7&rm=3 "
              class="card-img-top"
              alt="Tên phim"
            />
            <span
              class="badge bg-secondary position-absolute bottom-0 start-0 m-2"
            >
              Episode 1
            </span>
          </div>
          <div class="card-body p-2">
            <a href="#" class="text-light" style="text-decoration: none"
              >Thanh gươm diệt quỷ</a
            >
          </div>
        </div>
      </div>

      <!-- Pagination -->
      <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
          <li class="page-item">
            <a
              class="page-link bg-dark text-white border-secondary"
              href="#"
              aria-label="Previous"
            >
              <i class="bi bi-chevron-left"></i>
            </a>
          </li>
          <li class="page-item active">
            <span class="page-link bg-secondary border-secondary">1</span>
          </li>
          <li class="page-item">
            <a class="page-link bg-dark text-white border-secondary" href="#"
              >2</a
            >
          </li>
          <li class="page-item">
            <a class="page-link bg-dark text-white border-secondary" href="#"
              >3</a
            >
          </li>
          <li class="page-item">
            <a
              class="page-link bg-dark text-white border-secondary"
              href="#"
              aria-label="Next"
            >
              <i class="bi bi-chevron-right"></i>
            </a>
          </li>
        </ul>
      </nav>
    </div>

<!--    <footer>
      <div id="footer-placeholder"></div>
    </footer>-->

    <script>
//      fetch("include/Header.html")
//        .then((res) => res.text())
//        .then((data) => {
//          document.getElementById("header-placeholder").innerHTML = data;
//        });
//
//      fetch("footer.html")
//        .then((res) => res.text())
//        .then((data) => {
//          document.getElementById("footer-placeholder").innerHTML = data;
//        });

      const toggleBtn = document.getElementById("toggleFilter");
      const closeBtn = document.getElementById("closeFilter");
      const filterPanel = document.getElementById("filterPanel");

      toggleBtn.addEventListener("click", () => {
        filterPanel.classList.toggle("d-none");
      });

      closeBtn.addEventListener("click", () => {
        filterPanel.classList.add("d-none");
      });
    </script>
    <script src="js/banner.js"></script>
    <script src="js/viewphimbanner.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>