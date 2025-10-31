<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Genre" %>
<%
    Genre genre = (Genre) request.getAttribute("genre");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Genre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f9;
            font-family: "Segoe UI", sans-serif;
        }

        .container {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            max-width: 600px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        @keyframes shake {
            0% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            50% { transform: translateX(5px); }
            75% { transform: translateX(-5px); }
            100% { transform: translateX(0); }
        }

        .is-invalid {
            border: 2px solid #dc3545 !important;
            animation: shake 0.3s;
        }

        .text-danger {
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h3 class="mb-4 text-center text-primary fw-bold">Edit Genre</h3>
    <form action="genre?action=update" method="post" onsubmit="return validateForm()">
        <!-- Hidden ID -->
        <input type="hidden" name="genre_id" value="<%= genre.getGenre_id() %>" />

        <!-- Genre Name -->
        <div class="mb-3">
            <label for="genre_name" class="form-label fw-semibold">Genre Name</label>
            <input type="text" class="form-control" id="genre_name" name="genre_name"
                   value="<%= genre.getGenre_name() %>" required>
            <div id="nameError" class="text-danger mt-1"></div>
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label for="description" class="form-label fw-semibold">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" required><%= genre.getDescription() %></textarea>
            <div id="descError" class="text-danger mt-1"></div>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-end gap-2">
            <button type="submit" class="btn btn-primary px-4">Update</button>
            <a href="genre?action=list" class="btn btn-secondary px-4">Cancel</a>
        </div>
    </form>
</div>

<script>
function validateForm() {
    const nameInput = document.getElementById("genre_name");
    const descInput = document.getElementById("description");
    const name = nameInput.value.trim();
    const desc = descInput.value.trim();
    const nameError = document.getElementById("nameError");
    const descError = document.getElementById("descError");

    nameError.textContent = "";
    descError.textContent = "";
    nameInput.classList.remove("is-invalid");
    descInput.classList.remove("is-invalid");

    const validRegex = /^[A-Za-zÀ-ỹ0-9\s\-\_\.\,\&]+$/;

    if (name.length === 0) {
        nameError.textContent = "Genre Name không được để trống.";
        nameInput.classList.add("is-invalid");
        return false;
    } else if (!isNaN(name)) {
        nameError.textContent = "Genre Name không được toàn số.";
        nameInput.classList.add("is-invalid");
        return false;
    } else if (/^\d/.test(name)) {
        nameError.textContent = "Genre Name không được bắt đầu bằng số.";
        nameInput.classList.add("is-invalid");
        return false;
    } else if (!validRegex.test(name)) {
        nameError.textContent = "Genre Name chứa ký tự không hợp lệ.";
        nameInput.classList.add("is-invalid");
        return false;
    }

    if (desc.length === 0) {
        descError.textContent = "Description không được để trống.";
        descInput.classList.add("is-invalid");
        return false;
    } else if (!validRegex.test(desc)) {
        descError.textContent = "Description chứa ký tự không hợp lệ.";
        descInput.classList.add("is-invalid");
        return false;
    }

    return true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
