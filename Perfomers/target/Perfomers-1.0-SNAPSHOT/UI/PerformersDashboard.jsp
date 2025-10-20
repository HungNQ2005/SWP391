<%-- 
    Document   : PerformersDashboard
    Created on : Oct 1, 2025, 5:22:05 PM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Performers Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="http://localhost:8080/Perfomers/asset/css/PerformersDashBoard.css" rel="stylesheet">
    </head>

    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="admin-info">
                <img src="https://us.oricon-group.com/upimg/sns/5000/5552/img1200/demon-slayer-infinity-castle-akaza-2025.jpg" alt="Admin" width="80" height="80" />
                <h6>Admin</h6>
            </div>
            <a href="#">Ads Management</a>
            <a href="#">Movie Management</a>
            <a href="#" class="active">Performers Management</a>
            <a href="AccountDashBoard.jsp">Accounts Management</a>
            <a href="CommentDashBoard.jsp">Comments Management</a>
            <a href="#">Genres/Tags Management</a>
        </div>

        <!-- Main Content -->
        <div class="content">

            <div class="topbar d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Performers Management</h5>
                <button class="btn btn-netflix btn-sm" data-bs-toggle="modal" data-bs-target="#addModal">+ Add Performer</button>
            </div>

            <form action="PerformersAdmin" method="get" class="search-box mb-3 d-flex">
                <input type="text" name="keyword" class="form-control bg-dark text-white" 
                       placeholder="Search performer..." value="${keyword}" />
                <button type="submit" class="btn btn-danger ms-2">Search</button>
            </form>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="error" scope="session" />
            </c:if>

            <!-- Table -->
            <div class="card">
                <div class="card-body p-0">
                    <table class="table table-dark table mb-0">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Name</th>
                                <th>Date of Birth</th>
                                <th>Nationality</th>
                                <th>Description</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty message}">
                                <tr>
                                    <td colspan="6" class="text-center text-danger fw-bold">${message}</td>
                                </tr>
                            </c:if>

                            <c:forEach var="performer" items="${performers}" varStatus="loop">
                                <tr> 
                                    <td>${performer.performer_id}</td> 
                                    <td>
                                        <a href="${pageContext.request.contextPath}/PerformerDetail?id=${performer.performer_id}" 
                                           class="text-decoration-none text-white fw-bold">
                                            ${performer.name}
                                        </a>
                                    </td>
                                    <td>${performer.date_of_birth}</td>
                                    <td>${performer.nationality}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(performer.description) > 30}">
                                                ${fn:substring(performer.description, 0,30)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${performer.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-warning btn-sm edit-btn"
                                                data-bs-toggle="modal" data-bs-target="#editModal"
                                                data-id="${performer.performer_id}"
                                                data-name="${performer.name}"
                                                data-photo="${performer.photo_url}"
                                                data-gender="${performer.gender}"
                                                data-desc="${performer.description}"
                                                data-dob="${performer.date_of_birth}"
                                                data-nation="${performer.nationality}">
                                            Edit
                                        </button>
                                        <button class="btn btn-danger btn-sm"
                                                data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                data-id="${performer.performer_id}"
                                                data-name="${performer.name}"
                                                data-page="${currentPage}">
                                            Delete
                                        </button>
                                    </td>
                                </tr> 
                            </c:forEach>
                        </tbody>                  
                    </table>

                    <!-- Pagination -->
                    <nav aria-label="Performers Page Navigation" class="mt-4 mb-4">
                        <ul class="pagination justify-content-center flex-wrap">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link bg-dark text-white border-secondary" 
                                   href="PerformersAdmin?page=${currentPage - 1}${not empty keyword ? '&keyword=' : ''}${keyword}" 
                                   tabindex="-1">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link ${i == currentPage ? 'bg-danger border-danger text-white' : 'bg-dark text-white border-secondary'}" 
                                       href="PerformersAdmin?page=${i}${not empty keyword ? '&keyword=' : ''}${keyword}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link bg-dark text-white border-secondary" 
                                   href="PerformersAdmin?page=${currentPage + 1}${not empty keyword ? '&keyword=' : ''}${keyword}">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- ADD Modal -->
        <div class="modal fade" id="addModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Add Performer</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="PerformersAdmin" method="post">
                            <input type="hidden" name="action" value="add" />
                            <div class="mb-3">
                                <label class="form-label">Name</label>
                                <input type="text" name="name" placeholder="Enter performer's name" class="form-control bg-dark text-white" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Date of Birth</label>
                                <input type="date" name="date_of_birth" class="form-control bg-dark text-white" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Gender</label>
                                <select name="gender" class="form-select bg-dark text-white">
                                    <option value="" disabled selected>Select gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Photo URL</label>
                                <input type="text" name="photo_url" placeholder="Enter image URL" class="form-control bg-dark text-white" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Nationality</label>
                                <input type="text" name="nationality" placeholder="Enter nationality" class="form-control bg-dark text-white" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea name="description" placeholder="Short introduction about performer" class="form-control bg-dark text-white" rows="3"></textarea>
                            </div>
                            <button type="submit" class="btn btn-danger w-100">Add</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- EDIT Modal -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Edit Performer</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editForm" method="post" action="PerformersAdmin">
                            <input type="hidden" name="action" value="edit" />
                            <input type="hidden" id="editId" name="id" />
                            <input type="hidden" name="currentPage" value="${currentPage}" />
                            <input type="hidden" name="keyword" value="${keyword}" />
                            <div class="mb-3">
                                <label class="form-label">Name</label>
                                <input type="text" id="editName" name="name" class="form-control bg-dark text-white" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Date of Birth</label>
                                <input type="date" id="editDOB" name="date_of_birth" class="form-control bg-dark text-white" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Gender</label>
                                <select id="editGender" name="gender" class="form-select bg-dark text-white" required>
                                    <option value="" disabled selected>Select gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Nationality</label>
                                <input type="text" id="editNation" name="nationality" class="form-control bg-dark text-white" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Photo URL</label>
                                <input type="text" id="editPhoto" name="photo_url" class="form-control bg-dark text-white" required />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea id="editDesc" name="description" class="form-control bg-dark text-white" rows="3"></textarea>
                            </div>
                            <button type="submit" class="btn btn-danger w-100">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- DELETE Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Delete Performer</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form method="post" action="PerformersAdmin">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="id" id="deleteId" />
                        <input type="hidden" name="currentPage" value="${currentPage}" />
                        <input type="hidden" name="keyword" value="${keyword}" />
                        <div class="modal-body">
                            <p id="deleteMessage"></p> 
                        </div>
                        <div class="modal-footer border-0">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                document.querySelectorAll(".edit-btn").forEach(btn => {
                    btn.addEventListener("click", function () {
                        const id = this.dataset.id || "";
                        const name = this.dataset.name || "";
                        const photo = this.dataset.photo || "";
                        const dob = this.dataset.dob || "";
                        const nation = this.dataset.nation || "";
                        const desc = this.dataset.desc || "";
                        const gender = this.dataset.gender || "";

                        document.getElementById("editId").value = id;
                        document.getElementById("editName").value = name;
                        document.getElementById("editPhoto").value = photo;
                        document.getElementById("editDOB").value = dob;
                        document.getElementById("editNation").value = nation;
                        document.getElementById("editDesc").value = desc;
                        document.getElementById("editGender").value = gender;
                    });
                });

                const deleteModal = document.getElementById('deleteModal');
                if (deleteModal) {
                    deleteModal.addEventListener('show.bs.modal', function (event) {
                        const button = event.relatedTarget;
                        const performerId = button.getAttribute('data-id');
                        const performerName = button.getAttribute('data-name') || 'Unknown';

                        document.getElementById('deleteId').value = performerId;
                        document.getElementById('deleteMessage').innerHTML =
                                `Are you sure you want to delete <strong>${performerName}</strong>?`;
                    });
                }


            });

            document.querySelector('.search-box').addEventListener('submit', function (e) {
                const keyword = this.querySelector('input[name="keyword"]').value.trim();
                if (!keyword) {
                    e.preventDefault();
                    alert("Please enter a keyword before searching!");
                }
            });
        </script>
    </body>
</html>
