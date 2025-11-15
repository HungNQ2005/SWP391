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
        <link href="http://localhost:8080/SWP391_WebXemPhimTrucTuyen/css/performersdashboard.css" rel="stylesheet" type="text/css"/>

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


                <div class="notification-container">
                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                <strong>Success!</strong> ${sessionScope.success}
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="success" scope="session" />
                    </c:if>

                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                <strong>Error!</strong> 
                                <c:choose>
                                    <c:when test="${fn:contains(sessionScope.error, ';')}">
                                        <ul class="mb-0 ps-3">
                                            <c:forTokens items="${sessionScope.error}" delims=";" var="errorItem">
                                                <li>${errorItem}</li>
                                                </c:forTokens>
                                        </ul>
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.error}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="error" scope="session" />
                    </c:if>
                </div>

                <!-- Searching -->
                <form action="${pageContext.request.contextPath}/admin/performer" method="get" class="search-box mb-3 d-flex align-items-center">
                    <input type="text" name="keyword" class="form-control bg-dark text-white" 
                           placeholder="Search performer..." value="${keyword}" />
                    <button type="submit" class="btn btn-danger btn-sm ms-2">Search</button>
                    <button type="button" class="btn btn-secondary btn-sm ms-2"
                            onclick="window.location.href = '${pageContext.request.contextPath}/performer/series'">
                        Manage Performer Series
                    </button>
                </form>

                <!-- Table -->
                <div class="card">
                    <div class="card-body p-0">
                        <table class="table table-dark table mb-0">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Nationality</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${not empty message}">
                                    <tr>
                                        <td colspan="5" class="text-center text-warning fw-bold py-4">
                                            <i class="bi bi-search me-2"></i>${message}
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${empty performers and empty message}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox me-2"></i>No performers found
                                        </td>
                                    </tr>
                                </c:if>
                                <c:forEach var="performer" items="${performers}" varStatus="loop">
                                    <tr> 
                                        <td>${(currentPage - 1) * PAGE_SIZE + loop.index + 1}</td> 
                                        <td>
                                            <a href="${pageContext.request.contextPath}/performer/detail?id=${performer.performerID}"
                                               class="text-decoration-none text-white fw-bold performer-name">
                                                ${performer.name}
                                            </a>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fn:length(performer.description) > 30}">
                                                    ${fn:substring(performer.description, 0, 30)}...
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="${performer.description != null ? performer.description : 'No description available'}" />
                                                </c:otherwise> 
                                            </c:choose>
                                        </td>
                                        <td>${performer.nationality}</td>
                                        <td>
                                            <div class="btn-group btn-group-sm" role="group">
                                                <button class="btn btn-warning btn-edit"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#editModal"
                                                        data-id="${performer.performerID}"
                                                        data-name="${fn:escapeXml(performer.name)}"
                                                        data-dob="${performer.dateOfBirth}"
                                                        data-gender="${performer.gender}"
                                                        data-nation="${fn:escapeXml(performer.nationality)}"
                                                        data-desc="${fn:escapeXml(performer.description)}"
                                                        data-photo="${fn:escapeXml(performer.photoUrl)}">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </button>
                                                <button class="btn btn-danger btn-delete"
                                                        data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                        data-id="${performer.performerID}"
                                                        data-name="${fn:escapeXml(performer.name)}"
                                                        data-page="${currentPage}"
                                                        data-keyword="${keyword}">
                                                    <i class="bi bi-trash"></i> Delete
                                                </button>
                                            </div>
                                        </td>
                                    </tr> 
                                </c:forEach>
                            </tbody>                  
                        </table>
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Performers Page Navigation" class="mt-4 mb-4">
                                <ul class="pagination justify-content-center flex-wrap">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link bg-dark text-white border-secondary" 
                                           href="${pageContext.request.contextPath}/admin/performer?page=${currentPage - 1}${not empty keyword ? '&keyword=' : ''}${fn:escapeXml(keyword)}" 
                                           tabindex="-1">
                                            <i class="bi bi-chevron-left"></i>
                                        </a>
                                    </li>
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link ${i == currentPage ? 'bg-danger border-danger text-white' : 'bg-dark text-white border-secondary'}" 
                                               href="${pageContext.request.contextPath}/admin/performer?page=${i}${not empty keyword ? '&keyword=' : ''}${fn:escapeXml(keyword)}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link bg-dark text-white border-secondary" 
                                           href="${pageContext.request.contextPath}/admin/performer?page=${currentPage + 1}${not empty keyword ? '&keyword=' : ''}${fn:escapeXml(keyword)}">
                                            <i class="bi bi-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- ADD Modal  -->
            <div class="modal fade" id="addModal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content bg-dark text-white">
                        <div class="modal-header border-0">
                            <h5 class="modal-title">Add Performer</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/admin/performer" 
                                  method="post" enctype="multipart/form-data" id="addForm" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="currentPage" value="${currentPage}" />
                                <input type="hidden" name="keyword" value="${keyword}" />

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Name <span class="text-danger">*</span></label>
                                            <input type="text" name="name" placeholder="Enter performer's name"
                                                   class="form-control bg-dark text-white" 
                                                   required 
                                                   pattern="^[\\p{L} .'-]+$"
                                                   oninput="validateField(this)"
                                                   onblur="validateField(this)" />
                                            <div class="invalid-feedback">
                                                Please enter a valid name (only letters and symbols like .'-)
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                            <input type="date" name="date_of_birth" id="addDOB"
                                                   class="form-control bg-dark text-white" 
                                                   required 
                                                   onchange="validateDateOfBirth(this)"
                                                   onblur="validateDateOfBirth(this)" />
                                            <div class="invalid-feedback">
                                                Date of birth cannot be in the future and must be valid.
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Gender <span class="text-danger">*</span></label>
                                            <select name="gender" class="form-select bg-dark text-white" 
                                                    required 
                                                    onchange="validateField(this)">
                                                <option value="" disabled selected>Select gender</option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                            <div class="invalid-feedback">
                                                Please select a gender.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Nationality <span class="text-danger">*</span></label>
                                            <input type="text" name="nationality" placeholder="Enter nationality"
                                                   class="form-control bg-dark text-white" 
                                                   required 
                                                   oninput="validateField(this)"
                                                   onblur="validateField(this)" />
                                            <div class="invalid-feedback">
                                                Please enter a nationality.
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Photo <span class="text-danger">*</span></label>
                                    <input type="file" name="photo" accept="image/*"
                                           class="form-control bg-dark text-white" 
                                           required 
                                           onchange="previewImage(this, 'addPreview'); validateAddPhoto(this)" />
                                    <div class="invalid-feedback">
                                        Please choose a photo.
                                    </div>
                                    <div class="mt-2">
                                        <img id="addPreview" src="" alt="Preview" class="img-thumbnail d-none" style="max-height: 150px;">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea name="description" placeholder="Short introduction about performer"
                                              class="form-control bg-dark text-white" rows="3"></textarea>
                                </div>

                                <div class="modal-footer border-0">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-danger" id="addSubmitBtn">Add Performer</button>
                                </div>
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
                              action="${pageContext.request.contextPath}/admin/performer"
                              enctype="multipart/form-data" class="needs-validation" novalidate>
                            <input type="hidden" name="action" value="edit" />
                            <input type="hidden" id="editId" name="id" />
                            <input type="hidden" id="existingPhoto" name="existingPhoto" />
                            <input type="hidden" name="currentPage" value="${currentPage}" />
                            <input type="hidden" name="keyword" value="${keyword}" />

                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Name <span class="text-danger">*</span></label>
                                            <input type="text" id="editName" name="name"
                                                   class="form-control bg-dark text-white" 
                                                   required 
                                                   pattern="^[\\p{L} .'-]+$"
                                                   oninput="validateField(this)"
                                                   onblur="validateField(this)" />
                                            <div class="invalid-feedback">
                                                Please enter a valid name (only letters and symbols like .'-)
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                            <input type="date" id="editDOB" name="date_of_birth"
                                                   class="form-control bg-dark text-white" 
                                                   required 
                                                   onchange="validateDateOfBirth(this)"
                                                   onblur="validateDateOfBirth(this)" />
                                            <div class="invalid-feedback">
                                                Date of birth cannot be in the future and must be valid.
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Gender <span class="text-danger">*</span></label>
                                            <select id="editGender" name="gender"
                                                    class="form-select bg-dark text-white" 
                                                    required 
                                                    onchange="validateField(this)">
                                                <option value="" disabled>Select gender</option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                            <div class="invalid-feedback">
                                                Please select a gender.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Nationality <span class="text-danger">*</span></label>
                                            <input type="text" id="editNation" name="nationality"
                                                   class="form-control bg-dark text-white" 
                                                   required 
                                                   oninput="validateField(this)"
                                                   onblur="validateField(this)" />
                                            <div class="invalid-feedback">
                                                Please enter a nationality.
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Photo</label>
                                    <input type="file" id="editPhotoFile" name="photo"
                                           class="form-control bg-dark text-white" accept="image/*" 
                                           onchange="previewImage(this, 'editPreview'); validateEditPhoto(this)" />
                                    <div class="mt-2">
                                        <img id="editPreview" src="" alt="Current Photo" class="img-thumbnail" style="max-height: 150px;">
                                        <div class="form-text text-muted">Leave empty to keep current photo</div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea id="editDesc" name="description"
                                              class="form-control bg-dark text-white" rows="3"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger" id="editSubmitBtn">Save Changes</button>
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
                            <h5 class="modal-title">Confirm Deletion</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form method="post" action="${pageContext.request.contextPath}/admin/performer">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="id" id="deleteId" />
                            <input type="hidden" name="currentPage" id="deletePage" />
                            <input type="hidden" name="keyword" id="deleteKeyword" />
                            <div class="modal-body text-center">
                                <i class="bi bi-exclamation-triangle text-warning display-4"></i>
                                <h5 class="mt-3">Are you sure?</h5>
                                <p id="deleteMessage" class="text-muted">You are about to delete:</p>
                                <p class="fw-bold text-danger" id="deletePerformerName"></p>
                                <p class="text-warning small">This action cannot be undone.</p>
                            </div>
                            <div class="modal-footer border-0 justify-content-center">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger">Delete Permanently</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {

                    const alerts = document.querySelectorAll('.alert');
                    alerts.forEach(alert => {
                        setTimeout(() => {
                            const bsAlert = new bootstrap.Alert(alert);
                            bsAlert.close();
                        }, 5000);
                    });
                    const existingPhotos = [
                <c:forEach var="performer" items="${performers}" varStatus="loop">
                    "${performer.photoUrl}"<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
                    ];

                    // EDIT Modal
                    const editModal = document.getElementById('editModal');
                    editModal.addEventListener('show.bs.modal', event => {
                        const button = event.relatedTarget;
                        const id = button.getAttribute('data-id');
                        const name = button.getAttribute('data-name');
                        const dob = button.getAttribute('data-dob');
                        const gender = button.getAttribute('data-gender');
                        const nation = button.getAttribute('data-nation');
                        const desc = button.getAttribute('data-desc');
                        const photo = button.getAttribute('data-photo');

                        document.getElementById('editId').value = id;
                        document.getElementById('editName').value = name;
                        document.getElementById('editDOB').value = dob;
                        document.getElementById('editGender').value = gender;
                        document.getElementById('editNation').value = nation;
                        document.getElementById('editDesc').value = desc.trim();
                        document.getElementById('existingPhoto').value = photo;


                        resetValidation('editForm');


                        const preview = document.getElementById('editPreview');
                        if (photo) {
                            preview.src = '${pageContext.request.contextPath}/' + photo;
                            preview.classList.remove('d-none');
                        } else {
                            preview.classList.add('d-none');
                        }
                    });

                    // DELETE Modal
                    const deleteModal = document.getElementById('deleteModal');
                    if (deleteModal) {
                        deleteModal.addEventListener('show.bs.modal', function (event) {
                            const button = event.relatedTarget;
                            const performerId = button.getAttribute('data-id') || "";
                            const performerName = button.getAttribute('data-name') || 'Unknown';
                            const currentPage = button.getAttribute('data-page') || 1;
                            const keyword = button.getAttribute('data-keyword') || '';

                            document.getElementById('deleteId').value = performerId;
                            document.getElementById('deletePage').value = currentPage;
                            document.getElementById('deleteKeyword').value = keyword;
                            document.getElementById('deletePerformerName').textContent = performerName;
                        });
                    }

                    const forms = document.querySelectorAll('.needs-validation');
                    forms.forEach(form => {
                        form.addEventListener('submit', function (e) {
                            if (!this.checkValidity()) {
                                e.preventDefault();
                                e.stopPropagation();
                            }
                            this.classList.add('was-validated');
                        });
                    });


                    const addModal = document.getElementById('addModal');
                    addModal.addEventListener('hidden.bs.modal', function () {
                        resetValidation('addForm');
                        document.getElementById('addPreview').classList.add('d-none');
                    });

                    editModal.addEventListener('hidden.bs.modal', function () {
                        resetValidation('editForm');
                    });


                    const searchForm = document.querySelector('.search-box');
                    if (searchForm) {
                        searchForm.addEventListener('submit', function (e) {
                            const keyword = this.querySelector('input[name="keyword"]').value.trim();
                            if (!keyword) {
                                e.preventDefault();
                                window.location.href = '${pageContext.request.contextPath}/admin/performer?page=1';
                            }
                        });
                    }
                });

                function validateField(field) {
                    field.classList.remove('is-valid', 'is-invalid');

                    if (!field.checkValidity()) {
                        field.classList.add('is-invalid');
                    }

                }

                function validateDateOfBirth(dateField) {
                    const selectedDate = new Date(dateField.value);
                    const today = new Date();

                    dateField.classList.remove('is-valid', 'is-invalid');

                    if (!dateField.value) {
                        dateField.classList.add('is-invalid');
                        return;
                    }

                    if (selectedDate > today) {
                        dateField.setCustomValidity('Date of birth cannot be in the future');
                        dateField.classList.add('is-invalid');
                    } else {
                        dateField.setCustomValidity('');

                    }
                }

                function validateEditPhoto(fileField) {
                    fileField.classList.remove('is-valid', 'is-invalid');

                    if (!fileField.files || fileField.files.length === 0) {

                    } else {
                        const file = fileField.files[0];
                        if (file && file.type.startsWith('image/')) {

                        } else {
                            fileField.setCustomValidity('Please select a valid image file');
                            fileField.classList.add('is-invalid');
                        }
                    }
                }

                function resetValidation(formId) {
                    const form = document.getElementById(formId);
                    if (form) {
                        form.classList.remove('was-validated');
                        const inputs = form.querySelectorAll('.form-control, .form-select');
                        inputs.forEach(input => {
                            input.classList.remove('is-valid', 'is-invalid');
                        });
                    }
                }

                // Image preview function
                function previewImage(input, previewId) {
                    const preview = document.getElementById(previewId);
                    const file = input.files[0];

                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            preview.src = e.target.result;
                            preview.classList.remove('d-none');
                        }
                        reader.readAsDataURL(file);
                    } else {
                        preview.src = '';
                        preview.classList.add('d-none');
                    }
                }
            </script> 
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>