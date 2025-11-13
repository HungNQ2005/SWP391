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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Admin/AccountDashboard.css" />

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
                                    <a class="page-link" href="admin?action=sendAccountDashboard&page=${currentPage - 1}">Previous</a>
                                </li>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="admin?action=sendAccountDashboard&page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="admin?action=sendAccountDashboard&page=${currentPage + 1}">Next</a>
                                </li>
                            </c:if>

                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Add Modal -->
        <div class="modal fade" id="addModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Account</h5>
                        <button
                            type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addForm" action="admin" method="post">
                            <input type="hidden" name="action" value="insert">
                            <div class="mb-3">
                                <label>UserName</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    id="addUserName"
                                    name="username"
                                    required/>
                            </div>
                            <div class="mb-3">
                                <label>Password</label>
                                <input
                                    type="password"
                                    class="form-control"
                                    id="addUserName"
                                    name="password"
                                    required/>
                            </div>
                            <div class="mb-3">
                                <label>Email</label>
                                <input
                                    type="email"
                                    class="form-control"
                                    id="addEmail"
                                    name="email"
                                    required/>
                            </div>
                            <div class="mb-3">
                                <label>Full Name</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    id="addFullName"
                                    name="full_name"
                                    required/>
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

        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Account</h5>
                        <button
                            type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editForm">
                            <input type="hidden" id="editId" />
                            <div class="mb-3">
                                <label>UserName</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    id="editUserName"
                                    name="username"
                                    required/>
                            </div>
                            <div class="mb-3">
                                <label>Email</label>
                                <input
                                    type="email"
                                    class="form-control"
                                    id="editEmail"
                                    name="email"
                                    required/>
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
        <!-- Delete Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Delete Account</h5>
                        <button
                            type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc muốn xóa tài khoản này không?
                    </div>
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


            // ======== EDIT FUNCTION ========
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("editBtn")) {
                    const btn = e.target;
                    document.getElementById("editId").value = btn.getAttribute("data-id");
                    document.getElementById("editUserName").value = btn.getAttribute("data-username");
                    document.getElementById("editEmail").value = btn.getAttribute("data-email");
                    document.getElementById("editRole").value = btn.getAttribute("data-role");

                    new bootstrap.Modal(document.getElementById("editModal")).show();
                }
            });

            // Submit edit form
            document.getElementById("editForm").addEventListener("submit", function (e) {
                e.preventDefault();
                const data = new URLSearchParams();
                data.append("action", "update");
                data.append("user_id", document.getElementById("editId").value);
                data.append("username", document.getElementById("editUserName").value);
                data.append("email", document.getElementById("editEmail").value);
                data.append("user_level", document.getElementById("editRole").value);

                fetch("admin", {
                    method: "POST",
                    body: data
                }).then(() => location.reload());
            });

            // ======== DELETE FUNCTION ========
            let userToDelete = null;

            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("deleteBtn")) {
                    userToDelete = e.target.getAttribute("data-id");
                    new bootstrap.Modal(document.getElementById("deleteModal")).show();
                }
            });

            document.getElementById("confirmDelete").addEventListener("click", function () {
                if (userToDelete) {
                    window.location.href = "admin?action=delete&id=" + userToDelete;
                }
            });
        </script>
    </body>
</html>
