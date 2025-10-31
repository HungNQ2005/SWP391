<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản lí tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="http://localhost:8080/SWP391-WebPhim/css/account.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="account-container container py-5">
    <div class="account-box d-flex">
        <aside class="sidebar p-3">
            <h3>Quản lí tài khoản</h3>
            <ul>
                <li onclick="window.location.href='watchList.html'">
                    <i class="fa-solid fa-plus"></i> Watch List
                </li>
                
                <li class="active" onclick="window.location.href='account.jsp'">
                    <i class="fa-solid fa-user"></i> Account
                </li>
                <li onclick="window.location.href='logout.jsp'">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </li>
            </ul>
        </aside>

        <main class="account-info flex-grow-1 p-4">
            <h2>Thông tin cá nhân</h2>
            <div class="info-row d-flex align-items-center">
                <div class="avatar me-4 text-center">
                    <img src="<%= user.getAvatarUrl() != null ? user.getAvatarUrl() : "https://i.pinimg.com/originals/6e/ea/71/6eea71cd65edef17878a46e75d2ee5f7.jpg" %>"
                         alt="Avatar" class="rounded-circle" width="120" height="120"/>
                    <p class="mt-2">Avatar</p>
                </div>
                <div class="details">
                    <p><strong>Email:</strong> <%= user.getEmail() %></p>
                    <p><strong>Username:</strong> <%= user.getUsername() %></p>
                    <p><strong>Status:</strong> <%= user.getUserLevel() %></p>
                    <p><strong>Join Date:</strong> <%= user.getCreatedAt() %></p>
                </div>
            </div>
            <button class="btn btn-danger mt-4" onclick="window.location.href='update.jsp'">Update</button>
        </main>
    </div>
</div>
</body>
</html>
