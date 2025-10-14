<%-- 
    Document   : updateAvatar.jsp
    Created on : Oct 10, 2025, 7:49:47 PM
    Author     : Chau Tan Cuong - CE190026
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Update Ảnh đại diện</h2>
        <form action="user" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="updateAvatar">
            <input type="file" name="avatar" accept="image/*" required>
            <br/>
            <button type="submit">Tải lên</button>
        </form>
    </body>
</html>
