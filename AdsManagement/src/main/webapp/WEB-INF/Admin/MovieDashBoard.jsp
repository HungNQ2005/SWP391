<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Movie</title>

    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="css/dashboard.css" />
  </head>

  <body>

    <!-- Sidebar -->
    <div class="sidebar">
      <div class="admin-info text-center mb-3">
        <img
          src="https://us.oricon-group.com/upimg/sns/5000/5552/img1200/demon-slayer-infinity-castle-akaza-2025.jpg"
          alt="Admin"
          width="80"
          height="80"
          class="rounded-circle"
        />
        <h6>Admin</h6>
      </div>
      <a href="AdsDashboard.jsp">Ads Management</a>
      <a href="AdminMovie.jsp" class="active">Movie Management</a>
      <a href="PerformersDashBoard.jsp">Performers Management</a>
      <a href="#">Accounts Management</a>
      <a href="CommentDashBoard.jsp">Comment Management</a>
      <a href="#">Genres/Tags Management</a>
    </div>

    <!-- Main Content -->
    <div class="content">
      <div class="topbar d-flex justify-content-between align-items-center mb-3">
        <h5 class="mb-0">Movie Management</h5>
        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addModal">
          + Add Movie
        </button>
      </div>

      <!-- Search -->
      <div class="mb-3">
        <div class="input-group search-box">
          <span class="input-group-text"><i class="bi bi-search"></i></span>
          <input type="text" class="form-control" placeholder="Tìm kiếm bộ phim..." />
        </div>
      </div>

      <!-- Table -->
      <div class="card">
        <div class="card-body p-0">
          <table class="table table-dark table-striped mb-0" id="accountTable">
            <thead class="table-dark">
              <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Type</th>
                <th>Year</th>
                <th>Country</th>
                <th>Description</th>
                <th>Poster</th>
                <th>Trailer</th>
                <th>Episode</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>

              <!-- Sau này sẽ thay bằng forEach từ DB -->
              <tr>
                <td>1</td>
                <td>The Conjuring: Nghi Lễ Cuối Cùng</td>
                <td>Movie</td>
                <td>2025</td>
                <td>USA</td>
                <td>Ed và Lorraine Warren đối mặt với thế lực ác quỷ</td>
                <td>URL</td>
                <td>URL</td>
                <td>1</td>
                <td>
                  <button class="btn btn-success btn-sm editBtn">Edit</button>
                  <button class="btn btn-danger btn-sm deleteBtn">Delete</button>
                </td>
              </tr>

            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Add Modal -->
    <div class="modal fade" id="addModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark text-white">
          <div class="modal-header">
            <h5 class="modal-title">Add Movie</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <form id="addForm">
              <!-- Your Inputs Here -->
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark text-white">
          <div class="modal-header">
            <h5 class="modal-title">Edit Movie</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <form id="editForm">
              <!-- Your Inputs Here -->
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-dark text-white">
          <div class="modal-header">
            <h5 class="modal-title">Delete Movie</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            Bạn có chắc muốn xoá bộ phim này không?
          </div>
          <div class="modal-footer">
            <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button class="btn btn-danger" id="confirmDelete">Delete</button>
          </div>
        </div>
      </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      let currentDeleteRow = null;

      document.addEventListener("click", function (e) {
        if (e.target.classList.contains("editBtn")) {
          new bootstrap.Modal(document.getElementById("editModal")).show();
        }
        if (e.target.classList.contains("deleteBtn")) {
          currentDeleteRow = e.target.closest("tr");
          new bootstrap.Modal(document.getElementById("deleteModal")).show();
        }
      });
    </script>

  </body>
</html>
