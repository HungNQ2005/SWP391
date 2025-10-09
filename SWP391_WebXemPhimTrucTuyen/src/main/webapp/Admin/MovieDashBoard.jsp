<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <link href="http://localhost:8080/SWP391_WebXemPhimTrucTuyen/MovieDashBoard.css" rel="stylesheet" type="text/css"/>
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
            <a href="#">Ads Management</a>
            <a href="Test.html" class="active">Movie Management</a>
            <a href="PerformersDashBoard.html">Performers Management</a>
            <a href="#">Accounts Management</a>
            <a href="CommentDashBoard.html">Comment Management</a>
            <a href="#">Genres/Tags Management</a>
        </div>

        <!-- Main Content -->
        <div class="content">
            <!-- Topbar -->
            <div
                class="topbar d-flex justify-content-between align-items-center mb-3"
                >
                <h5 class="mb-0">Movie Management</h5>
                <button
                    class="btn btn-primary btn-sm"
                    data-bs-toggle="modal"
                    data-bs-target="#addModal"
                    >
                    + Add Movie
                </button>
            </div>

            <!-- Search -->
            <div class="mb-3">
                <div class="input-group search-box">
                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                    <input
                        type="text"
                        class="form-control"
                        placeholder="Tìm kiếm bộ phim..."
                        />
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
                            <c:forEach var="s" items="${listSeries}">
                                <tr>
                                    <td>${s.seriesID}</td>
                                    <td>${s.title}</td>
                                    <td>${s.typeId == 1 ? 'Movie' : 'Series'}</td>
                                    <td>${s.releaseYear}</td>
                                    <td>${s.country}</td>
                                    <td>${s.description}</td>
                                    <td><img src="${s.posteUrl}" width="60" /></td>
                                    <td><a href="${s.trailerUrl}" target="_blank">Trailer</a></td>
                                    <td>?</td>
                                    <td>
                                        <button
                                            class="btn btn-success btn-sm editBtn"
                                            data-id="${s.seriesID}"
                                            data-title="${s.title}"
                                            data-type="${s.typeId}"
                                            data-year="${s.releaseYear}"
                                            data-country="${s.country}"
                                            data-description="${s.description}"
                                            data-poster="${s.posteUrl}"
                                            data-trailer="${s.trailerUrl}"
                                            >
                                            Edit
                                        </button>
                                        <form action="adminMovie" method="get" style="display:inline;">
                                            <input type="hidden" name="action" value="delete" />
                                            <input type="hidden" name="id" value="${s.seriesID}" />
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>
                </div>
            </div>
        </div>

        <!-- Add Movie Modal -->
        <div class="modal fade" id="addModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Movie</h5>
                        <button
                            type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="modal"
                            ></button>
                    </div>
                    <div class="modal-body">
                        <form id="addForm" action="adminMovie" method="post">
                            <input type="hidden" name="action" value="insert" />

                            <div class="col-md-6">
                                <label>Title</label>
                                <input type="text" class="form-control" name="title" required />
                            </div>

                            <div class="col-md-6">
                                <label>Type</label>
                                <select class="form-select" name="type_id">
                                    <option value="1">Movie</option>
                                    <option value="2">Series</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label>Year</label>
                                <input type="number" class="form-control" name="release_year" required />
                            </div>

                            <div class="col-md-6">
                                <label>Country</label>
                                <input type="text" class="form-control" name="country" required />
                            </div>

                            <div class="col-12">
                                <label>Description</label>
                                <textarea class="form-control" name="description" rows="2"></textarea>
                            </div>

                            <div class="col-md-6">
                                <label>Poster URL</label>
                                <input type="text" class="form-control" name="poster_url" />
                            </div>

                            <div class="col-md-6">
                                <label>Trailer URL</label>
                                <input type="text" class="form-control" name="trailer_url" />
                            </div>

                            <div class="mt-3 text-end">
                                <button type="submit" class="btn btn-primary">Add</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Movie Modal -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Movie</h5>
                        <button
                            type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="modal"
                            ></button>
                    </div>
                    <div class="modal-body">
                        <form id="editForm" action="adminMovie" method="post">
                            <input type="hidden" name="action" value="update" />
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label>Title</label>
                                    <input
                                        type="text"
                                        class="form-control"
                                        id="editTitle"
                                        required
                                        />
                                </div>
                                <div class="col-md-6">
                                    <label>Type</label>
                                    <select class="form-select" id="editType">
                                        <option value="Movie">Movie</option>
                                        <option value="Series">Series</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label>Year</label>
                                    <input
                                        type="number"
                                        class="form-control"
                                        id="editYear"
                                        required
                                        />
                                </div>
                                <div class="col-md-6">
                                    <label>Country</label>
                                    <input
                                        type="text"
                                        class="form-control"
                                        id="editCountry"
                                        required
                                        />
                                </div>
                                <div class="col-12">
                                    <label>Description</label>
                                    <textarea
                                        class="form-control"
                                        id="editDescription"
                                        rows="2"
                                        ></textarea>
                                </div>
                                <div class="col-md-6">
                                    <label>Poster URL</label>
                                    <input type="text" class="form-control" id="editPoster" />
                                </div>
                                <div class="col-md-6">
                                    <label>Trailer URL</label>
                                    <input type="text" class="form-control" id="editTrailer" />
                                </div>
                                <div class="col-md-6">
                                    <label>Episode</label>
                                    <input
                                        type="number"
                                        class="form-control"
                                        id="editEpisode"
                                        min="1"
                                        />
                                </div>
                            </div>
                            <div class="mt-3 text-end">
                                <button type="submit" class="btn btn-success">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Movie Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Delete Movie</h5>
                        <button
                            type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="modal"
                            ></button>
                    </div>
                    <div class="modal-body">Bạn có chắc muốn xóa bộ phim này không?</div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">
                            Cancel
                        </button>
                        <button class="btn btn-danger" id="confirmDelete">Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            let currentDeleteRow = null;

            // Edit button
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("editBtn")) {
                    new bootstrap.Modal(document.getElementById("editModal")).show();
                }
            });

            // Delete button
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("deleteBtn")) {
                    currentDeleteRow = e.target.closest("tr");
                    new bootstrap.Modal(document.getElementById("deleteModal")).show();
                }
            });
        </script>
    </body>
</html>