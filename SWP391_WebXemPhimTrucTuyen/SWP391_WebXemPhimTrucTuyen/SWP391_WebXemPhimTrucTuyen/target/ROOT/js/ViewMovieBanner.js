document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".film-link").forEach((link) => {
    link.addEventListener("click", (e) => {
      e.preventDefault();
      const movieId = link.dataset.id;
      window.location.href = `/xem-phim/?id=${movieId}`; // chen id theo model
    });
  });
});
