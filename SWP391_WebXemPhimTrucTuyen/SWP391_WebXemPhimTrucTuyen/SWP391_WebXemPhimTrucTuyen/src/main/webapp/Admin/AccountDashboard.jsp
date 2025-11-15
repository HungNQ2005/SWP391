<%-- 
    Document   : AccountDashboard.jsp
    Created on : Oct 4, 2025, 10:11:46 AM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Account</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
            rel="stylesheet"
            />

        <!-- NEW -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/AccountDashboard.css" />

    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="Sidebar.jsp" %>
        <!-- Main Content -->
        <div class="content">
            <!-- Topbar -->
            <div class="topbar d-flex justify-content-between align-items-center mb-3">
                <h5 class="mb-0">Accounts Management</h5>
                <button
                    class="btn btn-primary btn-sm"
                    data-bs-toggle="modal"
                    data-bs-target="#addModal">
                    + Add Account
                </button>
            </div>

            <!-- Search -->
            <div class="mb-3">
                <div class="input-group search-box">
                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                    <input
                        type="text"
                        class="form-control"
                        placeholder="Tìm kiếm tài khoản..."/>
                </div>
            </div>

            <!-- Table -->
            <div class="card">
                <div class="card-body p-0">
                    <table class="table table-dark table-striped mb-0" id="accountTable">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>UserName</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}">
                                <tr>
                                    <td>${u.user_id}</td>
                                    <td>${u.username}</td>
                                    <td>${u.email}</td>
                                    <td><span class="badge bg-warning">${u.user_level}</span></td>
                                    <td>
                                        <!-- Edit button -->
                                        <button 
                                            type="button"
                                            class="btn btn-success btn-sm editBtn"
                                            data-id="${u.user_id}"
                                            data-username="${u.username}"
                                            data-email="${u.email}"
                                            data-role="${u.user_level}">
                                            Edit
                                        </button>

                                        <!-- Delete button -->
                                        <button 
                                            type="button"
                                            class="btn btn-danger btn-sm deleteBtn"
                                            data-id="${u.user_id}">
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <nav aria-label="Page navigation" class="mt-3">
                        <ul class="pagination justify-content-center">

                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="account?action=sendAccountDashboard&page=${currentPage - 1}">Previous</a>
                                </li>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="account?action=sendAccountDashboard&page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="account?action=sendAccountDashboard&page=${currentPage + 1}">Next</a>
                                </li>
                            </c:if>

                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Account</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addForm" action="account" method="post" novalidate>
                            <input type="hidden" name="action" value="insert">

                            <div class="mb-3">
                                <label>UserName</label>
                                <input type="text" class="form-control" id="addUserName" name="username" required/>
                                <div class="invalid-feedback">UserName phải từ 3-20 ký tự và không chứa ký tự đặc biệt.</div>
                            </div>

                            <div class="mb-3">
                                <label>Password</label>
                                <input type="password" class="form-control" id="addPassword" name="password" required/>
                                <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự.</div>
                            </div>

                            <div class="mb-3">
                                <label>Email</label>
                                <input type="email" class="form-control" id="addEmail" name="email" required/>
                                <div class="invalid-feedback">Email không hợp lệ.</div>
                            </div>

                            <div class="mb-3">
                                <label>Full Name</label>
                                <input type="text" class="form-control" id="addFullName" name="full_name" required/>
                                <div class="invalid-feedback">Vui lòng nhập họ tên.</div>
                            </div>

                            <div class="mb-3">
                                <label>Role</label>
                                <select class="form-select" id="addRole" name="user_level">
                                    <option value="Admin">Admin</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Add</button>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger mt-3">${errorMessage}</div>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Account</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editForm" novalidate>
                            <input type="hidden" id="editId" name="user_id" />
                            <div class="mb-3">
                                <label>UserName</label>
                                <input type="text" class="form-control" id="editUserName" name="username" required/>
                                <div class="invalid-feedback">UserName phải từ 3-20 ký tự và không chứa ký tự đặc biệt.</div>
                            </div>
                            <div class="mb-3">
                                <label>Password</label>
                                <input type="password" class="form-control" id="editPassword" name="password" required/>
                                <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự.</div>
                            </div>
                            <div class="mb-3">
                                <label>Email</label>
                                <input type="email" class="form-control" id="editEmail" name="email" required/>
                                <div class="invalid-feedback">Email không hợp lệ.</div>
                            </div>
                            <div class="mb-3">
                                <label>Role</label>
                                <select class="form-select" id="editRole" name="user_level">
                                    <option value="Admin">Admin</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-success">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- DELETE MODAL (thêm vào để tránh lỗi khi script tham chiếu tới #deleteModal/#confirmDelete) -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm Delete</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc muốn xóa tài khoản này không?
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="cancelDelete" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" id="confirmDelete" class="btn btn-danger">Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // ======== VALIDATION UTILS ========
            function showError(input, message) {
                if (!input)
                    return;
                const parent = input.parentElement;
                const feedback = parent ? parent.querySelector('.invalid-feedback') : null;
                input.classList.add('is-invalid');
                input.classList.remove('is-valid');
                if (feedback) {
                    feedback.innerText = message;
                    feedback.classList.add('d-block'); // make feedback visible
                }
            }

            function clearError(input) {
                if (!input)
                    return;
                const parent = input.parentElement;
                const feedback = parent ? parent.querySelector('.invalid-feedback') : null;
                input.classList.remove('is-invalid');
                if (feedback) {
                    feedback.innerText = '';
                    feedback.classList.remove('d-block');
                }
            }

            function showSuccess(input) {
                if (!input)
                    return;
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
                const parent = input.parentElement;
                const feedback = parent ? parent.querySelector('.invalid-feedback') : null;
                if (feedback) {
                    feedback.classList.remove('d-block');
                }
            }

            function isEmpty(value) {
                return !value || value.trim().length === 0;
            }

            // Kiểm tra Email bằng Regex (chấp nhận domain dài hơn 2 ký tự)
            function checkEmail(input) {
                if (!input)
                    return false;
                const val = input.value.trim();
                if (isEmpty(val)) {
                    showError(input, 'Email là bắt buộc.');
                    return false;
                }
                const re = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
                if (re.test(val)) {
                    showSuccess(input);
                    return true;
                } else {
                    showError(input, 'Email không đúng định dạng (vd: abc@gmail.com)');
                    return false;
                }
            }

            // Kiểm tra Username (không dấu cách, không ký tự đặc biệt, 3-20 ký tự)
            function checkUsername(input) {
                if (!input)
                    return false;
                const val = input.value.trim();
                if (isEmpty(val)) {
                    showError(input, 'Username là bắt buộc.');
                    return false;
                }
                const re = /^[a-zA-Z0-9_]{3,20}$/;
                if (re.test(val)) {
                    showSuccess(input);
                    return true;
                } else {
                    showError(input, 'Username 3-20 ký tự, không chứa dấu cách/ký tự đặc biệt.');
                    return false;
                }
            }

            // Kiểm tra độ dài (cho Password, Fullname)
            function checkLength(input, min, max, fieldName) {
                if (!input)
                    return false;
                const len = input.value.trim().length;
                if (len === 0) {
                    showError(input, `${fieldName} là bắt buộc.`);
                    return false;
                } else if (len < min) {
                    showError(input, `${fieldName} phải có ít nhất ${min} ký tự.`);
                    return false;
                } else if (len > max) {
                    showError(input, `${fieldName} không được quá ${max} ký tự.`);
                    return false;
                } else {
                    showSuccess(input);
                    return true;
                }
            }

            // Reset validation state for all inputs in a form
            function resetValidation(form) {
                if (!form)
                    return;
                const inputs = form.querySelectorAll('input, select, textarea');
                inputs.forEach(inp => {
                    inp.classList.remove('is-invalid', 'is-valid');
                    const parent = inp.parentElement;
                    const feedback = parent ? parent.querySelector('.invalid-feedback') : null;
                    if (feedback) {
                        feedback.innerText = '';
                        feedback.classList.remove('d-block');
                    }
                });
            }

            // Attach live validation handlers to inputs (input/blur)
            function attachLiveValidation(input, validatorFn) {
                if (!input || typeof validatorFn !== 'function')
                    return;
                input.addEventListener('input', function () {
                    validatorFn(input);
                });
                input.addEventListener('blur', function () {
                    validatorFn(input);
                });
            }

            // ======== ADD FORM VALIDATION ========
            const addForm = document.getElementById('addForm');
            if (addForm) {
                const addUsername = document.getElementById('addUserName');
                const addEmail = document.getElementById('addEmail');
                const addPassword = document.getElementById('addPassword');
                const addFullName = document.getElementById('addFullName');

                // Attach live validators
                attachLiveValidation(addUsername, checkUsername);
                attachLiveValidation(addEmail, checkEmail);
                attachLiveValidation(addPassword, function (el) {
                    return checkLength(el, 6, 50, 'Password');
                });
                attachLiveValidation(addFullName, function (el) {
                    return checkLength(el, 1, 100, 'Full Name');
                });

                addForm.addEventListener('submit', function (e) {
                    e.preventDefault();

                    let isValid = true;

                    if (!checkUsername(addUsername))
                        isValid = false;
                    if (!checkEmail(addEmail))
                        isValid = false;
                    if (!checkLength(addPassword, 6, 50, 'Password'))
                        isValid = false;
                    if (!checkLength(addFullName, 1, 100, 'Full Name'))
                        isValid = false;

                    if (isValid) {
                        // before submit, remove any temporary validation UI if desired
                        addForm.submit();
                    } else {
                        // focus first invalid
                        const firstInvalid = addForm.querySelector('.is-invalid');
                        if (firstInvalid)
                            firstInvalid.focus();
                    }
                });

                // Clear validation state when modal is hidden
                const addModalEl = document.getElementById('addModal');
                if (addModalEl) {
                    addModalEl.addEventListener('hidden.bs.modal', function () {
                        resetValidation(addForm);
                        addForm.reset();
                    });
                }
            }

            // ======== EDIT FORM VALIDATION & SUBMIT ========
            const editForm = document.getElementById('editForm');
            if (editForm) {
                const editId = document.getElementById('editId');
                const editUsername = document.getElementById('editUserName');
                const editPassword = document.getElementById('editPassword');
                const editEmail = document.getElementById('editEmail');
                const editRole = document.getElementById('editRole');

                attachLiveValidation(editUsername, checkUsername);
                attachLiveValidation(editEmail, checkEmail);

                // Populate Modal Logic (Giữ nguyên code cũ của bạn) nhưng reset validation before show
                document.addEventListener("click", function (e) {
                    if (e.target.classList.contains("editBtn")) {
                        const btn = e.target;
                        // Reset validation state khi mở modal
                        resetValidation(editForm);

                        editId.value = btn.getAttribute("data-id");
                        editUsername.value = btn.getAttribute("data-username");
                        editEmail.value = btn.getAttribute("data-email");
                        editRole.value = btn.getAttribute("data-role");
                        editPassword.value = "";
                        new bootstrap.Modal(document.getElementById("editModal")).show();
                    }
                });

                editForm.addEventListener("submit", function (e) {
                    e.preventDefault();

                    let isValid = true;

                    if (!checkUsername(editUsername))
                        isValid = false;
                    if (!checkEmail(editEmail))
                        isValid = false;
                    const passLen = editPassword.value.trim().length;
                    if (passLen > 0 && passLen < 6) {
                        editPassword.classList.add("is-invalid");
                        isValid = false;
                    }
                    if (!isValid) {
                        const firstInvalid = editForm.querySelector('.is-invalid');
                        if (firstInvalid)
                            firstInvalid.focus();
                        return;
                    }

                    // Build POST parameters
                    const data = new URLSearchParams();
                    data.append("action", "update");
                    data.append("user_id", editId.value);
                    data.append("username", editUsername.value.trim());
                    data.append("email", editEmail.value.trim());
                    data.append("user_level", editRole.value);
                    data.append("password", editPassword.value.trim()); 
                    fetch("account", {
                        method: "POST",
                        body: data,
                        headers: {
                            // Let server treat it as form data
                            'Accept': 'text/html, application/xhtml+xml'
                        }
                    })
                            .then(response => {
                                // if server returns redirect or HTML, just reload
                                location.reload();
                            })
                            .catch(err => {
                                console.error('Update failed', err);
                                // show an inline error if desired (not implemented server-side)
                            });
                });

                const editModalEl = document.getElementById('editModal');
                if (editModalEl) {
                    editModalEl.addEventListener('hidden.bs.modal', function () {
                        resetValidation(editForm);
                    });
                }
            }

            // ======== DELETE FUNCTION (Giữ nguyên code cũ) ========
            let userToDelete = null;
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("deleteBtn")) {
                    userToDelete = e.target.getAttribute("data-id");
                    const modalElement = document.getElementById("deleteModal");
                    if (modalElement)
                        new bootstrap.Modal(modalElement).show();
                }
            });

            const confirmDeleteBtn = document.getElementById("confirmDelete");
            if (confirmDeleteBtn) {
                confirmDeleteBtn.addEventListener("click", function () {
                    if (userToDelete) {
                        window.location.href = "account?action=delete&id=" + userToDelete;
                    }
                });
            }
        </script>
    </body>
</html>