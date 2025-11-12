<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Category Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://localhost:8080/SWP391_WebXemPhimTrucTuyen/css/category-style.css?v=1" rel="stylesheet">
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
       
        <a href="#" class="active">Category Management</a>
    </div>

    <!-- Main Content -->
    <div class="content">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>Category Management</h2>
            <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addModal">+ Add Category</button>
        </div>

        <!-- Search -->
        <div class="mb-3">
            <input type="text" id="searchInput" class="form-control" placeholder="Search...">
        </div>

        <!-- Table -->
        <div class="card">
            <div class="card-body p-0">
                <table class="table table-dark table-striped table-hover mb-0 text-center align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${not empty listCategory}">
                                <c:forEach var="c" items="${listCategory}">
                                    <tr>
                                        <td>${c.category_id}</td>
                                        <td>${c.name}</td>
                                        <td>${c.description}</td>
                                        <td>
                                            <button class="btn btn-warning btn-sm editBtn"
                                                    data-id="${c.category_id}"
                                                    data-name="${c.name}"
                                                    data-description="${c.description}">
                                                Edit
                                            </button>
                                            <a href="#"
                                               class="btn btn-danger btn-sm"
                                               onclick="showDeleteModal('adminCategory?action=delete&id=${c.category_id}')">
                                                Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center text-muted">No category found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Category Modal -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg-custom">
            <form action="adminCategory" method="post" onsubmit="return validateAddForm()">
                <input type="hidden" name="action" value="insert">

                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Category</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="addName" class="form-label">Category Name</label>
                            <input type="text" id="addName" name="name" class="form-control" required>
                            <div id="addNameError" class="text-white mt-1"></div>
                        </div>

                        <div class="mb-3">
                            <label for="addDescription" class="form-label">Description</label>
                            <textarea id="addDescription" name="description" class="form-control" rows="3"></textarea>
                            <div id="addDescError" class="text-white mt-1"></div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button class="btn btn-primary">Save</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Category Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg-custom">
            <form action="adminCategory" method="post" onsubmit="return validateEditForm()">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="category_id" id="editCategoryID">

                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Category</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editName" class="form-label">Category Name</label>
                            <input type="text" id="editName" name="name" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="editDescription" class="form-label">Description</label>
                            <textarea id="editDescription" name="description" class="form-control" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button class="btn btn-success">Update</button>
                    </div>
                </div>
            </form>
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
                    <p>Deleting this category will also <strong>delete all movies related to it</strong>.</p>
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
        // Open edit modal and populate fields
        document.addEventListener("click", e => {
            if (e.target.classList.contains("editBtn")) {
                document.getElementById("editCategoryID").value = e.target.dataset.id;
                document.getElementById("editName").value = e.target.dataset.name;
                document.getElementById("editDescription").value = e.target.dataset.description;
                new bootstrap.Modal(document.getElementById("editModal")).show();
            }
        });

        // Confirm delete modal
        function showDeleteModal(deleteUrl) {
            const modal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            document.getElementById('confirmDeleteBtn').setAttribute('href', deleteUrl);
            modal.show();
        }

        // Search filter
        document.getElementById('searchInput').addEventListener('keyup', function () {
            const filter = this.value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    </script>

</body>
</html>
