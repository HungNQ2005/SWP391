<%-- 
    Document   : login
    Created on : Oct 26, 2025, 10:10:47 PM
    Author     : Nguyen Van Phi - CE190465
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.UserDAO, model.User" %>
<%
    String errorMessage = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByUsername(username);

        if (user != null && password.equals(user.getPasswordHash())) { // ⚠️ Nếu dùng hash, cần so sánh hash
            session.setAttribute("currentUser", user);
            response.sendRedirect("account.jsp");
            return;
        } else {
            errorMessage = "Tên đăng nhập hoặc mật khẩu không đúng!";
        }
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="http://localhost:8080/SWP391-WebPhim/css/account.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container mt-5">
    <h2>Đăng nhập</h2>
    <form method="post" class="mt-3">
        <% if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required/>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu</label>
            <input type="password" class="form-control" id="password" name="password" required/>
        </div>
        <button type="submit" class="btn btn-primary">Đăng nhập</button>
    </form>
</div>
</body>
</html>

