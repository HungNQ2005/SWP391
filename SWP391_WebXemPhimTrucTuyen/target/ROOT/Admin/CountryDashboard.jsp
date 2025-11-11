<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 10/24/2025
  Time: 3:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Countries</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
<div class="container">
    <h2>Country Management</h2>
    <button class="btn btn-primary my-3" data-bs-toggle="modal" data-bs-target="#addModal">+ Add Country</button>

    <table class="table table-bordered">
        <thead class="table-light">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="c" items="${listCountry}">
            <tr>
                <td>${c.country_id}</td>
                <td>${c.country_name}</td>
                <td>
                    <button class="btn btn-sm btn-warning editBtn"
                            data-id="${c.country_id}"
                            data-name="${c.country_name}">Edit</button>
                    <a href="adminCountry?action=delete&id=${c.country_id}"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Delete this country?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal Add -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <form method="post" action="adminCountry">
            <input type="hidden" name="action" value="insert">
            <div class="modal-content">
                <div class="modal-header"><h5>Add Country</h5></div>
                <div class="modal-body">
                    <div class="mb-3"><label>Name</label><input name="name" class="form-control" required></div>
                </div>
                <div class="modal-footer"><button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button><button class="btn btn-primary">Save</button></div>
            </div>
        </form>
    </div>
</div>

<!-- Modal Edit -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog">
        <form method="post" action="adminCountry">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="country_id" id="editCountryID">
            <div class="modal-content">
                <div class="modal-header"><h5>Edit Country</h5></div>
                <div class="modal-body">
                    <div class="mb-3"><label>Name</label><input name="name" id="editName" class="form-control" required></div>
                </div>
                <div class="modal-footer"><button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button><button class="btn btn-success">Update</button></div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("click", e => {
        if (e.target.classList.contains("editBtn")) {
            document.getElementById("editCountryID").value = e.target.dataset.id;
            document.getElementById("editName").value = e.target.dataset.name;
            new bootstrap.Modal(document.getElementById("editModal")).show();
        }
    });
</script>
</body>
</html>

