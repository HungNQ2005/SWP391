<%-- 
    Document   : Avatar
    Created on : Oct 20, 2025, 8:46:49 AM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Profile Picture</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="http://localhost:8080/Perfomers/asset/css/updateAvatar.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>
        <div class="upload-container">
            <h2>Update Profile Picture</h2>
            <form action="user" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="updateAvatar">

                <div class="mb-3">
                    <label for="avatar" class="form-label">Choose your profile picture</label>
                    <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*" required>
                </div>

                <button type="submit" class="btn btn-netflix">Upload</button>
                <p class="note">Only image files are accepted (.jpg, .png, .jpeg, etc.)</p>
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
