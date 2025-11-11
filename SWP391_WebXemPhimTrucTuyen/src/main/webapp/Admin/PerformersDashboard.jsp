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
        <link href="http://localhost:8080/Perfomers/css/performersdashboard.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <!-- Sidebar -->
        <%@ include file="Sidebar.jsp" %>
        <!-- Main Content -->
        <div class="content">
            <div class="content">
                <div class="topbar d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Performers Management</h5>
                    <button class="btn btn-netflix btn-sm" data-bs-toggle="modal" data-bs-target="#addModal">+ Add Performer</button>
                </div>
                <!-- Searching -->
                <form action="${pageContext.request.contextPath}/performer/admin" method="get" class="search-box mb-3 d-flex align-items-center">
                    <input type="text" name="keyword" class="form-control bg-dark text-white" 
                           placeholder="Search performer..." value="${keyword}" />
                    <button type="submit" class="btn btn-danger btn-sm ms-2">Search</button>
                    <button type="button" class="btn btn-secondary btn-sm ms-2"
                            onclick="window.location.href = '${pageContext.request.contextPath}/performer/series'">
                        Manage Performer Series
                    </button>
                </form>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="error" scope="session" />
                </c:if>
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="success" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
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
                                    <th>Description</th>
                                    <th>Nationality </th>
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
                                        <td>${performer.performerID}</td> 
                                        <td>
                                            <a href="${pageContext.request.contextPath}/performer/detail?id=${performer.performerID}"

                                               class="text-decoration-none text-white fw-bold">
                                                ${performer.name}
                                            </a>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fn:length(performer.description) > 30}">
                                                    ${fn:substring(performer.description, 0,30)}...
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="${performer.description != null ? performer.description : 'No description available'}" />
                                                </c:otherwise> 
                                            </c:choose>
                                        </td>
                                        <td>
                                            ${performer.nationality}
                                        </td>
                                        <td>
                                            <button class="btn btn-warning"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#editModal"
                                                    data-id="${performer.performerID}"
                                                    data-name="${fn:escapeXml(performer.name)}"
                                                    data-dob="${performer.dateOfBirth}"
                                                    data-gender="${performer.gender}"
                                                    data-nation="${fn:escapeXml(performer.nationality)}"
                                                    data-desc="${fn:escapeXml(performer.description)}"
                                                    data-photo="${fn:escapeXml(performer.photoUrl)}">
                                                Edit
                                            </button>
                                            <button class="btn btn-danger btn-sm"
                                                    data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                    data-id="${performer.performerID}"
                                                    data-name="${performer.name}"
                                                    data-page="${currentPage}"
                                                    data-keyword="${keyword}">
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
                                       href="${pageContext.request.contextPath}/performer/admin?page=${currentPage - 1}${not empty keyword ? '&keyword=' : ''}${keyword}" 
                                       tabindex="-1">
                                        <i class="bi bi-chevron-left"></i>
                                    </a>
                                </li>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link ${i == currentPage ? 'bg-danger border-danger text-white' : 'bg-dark text-white border-secondary'}" 
                                           href="${pageContext.request.contextPath}/performer/admin?page=${i}${not empty keyword ? '&keyword=' : ''}${keyword}">
                                            ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link bg-dark text-white border-secondary" 
                                       href="${pageContext.request.contextPath}/performer/admin?page=${currentPage + 1}${not empty keyword ? '&keyword=' : ''}${keyword}">
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
                            <form action="${pageContext.request.contextPath}/performer/admin" 
                                  method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="add" />
                                <div class="mb-3">
                                    <label class="form-label">Name</label>
                                    <input type="text" name="name" placeholder="Enter performer's name"
                                           class="form-control bg-dark text-white" required />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Date of Birth</label>
                                    <input type="date" name="date_of_birth"
                                           class="form-control bg-dark text-white" required />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Gender</label>
                                    <select name="gender" class="form-select bg-dark text-white" required>
                                        <option value="" disabled selected>Select gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Photo</label>

                                    <input type="file" name="photo" accept="image/*"
                                           class="form-control bg-dark text-white" required />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Nationality</label>
                                    <input type="text" name="nationality" placeholder="Enter nationality"
                                           class="form-control bg-dark text-white" required />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea name="description" placeholder="Short introduction about performer"
                                              class="form-control bg-dark text-white" rows="3"></textarea>
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

                        <form id="editForm" method="post"
                              action="${pageContext.request.contextPath}/performer/admin"
                              enctype="multipart/form-data">
                            <input type="hidden" name="action" value="edit" />
                            <input type="hidden" id="editId" name="id" />
                            <input type="hidden" id="existingPhoto" name="existingPhoto" />

                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Name</label>
                                    <input type="text" id="editName" name="name"
                                           class="form-control bg-dark text-white" required />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Date of Birth</label>
                                    <input type="date" id="editDOB" name="date_of_birth"
                                           class="form-control bg-dark text-white" required />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Gender</label>
                                    <select id="editGender" name="gender"
                                            class="form-select bg-dark text-white" required>
                                        <option value="" disabled>Select gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Nationality</label>
                                    <input type="text" id="editNation" name="nationality"
                                           class="form-control bg-dark text-white" required />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Photo</label>
                                    <input type="file" id="editPhotoFile" name="photo"
                                           class="form-control bg-dark text-white" accept="image/*" />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea id="editDesc" name="description"
                                              class="form-control bg-dark text-white" rows="3">
                                    </textarea>
                                </div>
                            </div>

                            <div class="modal-footer border-0">
                                <button type="submit" class="btn btn-danger">Save Changes</button>
                            </div>
                        </form>
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
                        <form method="post" action="${pageContext.request.contextPath}/performer/admin">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="id" id="deleteId" />
                            <input type="hidden" name="currentPage" id="deletePage" />
                            <input type="hidden" name="keyword" id="deleteKeyword" />
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
            <script src="../js/performeradmin.js" type="text/javascript"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
