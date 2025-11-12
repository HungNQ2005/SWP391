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

        <style>
          /* Simple error styling */
          .field-error { color: #ff6b6b; font-size: 0.9rem; display: none; margin-top: 4px; }
          .is-invalid-custom { border-color: #ff6b6b !important; box-shadow: none !important; }
        </style>

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
                        </div>z
                        <div class="modal-body">
                            <!-- ADD FORM: thêm id="addForm" và các span lỗi -->
                            <form id="addForm" action="adminMovie?action=insert"
                                  method="post"
                                  enctype="multipart/form-data" >

                                <div class="col-md-6 mb-2">
                                    <label for="title">Tên phim</label>
                                    <input type="text" name="title" id="title" class="form-control" 
                                           required minlength="2" maxlength="100"
                                           placeholder="Nhập tên phim...">
                                    <div id="err-title" class="field-error"></div>
                                </div>

                                <div class="col-md-6 mb-2">
                                    <label>Type</label>
                                    <select class="form-select" name="type_id" id="type_id">
                                        <option value="1">Movie</option>
                                        <option value="2">Series</option>
                                    </select>
                                    <div id="err-type" class="field-error"></div>
                                </div>

                                <div class="col-md-6 mb-2">
                                    <label>Year</label>
                                    <input type="number" name="release_year" id="release_year" 
                                           class="form-control" required min="1900" max="2100">
                                    <div id="err-year" class="field-error"></div>
                                </div>

                                <div class="col-md-6 mb-2">
                                    <label>Country</label>
                                    <!-- Multi-select populated from listCountry supplied by controller/filter -->
                                    <select class="form-select" name="countries" id="addCountries" multiple size="5">
                                        <c:forEach var="c" items="${listCountry}">
                                            <option value="${c.country_id}">${c.country_name}</option>
                                        </c:forEach>
                                    </select>
                                    <!-- fallback single input for compatibility -->
                                    <input type="hidden" name="country"/>
                                    <div id="err-addCountries" class="field-error"></div>
                                </div>

                                <div class="col-12 mb-2">
                                    <label>Description</label>
                                    <textarea class="form-control" name="description" id="description" rows="2"></textarea>
                                    <div id="err-description" class="field-error"></div>
                                </div>


                                <div class="col-md-6 mb-2">
                                    <label>Poster URL</label>
                                    <input type="file" id="posterFile" name="poster_file" accept="image/*"/>
                                    <div id="err-poster" class="field-error"></div>
                                </div>


                                <div class="col-md-6 mb-2">
                                    <label>Trailer URL</label>
                                    <input type="text" id="trailerUrl" class="form-control" name="trailer_url"/>
                                    <div id="err-trailer" class="field-error"></div>
                                </div>

                                <div class="col-md-6 mb-2">
                                    <label>Upload Video</label>
                                    <input type="file" id="videoFile" class="form-control" name="video_file" accept="video/*" />
                                    <div id="err-video" class="field-error"></div>
                                </div>


                                <div class="col-12 mb-2" id="categoriesContainer">
                                    <label>Categories</label><br>
                                    <c:forEach var="c" items="${listCategory}">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="cat${c.category_id}"
                                                   name="category_ids" value="${c.category_id}"/>
                                            <label class="form-check-label" for="cat${c.category_id}">${c.name}</label>
                                        </div>
                                    </c:forEach>
                                    <div id="err-categories" class="field-error"></div>
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

                // --- VALIDATION for ADD form ---
                (function() {
                    const addForm = document.getElementById("addForm");

                    function showError(id, message) {
                        const el = document.getElementById(id);
                        if (!el) return;
                        el.textContent = message || "";
                        el.style.display = message ? "block" : "none";
                        // highlight the associated input if possible
                        const inputMap = {
                            "err-title": "title",
                            "err-type": "type_id",
                            "err-year": "release_year",
                            "err-addCountries": "addCountries",
                            "err-description": "description",
                            "err-poster": "posterFile",
                            "err-trailer": "trailerUrl",
                            "err-video": "videoFile",
                            "err-categories": "categoriesContainer"
                        };
                        const inputID = inputMap[id];
                        if (inputID) {
                            const input = document.getElementById(inputID) || document.querySelector(`[name='${inputID}']`);
                            if (input) {
                                if (message) input.classList.add("is-invalid-custom");
                                else input.classList.remove("is-invalid-custom");
                            }
                        }
                    }

                    function isValidURL(url) {
                        // simple URL check
                        try {
                            if (!url) return false;
                            const u = new URL(url);
                            return ["http:", "https:"].includes(u.protocol);
                        } catch (e) {
                            return false;
                        }
                    }

                    if (addForm) {
                        addForm.addEventListener("submit", function(e) {
                            // Clear previous errors
                            showError("err-title", "");
                            showError("err-type", "");
                            showError("err-year", "");
                            showError("err-addCountries", "");
                            showError("err-description", "");
                            showError("err-poster", "");
                            showError("err-trailer", "");
                            showError("err-video", "");
                            showError("err-categories", "");

                            let firstInvalid = null;
                            const title = document.getElementById("title").value.trim();
                            const yearVal = document.getElementById("release_year").value.trim();
                            const addCountries = document.getElementById("addCountries");
                            const posterInput = document.getElementById("posterFile");
                            const trailer = document.getElementById("trailerUrl").value.trim();
                            const videoInput = document.getElementById("videoFile");
                            const categoryChecks = addForm.querySelectorAll("input[name='category_ids']");

                            // Title
                            if (!title) {
                                showError("err-title", "Tên phim không được để trống.");
                                firstInvalid = firstInvalid || document.getElementById("title");
                            } else if (title.length < 2 || title.length > 100) {
                                showError("err-title", "Tên phim phải từ 2 đến 100 ký tự.");
                                firstInvalid = firstInvalid || document.getElementById("title");
                            }

                            // Year
                            if (!yearVal) {
                                showError("err-year", "Năm phát hành không được để trống.");
                                firstInvalid = firstInvalid || document.getElementById("release_year");
                            } else {
                                const yearNum = Number(yearVal);
                                if (!Number.isInteger(yearNum) || yearNum < 1900 || yearNum > 2100) {
                                    showError("err-year", "Năm phải là số nguyên hợp lệ (1900-2100).");
                                    firstInvalid = firstInvalid || document.getElementById("release_year");
                                }
                            }

                            // Countries (at least one)
                            let countriesSelected = 0;
                            if (addCountries) {
                                for (let i=0;i<addCountries.options.length;i++){
                                    if (addCountries.options[i].selected) countriesSelected++;
                                }
                            }
                            if (countriesSelected === 0) {
                                showError("err-addCountries", "Phải chọn ít nhất 1 quốc gia.");
                                firstInvalid = firstInvalid || document.getElementById("addCountries");
                            }

                            // Poster required and must be image
                            if (!posterInput || !posterInput.files || posterInput.files.length === 0) {
                                showError("err-poster", "Phải chọn ảnh poster.");
                                firstInvalid = firstInvalid || posterInput;
                            } else {
                                const f = posterInput.files[0];
                                if (!f.type.startsWith("image/")) {
                                    showError("err-poster", "Tập tin poster phải là ảnh (jpg, png, ...).");
                                    firstInvalid = firstInvalid || posterInput;
                                }
                            }

                            // Categories at least one
                            let catSelected = 0;
                            for (let i=0;i<categoryChecks.length;i++){
                                if (categoryChecks[i].checked) catSelected++;
                            }
                            if (catSelected === 0) {
                                showError("err-categories", "Phải chọn ít nhất 1 category.");
                                firstInvalid = firstInvalid || document.getElementById("categoriesContainer");
                            }

                            // Trailer URL optional but if provided must be valid URL
                            if (trailer) {
                                if (!isValidURL(trailer)) {
                                    showError("err-trailer", "Trailer URL không hợp lệ (phải bắt đầu bằng http/https).");
                                    firstInvalid = firstInvalid || document.getElementById("trailerUrl");
                                }
                            }

                            // Video optional but if provided must be video mime
                            if (videoInput && videoInput.files && videoInput.files.length > 0) {
                                const vf = videoInput.files[0];
                                if (!vf.type.startsWith("video/")) {
                                    showError("err-video", "Tập tin upload phải là video.");
                                    firstInvalid = firstInvalid || videoInput;
                                }
                            }

                            if (firstInvalid) {
                                e.preventDefault();
                                firstInvalid.focus();
                                return false;
                            }

                            // set hidden country value as CSV of selected country ids before submit
                            const hiddenCountry = addForm.querySelector("input[name='country']");
                            if (addCountries && hiddenCountry) {
                                hiddenCountry.value = joinSelectedOptions(addCountries);
                            }

                            // allow submit
                            return true;
                        });
                    }
                })();

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