<%-- 
    Document   : retailmanager
    Created on : Oct 19, 2025, 6:14:47 PM
    Author     : Nguyen Quoc Hung - CE190870
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Retail Manager</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="../css/retailmanager.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Retail Management</h2>

            <!-- Add Form -->
            <form action="retail" method="post" class="card p-4 mb-4">
                <input type="hidden" name="action" value="${retail != null ? 'update' : 'insert'}">
                <c:if test="${retail != null}">
                    <input type="hidden" name="id" value="${retail.id}">
                </c:if>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Name</label>
                        <input name="name" class="form-control" value="${retail.name}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
                        <input name="phone" class="form-control" value="${retail.phone}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Address</label>
                        <input name="address" class="form-control" value="${retail.address}" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Latitude</label>
                        <input name="latitude" type="number" step="any" class="form-control" value="${retail.latitude}" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Longitude</label>
                        <input name="longitude" type="number" step="any" class="form-control" value="${retail.longitude}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Website</label>
                        <input name="website" class="form-control" value="${retail.website}">
                    </div>
                    <div class="col-12 text-center mt-3">
                        <button type="submit" class="btn btn-primary px-4 me-2">
                            <c:choose>
                                <c:when test="${retail != null}">Update Retail</c:when>
                                <c:otherwise>Add Retail</c:otherwise>
                            </c:choose>
                        </button>
                        <a href="retail" class="btn btn-secondary px-4">Reset</a>
                    </div>
                </div>
            </form>

            <!-- Retail Table -->
            <table class="table table-bordered table-dark table-striped">
                <thead>
                    <tr>
                        <th>ID</th><th>Name</th><th>Address</th><th>Phone</th>
                        <th>Latitude</th><th>Longitude</th><th>Website</th><th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${listRetail}">
                        <tr>
                            <td>${r.id}</td>
                            <td>${r.name}</td>
                            <td>${r.address}</td>
                            <td>${r.phone}</td>
                            <td>${r.latitude}</td>
                            <td>${r.longitude}</td>
                            <td><a href="${r.website}" target="_blank">${r.website}</a></td>
                            <td>
                                <a href="retail?action=edit&id=${r.id}" class="btn btn-sm btn-warning me-1">Edit</a>
                                <a href="retail?action=delete&id=${r.id}" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure to delete this retail?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- SweetAlert2 popup -->
        <script>
            const success = new URLSearchParams(window.location.search).get('success');
            if (success) {
                let msg = '';
                if (success === 'insert')
                    msg = 'Retail added successfully!';
                else if (success === 'update')
                    msg = 'Retail updated successfully!';
                else if (success === 'delete')
                    msg = 'Retail deleted successfully!';
                else
                    msg = 'Action failed!';
                Swal.fire({
                    icon: success === 'fail' ? 'error' : 'success',
                    title: msg,
                    timer: 1500,
                    showConfirmButton: false
                });
            }
        </script>

    </body>
</html>
