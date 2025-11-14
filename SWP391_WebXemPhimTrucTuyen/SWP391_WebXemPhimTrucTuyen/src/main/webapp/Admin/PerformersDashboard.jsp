<%-- 
    Document   : PerformersDashboard
    Created on : Oct 1, 2025
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:set var="PAGE_SIZE" value="10" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Performers Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/performersdashboard.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <%@ include file="Sidebar.jsp" %>

        <div class="content">
            <div class="topbar d-flex justify-content-between align-items-center mb-3">
                <h5 class="mb-0">Performers Management</h5>
                <button class="btn btn-netflix btn-sm" data-bs-toggle="modal" data-bs-target="#addModal">Thêm diễn viên</button>
            </div>

            <!-- Notifications -->
            <div class="notification-container">
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>Success!</strong> ${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Error!</strong>
                        <c:choose>
                            <c:when test="${fn:contains(sessionScope.error, ';')}">
                                <ul class="mb-0 ps-3">
                                    <c:forTokens items="${sessionScope.error}" delims=";" var="errorItem">
                                        <li>${errorItem}</li>
                                        </c:forTokens>
                                </ul>
                            </c:when>
                            <c:otherwise>${sessionScope.error}</c:otherwise>
                        </c:choose>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>
            </div>

            <!-- Search -->
            <form action="${pageContext.request.contextPath}/admin/performer" method="get" class="search-box mb-3 d-flex align-items-center">
                <input type="text" name="keyword" class="form-control bg-dark text-white" 
                       placeholder="Search performer..." value="${keyword}"/>
                <button type="submit" class="btn btn-danger btn-sm ms-2">Tìm</button>
                <button type="button" class="btn btn-secondary btn-sm ms-2"
                        onclick="window.location.href = '${pageContext.request.contextPath}/performer/series'">Manage Performer Series</button>
            </form>

            <!-- Performers Table -->
            <div class="card">
                <div class="card-body p-0">
                    <table class="table table-dark table-hover mb-0">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Tên</th>
                                <th>Mô tả</th>
                                <th>Quốc Gia</th>
                                <th>Hành Động</th>
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
                                        <i class="bi bi-inbox me-2"></i>Không tìm thấy diễn viên
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="performer" items="${performers}" varStatus="loop">
                                <tr>
                                    <td>${(currentPage - 1) * PAGE_SIZE + loop.index + 1}</td>
                                    <td><a href="${pageContext.request.contextPath}/performer/detail?id=${performer.performerID}" 
                                           class="text-decoration-none text-white fw-bold">${performer.name}</a></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(performer.description) > 30}">
                                                ${fn:substring(performer.description, 0, 30)}...
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${performer.description != null ? performer.description : 'No description available'}"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${performer.nationality}</td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-warning btn-edit" data-bs-toggle="modal" data-bs-target="#editModal"
                                                    data-id="${performer.performerID}" data-name="${fn:escapeXml(performer.name)}"
                                                    data-dob="${performer.dateOfBirth}" data-gender="${performer.gender}"
                                                    data-nation="${fn:escapeXml(performer.nationality)}" 
                                                    data-desc="${fn:escapeXml(performer.description)}" data-photo="${fn:escapeXml(performer.photoUrl)}">
                                                Sửa
                                            </button>
                                            <button class="btn btn-danger btn-delete" data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                    data-id="${performer.performerID}" data-name="${fn:escapeXml(performer.name)}"
                                                    data-page="${currentPage}" data-keyword="${keyword}">
                                                Xóa
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav class="mt-4 mb-4">
                            <ul class="pagination justify-content-center flex-wrap">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link bg-dark text-white border-secondary"
                                       href="${pageContext.request.contextPath}/admin/performer?page=${currentPage-1}${not empty keyword ? '&keyword=' : ''}${fn:escapeXml(keyword)}">
                                        <i class="bi bi-chevron-left"></i>
                                    </a>
                                </li>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link ${i==currentPage?'bg-danger border-danger text-white':'bg-dark text-white border-secondary'}"
                                           href="${pageContext.request.contextPath}/admin/performer?page=${i}${not empty keyword ? '&keyword=' : ''}${fn:escapeXml(keyword)}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link bg-dark text-white border-secondary"
                                       href="${pageContext.request.contextPath}/admin/performer?page=${currentPage+1}${not empty keyword ? '&keyword=' : ''}${fn:escapeXml(keyword)}">
                                        <i class="bi bi-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>

            <!-- Add Modal -->
            <div class="modal fade" id="addModal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content bg-dark text-white">
                        <div class="modal-header border-0">
                            <h5 class="modal-title">Thêm Diễn Viên</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="addForm" method="post" action="${pageContext.request.contextPath}/admin/performer"
                                  enctype="multipart/form-data" class="needs-validation" novalidate>
                                <input type="hidden" name="action" value="add"/>
                                <input type="hidden" name="currentPage" value="${currentPage}"/>
                                <input type="hidden" name="keyword" value="${keyword}"/>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tên <span class="text-danger">*</span></label>
                                        <input type="text" name="name" placeholder="Enter performer's name" 
                                               class="form-control bg-dark text-white"
                                               required pattern="^[\\p{L} .'-]+$" oninput="validateField(this)" onblur="validateField(this)"/>
                                        <div class="invalid-feedback">Vui lòng nhập đúng tên (không chứa số, ký tự đặc biệt)</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Ngày Sinh <span class="text-danger">*</span></label>
                                        <input type="date" name="date_of_birth" id="addDOB"
                                               class="form-control bg-dark text-white"
                                               required onchange="validateDateOfBirth(this)" onblur="validateDateOfBirth(this)"/>
                                        <div class="invalid-feedback">Ngày sinh không hợp lệ</div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Giới Tính <span class="text-danger">*</span></label>
                                        <select name="gender" class="form-select bg-dark text-white" required onchange="validateField(this)">
                                            <option value="" disabled selected>Chọn Giới Tính</option>
                                            <option value="Male">Nam</option>
                                            <option value="Female">Nữ</option>
                                        </select>
                                        <div class="invalid-feedback">Vui lòng chọn giới tính</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Quốc Tịch <span class="text-danger">*</span></label>
                                        <input type="text" name="nationality" class="form-control bg-dark text-white"
                                               placeholder="Enter nationality" required oninput="validateField(this)" onblur="validateField(this)"/>
                                        <div class="invalid-feedback">Vui lòng nhập quốc tịch</div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Ảnh <span class="text-danger">*</span></label>
                                    <input type="file" name="photo" accept="image/*"
                                           class="form-control bg-dark text-white" required
                                           onchange="previewImage(this, 'addPreview'); validateAddPhoto(this)"/>
                                    <div class="invalid-feedback">Vui lòng chọn ảnh hợp lệ</div>
                                    <div class="mt-2">
                                        <img id="addPreview" src="" alt="Preview" class="img-thumbnail d-none" style="max-height:150px"/>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Mô tả</label>
                                    <textarea name="description" class="form-control bg-dark text-white" rows="3"></textarea>
                                </div>

                                <div class="modal-footer border-0">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    <button type="submit" class="btn btn-danger">Thêm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Modal -->
            <div class="modal fade" id="editModal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content bg-dark text-white">
                        <div class="modal-header border-0">
                            <h5 class="modal-title">Sửa Diễn Viên</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form id="editForm" method="post" action="${pageContext.request.contextPath}/admin/performer"
                              enctype="multipart/form-data" class="needs-validation" novalidate>
                            <input type="hidden" name="action" value="edit"/>
                            <input type="hidden" id="editId" name="id"/>
                            <input type="hidden" id="existingPhoto" name="existingPhoto"/>
                            <input type="hidden" name="currentPage" value="${currentPage}"/>
                            <input type="hidden" name="keyword" value="${keyword}"/>

                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tên <span class="text-danger">*</span></label>
                                        <input type="text" id="editName" name="name" class="form-control bg-dark text-white"
                                               required pattern="^[\\p{L} .'-]+$" oninput="validateField(this)" onblur="validateField(this)"/>
                                        <div class="invalid-feedback">Vui lòng nhập tên hợp lệ</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Ngày Sinh <span class="text-danger">*</span></label>
                                        <input type="date" id="editDOB" name="date_of_birth" class="form-control bg-dark text-white"
                                               required onchange="validateDateOfBirth(this)" onblur="validateDateOfBirth(this)"/>
                                        <div class="invalid-feedback">Ngày sinh không hợp lệ</div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Giới Tính <span class="text-danger">*</span></label>
                                        <select id="editGender" name="gender" class="form-select bg-dark text-white"
                                                required onchange="validateField(this)">
                                            <option value="" disabled>Chọn giới tính</option>
                                            <option value="Male">Nam</option>
                                            <option value="Female">Nữ</option>
                                        </select>
                                        <div class="invalid-feedback">Vui lòng chọn giới tính</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Quốc Tịch <span class="text-danger">*</span></label>
                                        <input type="text" id="editNation" name="nationality" class="form-control bg-dark text-white"
                                               required
                                               pattern="^[a-zA-ZÀ-ỹà-ỹ ]+$"
                                               title="Chỉ được nhập chữ và khoảng trắng"
                                               oninput="validateField(this)" onblur="validateField(this)"/>

                                        <div class="invalid-feedback">Vui lòng nhập quốc tịch hợp lệ (không chứa số hoặc ký tự đặc biệt)</div>
                                    </div>

                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Ảnh</label>
                                    <input type="file" id="editPhotoFile" name="photo" accept="image/*"
                                           class="form-control bg-dark text-white" onchange="previewImage(this, 'editPreview'); validateEditPhoto(this)"/>
                                    <div class="mt-2">
                                        <img id="editPreview" src="" alt="Current Photo" class="img-thumbnail" style="max-height:150px"/>

                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Mô tả</label>
                                    <textarea id="editDesc" name="description" class="form-control bg-dark text-white" rows="3"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-danger">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Delete Modal -->
            <div class="modal fade" id="deleteModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content bg-dark text-white">
                        <div class="modal-header border-0">
                            <h5 class="modal-title">Xác nhận xóa diễn viên </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form method="post" action="${pageContext.request.contextPath}/admin/performer">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="id" id="deleteId"/>
                            <input type="hidden" name="currentPage" id="deletePage"/>
                            <input type="hidden" name="keyword" id="deleteKeyword"/>
                            <div class="modal-body text-center">
                                <i class="bi bi-exclamation-triangle text-warning display-4"></i>
                                <h5 class="mt-3 text-danger">Bạn chắc không ?</h5>
                                <p id="deleteMessage" class="text-light">Bạn sẽ xóa diễn viên:</p>
                                <p class="fw-bold text-danger" id="deletePerformerName"></p>
                                <p class="text-warning small">Hành động sẽ không thể khôi phục</p>
                            </div>
                            <div class="modal-footer border-0 justify-content-center">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-danger">Xóa</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                               function validateField(input) {
                                                   if (!input.checkValidity()) {
                                                       input.classList.add('is-invalid');
                                                   } else {
                                                       input.classList.remove('is-invalid');
                                                   }
                                               }


                                               function validateDateOfBirth(input) {
                                                   const today = new Date().toISOString().split('T')[0];
                                                   if (input.value && input.value > today) {
                                                       input.setCustomValidity("Ngày sinh không hợp lệ");
                                                       input.classList.add('is-invalid');
                                                   } else {
                                                       input.setCustomValidity("");
                                                       input.classList.remove('is-invalid');
                                                   }
                                               }

                                               function validateAddPhoto(fileField) {
                                                   fileField.classList.remove('is-invalid');
                                                   if (!fileField.files || fileField.files.length === 0)
                                                       return;
                                                   const file = fileField.files[0];
                                                   if (!file.type.startsWith("image/")) {
                                                       fileField.setCustomValidity("File không hợp lệ (chỉ nhận ảnh)");
                                                       fileField.classList.add("is-invalid");
                                                   } else {
                                                       fileField.setCustomValidity("");
                                                   }
                                                   previewImage(fileField, 'addPreview');
                                               }

                                               function validateEditPhoto(fileField) {
                                                   fileField.classList.remove('is-invalid');
                                                   if (!fileField.files || fileField.files.length === 0)
                                                       return;
                                                   const file = fileField.files[0];
                                                   if (!file.type.startsWith("image/")) {
                                                       fileField.setCustomValidity("File không hợp lệ (chỉ nhận ảnh)");
                                                       fileField.classList.add("is-invalid");
                                                   } else {
                                                       fileField.setCustomValidity("");
                                                   }
                                                   previewImage(fileField, 'editPreview');
                                               }

                                               function previewImage(input, previewId) {
                                                   const preview = document.getElementById(previewId);
                                                   if (input.files && input.files[0]) {
                                                       const reader = new FileReader();
                                                       reader.onload = function (e) {
                                                           preview.src = e.target.result;
                                                           preview.classList.remove('d-none');
                                                       }
                                                       reader.readAsDataURL(input.files[0]);
                                                   }
                                               }
                                               document.getElementById('editNation').addEventListener('input', function () {
                                                   this.value = this.value.replace(/[^a-zA-ZÀ-ỹà-ỹ .'-]/g, '');
                                               });

                                               const editModal = document.getElementById('editModal');
                                               editModal.addEventListener('show.bs.modal', function (event) {
                                                   const button = event.relatedTarget;
                                                   document.getElementById('editId').value = button.getAttribute('data-id');
                                                   document.getElementById('editName').value = button.getAttribute('data-name');
                                                   document.getElementById('editDOB').value = button.getAttribute('data-dob');
                                                   document.getElementById('editGender').value = button.getAttribute('data-gender');
                                                   document.getElementById('editNation').value = button.getAttribute('data-nation');
                                                   document.getElementById('editDesc').value = button.getAttribute('data-desc');
                                                   const photo = button.getAttribute('data-photo');
                                                   const preview = document.getElementById('editPreview');
                                                   if (photo && photo.trim() !== '') {
                                                       preview.src = '${pageContext.request.contextPath}/' + photo;
                                                       preview.classList.remove('d-none');
                                                       document.getElementById('existingPhoto').value = photo;
                                                   } else {
                                                       preview.src = '';
                                                       preview.classList.add('d-none');
                                                       document.getElementById('existingPhoto').value = '';
                                                   }
                                               });

                                               const deleteModal = document.getElementById('deleteModal');
                                               deleteModal.addEventListener('show.bs.modal', function (event) {
                                                   const button = event.relatedTarget;
                                                   document.getElementById('deleteId').value = button.getAttribute('data-id');
                                                   document.getElementById('deletePerformerName').textContent = button.getAttribute('data-name');
                                                   document.getElementById('deletePage').value = button.getAttribute('data-page');
                                                   document.getElementById('deleteKeyword').value = button.getAttribute('data-keyword');
                                               });

                                               (function () {
                                                   'use strict'
                                                   var forms = document.querySelectorAll('.needs-validation')
                                                   Array.prototype.slice.call(forms).forEach(function (form) {
                                                       form.addEventListener('submit', function (event) {
                                                           if (!form.checkValidity()) {
                                                               event.preventDefault();
                                                               event.stopPropagation();
                                                           }
                                                           form.classList.add('was-validated');
                                                       }, false)
                                                   });
                                               })();
        </script>
    </body>
</html>
