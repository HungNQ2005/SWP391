<%-- 
    Document   : AdsDashBoard
    Created on : Oct 30, 2025
    Author     : PHUOCSANH
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin - Ads Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="http://localhost:8080/SWP391_WebXemPhimTrucTuyen/css/dashboard.css" />
    </head>

    <body>
        <!-- Sidebar -->
        <%@ include file="Sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <div class="topbar d-flex justify-content-between align-items-center mb-3">
                <h5 class="mb-0">Ads Management</h5>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addModal">+ Add Ads</button>
            </div>

            <!-- Search -->
            <div class="mb-3">
                <div class="input-group search-box">
                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control" placeholder="Tìm kiếm quảng cáo..."/>
                </div>
            </div>

            <!-- Table -->
            <div class="card">
                <div class="card-body p-0">
                    <table class="table table-dark table-striped mb-0" id="adsTable">
                        <thead>
                            <tr>
                                <th>Ad Name</th>
                                <th>Image</th>
                                <th>Link</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${adsList}" var="ad">
                                <tr>
                                    <td>${ad.ads_name}</td>
                                    <td><img src="${pageContext.request.contextPath}${ad.ads_image}" width="80"/></td>
                                    <td><a href="${ad.ads_link}" target="_blank">${ad.ads_link}</a></td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <c:choose>
                                                <c:when test="${ad.status == 'Active'}">
                                                    <span class="badge bg-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <button class="btn btn-success btn-sm editBtn"
                                                    data-id="${ad.ads_ID}"
                                                    data-name="${ad.ads_name}"
                                                    data-image="${ad.ads_image}"
                                                    data-link="${ad.ads_link}"
                                                    data-status="${ad.status}"
                                                    >Edit</button>
                                            <button class="btn btn-danger btn-sm deleteBtn"
                                                    data-id="${ad.ads_ID}">Delete</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal fade" id="addModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Advertisement</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addAdsForm" action="ads" method="post" enctype="multipart/form-data"> 
                            <input type="hidden" name="action" value="add"/>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label>Ad Name</label>
                                    <input type="text" class="form-control" id="adsName" name="ads_name" required/>
                                    <div class="text-danger" id="errorName"></div>
                                </div>
                                <div class="col-md-6">
                                    <label>Link URL</label>
                                    <input type="text" class="form-control" id="adsLink" name="ads_link" required/>
                                    <div class="text-danger" id="errorLink"></div>
                                </div>
                                <div class="col-md-12">
                                    <label>Upload Image</label>
                                    <input type="file" class="form-control" name="ads_image" accept="image/*" required>
                                    <div class="text-danger" id="errorImage"></div>
                                </div>
                                <div class="col-md-6">
                                    <label>Status</label>
                                    <select name="status" class="form-select">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mt-3 text-end">
                                <button type="submit" class="btn btn-primary">Add Ad</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Advertisement</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="ads" method="post" id="editAdsForm" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="update"/>
                            <input type="hidden" id="editId" name="ads_ID"/>
                            <input type="hidden" id="editOldImage" name="old_image"/>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label>Ad Name</label>
                                    <input type="text" class="form-control" id="editName" name="ads_name" required/>
                                </div>
                                <div class="col-md-6">
                                    <label>Link URL</label>
                                    <input type="text" class="form-control" id="editLink" name="ads_link" required/>
                                </div>
                                <div class="col-md-12">
                                    <label>Upload Image</label>
                                    <input type="file" class="form-control" name="ads_image" accept="image/*" >
                                </div>
                                <div class="col-md-6">
                                    <label>Status</label>
                                    <select id="editStatus" name="status" class="form-select">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mt-3 text-end">
                                <button type="submit" class="btn btn-success">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Modal -->
        <form action="ads" method="post">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" id="deleteId" name="ads_ID"/>
            <div class="modal fade" id="deleteModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content bg-dark text-white">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete Advertisement</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            Bạn có chắc muốn xóa quảng cáo này không?
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button class="btn btn-danger" type="submit">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("editBtn")) {
                    document.getElementById("editId").value = e.target.dataset.id;
                    document.getElementById("editName").value = e.target.dataset.name;
                    document.getElementById("editOldImage").value = e.target.dataset.image;

                    document.getElementById("editLink").value = e.target.dataset.link;
                    document.getElementById("editStatus").value = e.target.dataset.status;

                    new bootstrap.Modal(document.getElementById("editModal")).show();
                }
            });

            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("deleteBtn")) {
                    document.getElementById("deleteId").value = e.target.dataset.id;
                    new bootstrap.Modal(document.getElementById("deleteModal")).show();
                }
            });
        </script>

        <script>
            document.getElementById("addAdsForm").addEventListener("submit", function (e) {
                handleAdsForm(e, "adsName", "adsLink", "adsImage", "errorName", "errorImage");
            });

            document.getElementById("editAdsForm").addEventListener("submit", function (e) {
                handleAdsForm(e, "editName", "editLink", null); // image không bắt buộc trong Edit
            });

            function handleAdsForm(e, nameId, linkId, imageId, errorNameId, errorImageId) {
                let hasError = false;

                const nameInput = document.getElementById(nameId);
                const linkInput = document.getElementById(linkId);
                const imageInput = imageId ? document.getElementById(imageId) : null;

                const name = nameInput.value.trim();
                let link = linkInput.value.trim();
                const image = imageInput ? imageInput.value.trim() : "";

          
                if (errorNameId)
                    document.getElementById(errorNameId).innerText = "";
                if (errorImageId)
                    document.getElementById(errorImageId).innerText = "";

  
                const namePattern = /^[a-zA-Z0-9\s]+$/;
                if (name === "") {
                    if (errorNameId)
                        document.getElementById(errorNameId).innerText = "Tên quảng cáo không được để trống";
                    hasError = true;
                } else if (!namePattern.test(name)) {
                    if (errorNameId)
                        document.getElementById(errorNameId).innerText = "Tên quảng cáo không được chứa ký tự đặc biệt";
                    hasError = true;
                }

                if (imageInput) {
                    const imagePattern = /\.(jpg|jpeg|png|gif|webp)$/i;
                    if (image === "") {
                        if (errorImageId)
                            document.getElementById(errorImageId).innerText = "Image không được để trống";
                        hasError = true;
                    } else if (!imagePattern.test(image)) {
                        if (errorImageId)
                            document.getElementById(errorImageId).innerText = "Image phải có định dạng jpg, jpeg, png, gif, webp";
                        hasError = true;
                    }
                }

     
                if (link !== "" && !link.startsWith("http://") && !link.startsWith("https://")) {
                    link = "http://" + link;
                    linkInput.value = link; 
                }

                if (link === "") {
                    alert("Link không được để trống!");
                    hasError = true;
                }

                if (hasError)
                    e.preventDefault();
            }

        </script>

    </body>
</html>