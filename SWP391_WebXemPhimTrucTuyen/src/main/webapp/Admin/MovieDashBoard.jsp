<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Admin Movie</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
            rel="stylesheet"
            />

        <!-- NEW -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Admin/MovieDashBoard.css"/>

    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="Sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <!-- Topbar -->
            <div
                class="topbar d-flex justify-content-between align-items-center mb-3"
                >
                <h5 class="mb-0">Movie Management</h5>
                <button
                    class="btn btn-primary btn-sm"
                    data-bs-toggle="modal"
                    data-bs-target="#addModal"
                    >
                    + Add Movie
                </button>
            </div>

            <!-- Search -->
            <!-- Search -->
            <!-- Search -->
            <div class="mb-3">
                <form class="input-group search-box" action="adminMovie" method="get">
                    <input type="hidden" name="action" value="searchFilmAdmin"/>
                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                    <input
                        type="text"
                        class="form-control"
                        name="query"
                        placeholder="Tìm kiếm bộ phim..."
                        required
                        />
                    <button class="btn btn-primary" type="submit">Tìm</button>
                </form>
            </div>


            <!-- Table -->
            <div class="card">
                <div class="card-body p-0">
                    <table class="table table-dark table-striped mb-0" id="accountTable">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Type</th>
                                <th>Year</th>
                                <th>Country</th>
                                <th>Description</th>
                                <th>Poster</th>
                                <th>Trailer</th>
                                <th>Episode</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty listSeries}">
                                <tr>
                                    <td colspan="10" class="text-center text-warning">Không tìm thấy phim nào phù hợp.</td>
                                </tr>
                            </c:if>

                            <c:forEach var="s" items="${listSeries}">
                                <tr>
                                    <td>${s.seriesID}</td>
                                    <td>${s.title}</td>
                                    <td>${s.typeId == 1 ? 'Movie' : 'Series'}</td>
                                    <td>${s.releaseYear}</td>
                                    <td class="country-cell">${s.country}</td>
                                    <td>${s.description}</td>
                                    <td><img src="${s.posteUrl}" width="60"/></td>
                                    <td><a href="${s.trailerUrl}" target="_blank">Trailer</a></td>
                                    <td>?</td>
                                    <td>
                                        <a href="adminMovie?action=viewDetails&id=${s.seriesID}" class="btn btn-info btn-sm">Detail</a>

                                        <button class="btn btn-success btn-sm editBtn">Edit</button>
                                        <form action="adminMovie" method="get" style="display:inline;">
                                            <input type="hidden" name="action" value="delete"/>
                                            <input type="hidden" name="id" value="${s.seriesID}"/>
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>

                        </tbody>

                    </table>
                    <!-- Pagination -->
                    </tbody>
                    </table>

                    </tbody>
                    </table>

                    <!-- Pagination -->
                    <div class="d-flex justify-content-center my-3">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="adminMovie?action=sendSeriesDashboard&page=${currentPage - 1}">Previous</a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="p">
                                    <li class="page-item ${p == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="adminMovie?action=sendSeriesDashboard&page=${p}">${p}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="adminMovie?action=sendSeriesDashboard&page=${currentPage + 1}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>


                </div>
            </div>

            <!-- Add Movie Modal -->
            <div class="modal fade" id="addModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content bg-dark text-white">
                        <div class="modal-header">
                            <h5 class="modal-title">Add Movie</h5>
                            <button
                                type="button"
                                class="btn-close btn-close-white"
                                data-bs-dismiss="modal"
                                ></button>
                        </div>
                        <div class="modal-body">
                            <form action="adminMovie?action=insert"
                                  method="post"
                                  enctype="multipart/form-data">

                                <div class="col-md-6">
                                    <label>Title</label>
                                    <input type="text" class="form-control" name="title" required/>
                                </div>

                                <div class="col-md-6">
                                    <label>Type</label>
                                    <select class="form-select" name="type_id">
                                        <option value="1">Movie</option>
                                        <option value="2">Series</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label>Year</label>
                                    <input type="number" class="form-control" name="release_year" required/>
                                </div>

                                <div class="col-md-6">
                                    <label>Country</label>
                                    <!-- Multi-select populated from listCountry supplied by controller/filter -->
                                    <select class="form-select" name="countries" id="addCountries" multiple size="5">
                                        <c:forEach var="c" items="${listCountry}">
                                            <option value="${c}">${c}</option>
                                        </c:forEach>
                                    </select>
                                    <!-- fallback single input for compatibility -->
                                    <input type="hidden" name="country"/>
                                </div>

                                <div class="col-12">
                                    <label>Description</label>
                                    <textarea class="form-control" name="description" rows="2"></textarea>
                                </div>


                                <div class="col-md-6">
                                    <label>Poster URL</label>
                                    <input type="file" name="poster_file" accept="image/*" required/>
                                </div>


                                <div class="col-md-6">
                                    <label>Trailer URL</label>
                                    <input type="text" class="form-control" name="trailer_url"/>
                                </div>

                                <div class="col-md-6">
                                    <label>Upload Video</label>
                                    <input type="file" class="form-control" name="video_file" accept="video/*" />
                                </div>


                                <div class="col-12">
                                    <label>Categories</label><br>
                                    <c:forEach var="c" items="${listCategory}">
                                        <input type="checkbox" name="category_ids" value="${c.category_id}"/> ${c.name}
                                    </c:forEach>
                                </div>
                                <div class="mt-3 text-end">
                                    <button type="submit" class="btn btn-primary">Add</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Edit Movie Modal -->
            <div class="modal fade" id="editModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content bg-dark text-white">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Movie</h5>
                            <button
                                type="button"
                                class="btn-close btn-close-white"
                                data-bs-dismiss="modal"
                                ></button>
                        </div>
                        <div class="modal-body">
                            <form id="editForm" action="adminMovie" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="update"/>
                                <input type="hidden" name="series_id" id="editSeriesID"/>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label>Title</label>
                                        <input type="text" class="form-control" id="editTitle" name="title" required/>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Type</label>
                                        <select class="form-select" id="editType" name="type_id">
                                            <option value="1">Movie</option>
                                            <option value="2">Series</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Year</label>
                                        <input type="number" class="form-control" id="editYear" name="release_year" required/>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Country</label>
                                        <!-- Multi-select populated from listCountry -->
                                        <select class="form-select" id="editCountries" name="countries" multiple size="5">
                                            <c:forEach var="c" items="${listCountry}">
                                                <option value="${c.country_id}">${c.country_name}</option>
                                            </c:forEach>
                                        </select>
                                        <!-- fallback single input for compatibility -->
                                        <input type="hidden" id="editCountryHidden" name="country"/>
                                    </div>

                                    <div class="col-12">
                                        <label>Description</label>
                                        <textarea class="form-control" id="editDescription" name="description"
                                                  rows="2"></textarea>
                                    </div>

                                    <div class="col-md-6">
                                        <label>Poster</label><br>
                                        <!-- Hiển thị ảnh cũ -->
                                        <img id="editPosterPreview" src="" alt="Current Poster"
                                             style="width: 100px; height: auto; display: block; margin-bottom: 10px; border-radius: 8px;">

                                        <!-- Input chọn ảnh mới -->
                                        <input type="file" class="form-control" id="editPoster" name="poster_file" accept="image/*" required/>

                                        <!-- Input ẩn để lưu đường dẫn ảnh cũ -->
                                        <input type="hidden" id="oldPoster" name="oldPoster"/>
                                    </div>


                                    <div class="col-md-6">
                                        <label>Trailer URL</label>
                                        <input type="text" class="form-control" id="editTrailer" name="trailer_url"/>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Upload Video</label>
                                        <input type="file" class="form-control" name="video_file" accept="video/*" />
                                    </div>


                                    <div class="col-md-6">
                                        <label>Episode</label>
                                        <input type="number" class="form-control" id="editEpisode" name="episode" min="1"/>
                                    </div>

                                    <div class="col-12">
                                        <label>Categories</label><br>
                                        <c:forEach var="c" items="${listCategory}">
                                            <input type="checkbox" name="category_ids" value="${c.category_id}"/> ${c.name}
                                        </c:forEach>
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

            <!-- Delete Movie Modal -->
            <div class="modal fade" id="deleteModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content bg-dark text-white">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete Movie</h5>
                            <button
                                type="button"
                                class="btn-close btn-close-white"
                                data-bs-dismiss="modal"
                                ></button>
                        </div>
                        <div class="modal-body">Bạn có chắc muốn xóa bộ phim này không?</div>
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
                // Helper: join selected options của multi-select thành chuỗi "A, B, C"
                function joinSelectedOptions(selectEl) {
                    const selected = [];
                    if (!selectEl)
                        return "";
                    for (let i = 0; i < selectEl.options.length; i++) {
                        if (selectEl.options[i].selected) {
                            selected.push(selectEl.options[i].value.trim());
                        }
                    }
                    return selected.join(", ");
                }

                // Khi submit Add form: gán chuỗi vào hidden input name="country"
                const addForm = document.getElementById("addForm");
                if (addForm) {
                    addForm.addEventListener("submit", function (e) {
                        const addCountries = document.getElementById("addCountries");
                        const hiddenCountry = addForm.querySelector("input[name='country']");
                        if (addCountries && hiddenCountry) {
                            hiddenCountry.value = joinSelectedOptions(addCountries);
                        }
                        // tiếp tục submit
                    });
                }

                // Khi submit Edit form: gán chuỗi vào hidden input name="country"
                const editForm = document.getElementById("editForm");
                if (editForm) {
                    editForm.addEventListener("submit", function (e) {
                        const editCountries = document.getElementById("editCountries");
                        const hiddenCountry = document.getElementById("editCountryHidden");
                        if (editCountries && hiddenCountry) {
                            hiddenCountry.value = joinSelectedOptions(editCountries);
                        }
                        // tiếp tục submit
                    });
                }

                // Mở modal Edit: lấy dữ liệu trong row và pre-select các option trong multi-select
                // Mở modal Edit: lấy dữ liệu trong row và pre-select các option
                document.addEventListener("click", function (e) {
                    if (e.target.classList.contains("editBtn")) {
                        const row = e.target.closest("tr");
                        const seriesID = row.cells[0].innerText.trim();
                        const title = row.cells[1].innerText.trim();
                        const typeText = row.cells[2].innerText.trim();
                        const year = row.cells[3].innerText.trim();
                        const country = row.cells[4].innerText.trim();
                        const description = row.cells[5].innerText.trim();
                        const poster = row.querySelector("img")?.src || "";
                        const trailer = row.querySelector("a")?.href || "";

                        // Gán dữ liệu vào form
                        document.getElementById("editSeriesID").value = seriesID;
                        document.getElementById("editTitle").value = title;
                        document.getElementById("editYear").value = year;
                        document.getElementById("editDescription").value = description;
                        document.getElementById("editTrailer").value = trailer;
                        document.getElementById("editType").value = (typeText === "Movie" ? "1" : "2");

                        // Hiển thị ảnh cũ
                        document.getElementById("editPosterPreview").src = poster;
                        // Lưu đường dẫn cũ vào input hidden
                        document.getElementById("oldPoster").value = poster;

                        // Reset file input (để không lỗi)
                        document.getElementById("editPoster").value = "";

                        // Xử lý countries
                        const editCountries = document.getElementById("editCountries");
                        if (editCountries) {
                            for (let i = 0; i < editCountries.options.length; i++) {
                                editCountries.options[i].selected = false;
                            }
                            if (country && country.length > 0) {
                                const parts = country.split(/,\s*/);
                                for (const p of parts) {
                                    for (let i = 0; i < editCountries.options.length; i++) {
                                        if (editCountries.options[i].value === p.trim()) {
                                            editCountries.options[i].selected = true;
                                            break;
                                        }
                                    }
                                }
                            }
                        }

                        // Hiển thị modal
                        const editModal = new bootstrap.Modal(document.getElementById("editModal"));
                        editModal.show();
                    }
                });


                // Optional: confirm delete modal wiring (if you want "Delete" button inside modal to submit)
                document.getElementById("confirmDelete")?.addEventListener("click", function () {
                    // Implement if using modal to confirm deletes; current table uses form submit directly, so ignore.
                });
            </script>
        </div>
    </body>
</html>