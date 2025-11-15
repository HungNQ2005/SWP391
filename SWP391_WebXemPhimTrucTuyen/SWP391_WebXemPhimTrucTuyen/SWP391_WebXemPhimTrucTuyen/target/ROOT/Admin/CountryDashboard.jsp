<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Country Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Giữ đường dẫn CSS của bạn --%>
    <link href="${pageContext.request.contextPath}/css/country-style.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<%-- Sidebar --%>
<%@ include file="Sidebar.jsp" %>

<div class="content p-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Country Management</h2>
        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addModal">+ Add Country</button>
    </div>

    <%-- LOGIC THÔNG BÁO (Lấy từ File 1) --%>
    <div class="mb-3">
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>
    </div>

    <%-- Thanh tìm kiếm --%>
    <div class="mb-3">
        <input type="text" id="searchInput" class="form-control" placeholder="Search...">
    </div>

    <%-- Bảng dữ liệu --%>
    <div class="card">
        <div class="card-body p-0">
            <table class="table table-dark table-striped table-hover mb-0 text-center align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty listCountry}">
                        <c:forEach var="c" items="${listCountry}">
                            <tr>
                                <td>${c.country_id}</td>
                                <td>${c.country_name}</td>
                                <td>
                                    <button class="btn btn-warning btn-sm editBtn"
                                            data-id="${c.country_id}"
                                            data-name="${c.country_name}">
                                        Edit
                                    </button>
                                    <button class="btn btn-danger btn-sm deleteBtn"
                                            data-id="${c.country_id}">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="3" class="text-center text-muted">No country found.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg-custom">
        <%-- Lưu ý: action="country" để khớp với logic cũ --%>
        <form action="country" method="post" onsubmit="return validateAddCountry()">
            <input type="hidden" name="action" value="insert">
            <div class="modal-content">
                <div class="modal-header">
                    <h5>Add Country</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Country Name</label>
                        <%-- Đã đổi name="country_name" thành name="name" để khớp với Logic File 1 --%>
                        <input type="text" name="name" id="addCountryName" class="form-control" required>
                        <div id="addNameError" class="text-danger mt-1"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg-custom">
        <%-- Lưu ý: action="country" --%>
        <form action="country" method="post" onsubmit="return validateEditCountry()">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="country_id" id="editCountryID">
            <div class="modal-content">
                <div class="modal-header">
                    <h5>Edit Country</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Country Name</label>
                         <%-- Đã đổi name="country_name" thành name="name" để khớp với Logic File 1 --%>
                        <input type="text" name="name" id="editName" class="form-control" required>
                        <div id="editNameError" class="text-danger mt-1"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Update</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="deleteConfirmModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title">⚠️ Warning</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Việc xóa sẽ làm mất toàn bộ dữ liệu liên quan.</p>
                <p class="fw-bold text-danger">Bạn có chắc chắn muốn tiếp tục xóa không?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a id="confirmDeleteBtn" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // --- Logic Validate JS (Giữ nguyên từ File 2 vì rất tốt) ---
    function validateCountryName(name, currentId = null) {
        const regex = /^[A-Za-zÀ-ỹ\s]+$/;
        if(!regex.test(name.trim())) return "Tên quốc gia chỉ được chứa chữ và khoảng trắng!";

        let duplicate = false;
        // Tạo mảng JS từ dữ liệu Server để check trùng lặp
        const countries = [
            <c:forEach var="c" items="${listCountry}">
            {id: "${c.country_id}", name: "${c.country_name}"},
            </c:forEach>
        ];
        
        countries.forEach(c => {
            if(c.name.toLowerCase() === name.trim().toLowerCase() && c.id !== currentId) {
                duplicate = true;
            }
        });
        if(duplicate) return "Tên quốc gia đã tồn tại!";
        return "";
    }

    function validateAddCountry() {
        const nameInput = document.getElementById("addCountryName");
        const errorDiv = document.getElementById("addNameError");
        const error = validateCountryName(nameInput.value);
        if(error) {
            errorDiv.textContent = error;
            nameInput.classList.add("is-invalid");
            return false;
        } else {
            errorDiv.textContent = "";
            nameInput.classList.remove("is-invalid");
            return true;
        }
    }

    function validateEditCountry() {
        const nameInput = document.getElementById("editName");
        const errorDiv = document.getElementById("editNameError");
        const currentId = document.getElementById("editCountryID").value;
        const error = validateCountryName(nameInput.value, currentId);
        if(error) {
            errorDiv.textContent = error;
            nameInput.classList.add("is-invalid");
            return false;
        } else {
            errorDiv.textContent = "";
            nameInput.classList.remove("is-invalid");
            return true;
        }
    }

    // --- Logic Sự kiện (Đã sửa đường dẫn URL cho khớp Logic File 1) ---
    document.addEventListener("click", e => {
        // Edit Button
        if(e.target.classList.contains("editBtn")){
            document.getElementById("editCountryID").value = e.target.dataset.id;
            document.getElementById("editName").value = e.target.dataset.name;
            new bootstrap.Modal(document.getElementById("editModal")).show();
        }
        // Delete Button
        if(e.target.classList.contains("deleteBtn")){
            const id = e.target.dataset.id;
            // Sửa URL: dùng 'country' thay vì '/admin/country' để khớp với File 1
            document.getElementById("confirmDeleteBtn").href = `country?action=delete&id=` + id;
            new bootstrap.Modal(document.getElementById("deleteConfirmModal")).show();
        }
    });

    // --- Search Logic ---
    document.getElementById('searchInput').addEventListener('keyup', function(){
        const filter = this.value.toLowerCase();
        document.querySelectorAll('tbody tr').forEach(row=>{
            row.style.display = row.textContent.toLowerCase().includes(filter) ? '' : 'none';
        });
    });
</script>
</body>
</html>