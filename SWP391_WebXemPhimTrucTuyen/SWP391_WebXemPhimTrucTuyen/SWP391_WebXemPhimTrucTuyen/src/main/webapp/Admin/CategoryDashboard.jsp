<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Category Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://localhost:8080/SWP391_WebXemPhimTrucTuyen/css/category-style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <!-- Sidebar -->
    <%@ include file="Sidebar.jsp" %>

    <!-- Main Content -->
    <div class="content">
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
                                            <button class="btn btn-danger btn-sm" 
                                                    onclick="window.location.href='${pageContext.request.contextPath}/admin/category?action=delete&id=${c.category_id}'">
                                                Delete
                                            </button>
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

    <!-- Add Modal -->
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg-custom">
            <form action="${pageContext.request.contextPath}/admin/category" method="post" onsubmit="return validateAddForm()">
                <input type="hidden" name="action" value="insert">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5>Add Category</h5>
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

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg-custom">
            <form action="${pageContext.request.contextPath}/admin/category" method="post" onsubmit="return validateEditForm()">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="category_id" id="editCategoryID">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5>Edit Category</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editName" class="form-label">Category Name</label>
                            <input type="text" id="editName" name="name" class="form-control" required>
                            <div id="editNameError" class="text-white mt-1"></div>
                        </div>
                        <div class="mb-3">
                            <label for="editDescription" class="form-label">Description</label>
                            <textarea id="editDescription" name="description" class="form-control" rows="3"></textarea>
                            <div id="editDescError" class="text-white mt-1"></div>
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

    <!-- Delete Modal chỉ để cảnh báo khi category có phim -->
    <c:if test="${param.deleteWarning == 'hasSeries'}">
        <div class="modal fade show" id="confirmDeleteModal" style="display:block;" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">⚠️ Cannot Delete</h5>
                    </div>
                    <div class="modal-body">
                        <p>Category này có phim. Xóa sẽ mất tất cả phim liên quan.</p>
                    </div>
                    <div class="modal-footer">
                        <a href="${pageContext.request.contextPath}/admin/category?action=list" class="btn btn-secondary">OK</a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Edit modal
        document.addEventListener("click", e => {
            if(e.target.classList.contains("editBtn")){
                document.getElementById("editCategoryID").value = e.target.dataset.id;
                document.getElementById("editName").value = e.target.dataset.name;
                document.getElementById("editDescription").value = e.target.dataset.description;
                new bootstrap.Modal(document.getElementById("editModal")).show();
            }
        });

        // Search filter
        document.getElementById('searchInput').addEventListener('keyup', function(){
            const filter = this.value.toLowerCase();
            document.querySelectorAll('tbody tr').forEach(row=>{
                row.style.display = row.textContent.toLowerCase().includes(filter) ? '' : 'none';
            });
        });

        // Validation
        function validateCategoryForm(nameInput, descInput, nameErrorId, descErrorId){
            const name = nameInput.value.trim();
            const desc = descInput.value.trim();
            const nameError = document.getElementById(nameErrorId);
            const descError = document.getElementById(descErrorId);

            nameError.textContent = "";
            descError.textContent = "";
            nameInput.classList.remove("is-invalid");
            descInput.classList.remove("is-invalid");

            const validRegex = /^[A-Za-zÀ-ỹ0-9\s\-\_\.\,\&]+$/;

            if(name.length===0){
                nameError.textContent="Category Name không được để trống.";
                nameInput.classList.add("is-invalid"); return false;
            } else if(!isNaN(name)){
                nameError.textContent="Category Name không được toàn số.";
                nameInput.classList.add("is-invalid"); return false;
            } else if(/^\d/.test(name)){
                nameError.textContent="Category Name không được bắt đầu bằng số.";
                nameInput.classList.add("is-invalid"); return false;
            } else if(!validRegex.test(name)){
                nameError.textContent="Category Name chứa ký tự không hợp lệ.";
                nameInput.classList.add("is-invalid"); return false;
            }

            if(desc.length===0){
                descError.textContent="Description không được để trống.";
                descInput.classList.add("is-invalid"); return false;
            } else if(!validRegex.test(desc)){
                descError.textContent="Description chứa ký tự không hợp lệ.";
                descInput.classList.add("is-invalid"); return false;
            }

            return true;
        }

        function validateAddForm(){
            return validateCategoryForm(
                document.getElementById("addName"),
                document.getElementById("addDescription"),
                "addNameError",
                "addDescError"
            );
        }

        function validateEditForm(){
            return validateCategoryForm(
                document.getElementById("editName"),
                document.getElementById("editDescription"),
                "editNameError",
                "editDescError"
            );
        }
    </script>
</body>
</html>
