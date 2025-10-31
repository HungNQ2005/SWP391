<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page import="java.util.List, model.Genre" %> 

<%
    List<Genre> genres = (List<Genre>) request.getAttribute("listGenre");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Genre Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/genre.css?v=1">
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="admin-info text-center">
            <img src="https://us.oricon-group.com/upimg/sns/5000/5552/img1200/demon-slayer-infinity-castle-akaza-2025.jpg" 
                 alt="Admin" width="80" height="80" class="rounded-circle">
            <h6 class="mt-2 text-white">Admin</h6>
        </div>
        <a href="#">Ads Management</a>
        <a href="#">Movie Management</a>
        <a href="#">Performers Management</a>
        <a href="#">Accounts Management</a>
        <a href="#">Comment Management</a>
        <a href="#" class="active">Genre Management</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <a href="genre" class="btn btn-outline-light btn-sm active">Genre</a>
            </div>
            <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addGenreModal">+ Add Genre</button>
        </div>

        <div class="mb-3">
            <input type="text" class="form-control" placeholder="Search..." id="searchInput">
        </div>

        <!-- Genre Table -->
        <div class="card">
            <div class="card-body p-0">
                <table class="table table-dark table-striped table-hover mb-0 text-center align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Genre Name</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty listGenre}">
                                <c:forEach var="g" items="${listGenre}">
                                    <tr>
                                        <td>${g.genreId}</td>
                                        <td>${g.genreName}</td>
                                        <td>${g.description}</td>
                                        <td>
                                            <a href="genre?action=edit&id=${g.genreId}" class="btn btn-success btn-sm">Edit</a>
                                            <a href="#" class="btn btn-danger btn-sm"
                                               onclick="showDeleteModal('genre?action=delete&id=${g.genreId}')">
                                                Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center text-muted">No genre found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Genre Modal -->
    <div class="modal fade" id="addGenreModal" tabindex="-1" aria-labelledby="addGenreModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addGenreModalLabel">Add Genre</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="genre?action=insert" method="post" onsubmit="return validateAddForm()">
                        <div class="mb-3">
                            <label for="addName" class="form-label">Genre Name</label>
                            <input type="text" id="addName" name="genreName" class="form-control" placeholder="Enter genre name" required>
                            <div id="addNameError" class="text-danger mt-1"></div>
                        </div>
                        <div class="mb-3">
                            <label for="addDescription" class="form-label">Description</label>
                            <textarea id="addDescription" name="description" class="form-control" rows="3" placeholder="Enter description" required></textarea>
                            <div id="addDescError" class="text-danger mt-1"></div>
                        </div>
                        <div class="d-flex justify-content-end">
                            <button type="submit" class="btn btn-primary me-2">Add</button>
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">⚠️ Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Deleting this genre will also <strong>delete all movies related to it</strong>.</p>
                    <p>Are you sure you want to continue?</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a id="confirmDeleteBtn" class="btn btn-danger">Yes, Delete</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function validateAddForm() {
            const nameInput = document.getElementById("addName");
            const descInput = document.getElementById("addDescription");
            const name = nameInput.value.trim();
            const desc = descInput.value.trim();
            const nameError = document.getElementById("addNameError");
            const descError = document.getElementById("addDescError");

            nameError.textContent = "";
            descError.textContent = "";
            nameInput.classList.remove("is-invalid");
            descInput.classList.remove("is-invalid");

            const validRegex = /^[A-Za-zÀ-ỹ0-9\s\-\_\.\,\&]+$/;

            if (name.length === 0) {
                nameError.textContent = "Genre Name không được để trống.";
                nameInput.classList.add("is-invalid");
                return false;
            } else if (!isNaN(name)) {
                nameError.textContent = "Genre Name không được toàn số.";
                nameInput.classList.add("is-invalid");
                return false;
            } else if (/^\d/.test(name)) {
                nameError.textContent = "Genre Name không được bắt đầu bằng số.";
                nameInput.classList.add("is-invalid");
                return false;
            } else if (!validRegex.test(name)) {
                nameError.textContent = "Genre Name chứa ký tự không hợp lệ.";
                nameInput.classList.add("is-invalid");
                return false;
            }

            if (desc.length === 0) {
                descError.textContent = "Description không được để trống.";
                descInput.classList.add("is-invalid");
                return false;
            } else if (!validRegex.test(desc)) {
                descError.textContent = "Description chứa ký tự không hợp lệ.";
                descInput.classList.add("is-invalid");
                return false;
            }
            return true;
        }

        document.getElementById('searchInput').addEventListener('keyup', function() {
            const filter = this.value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });

        function showDeleteModal(deleteUrl) {
            const modal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            document.getElementById('confirmDeleteBtn').setAttribute('href', deleteUrl);
            modal.show();
        }
    </script>
</body>
</html>
