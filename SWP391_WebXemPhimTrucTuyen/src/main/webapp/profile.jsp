<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.User" %>
<%
    User user = (User) session.getAttribute("guest");
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
    <title>Thông tin cá nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            font-family: "Poppins", sans-serif;
            background-color: #0d0d0d;
            color: #fff;
            margin: 0;
            padding: 0;
        }

        .container-box {
            display: flex;
            min-height: 100vh;
            box-shadow: 0 0 25px rgba(255,0,0,0.2);
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background-color: #111;
            border-right: 2px solid #b30000;
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            box-shadow: 3px 0 15px rgba(255,0,0,0.2);
        }

        .sidebar h2 {
            color: #fff;
            font-weight: bold;
            text-align: center;
            margin-bottom: 40px;
        }

        .sidebar a {
            display: block;
            color: #ccc;
            text-decoration: none;
            font-size: 18px;
            margin: 15px 0;
            padding: 10px 15px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #ff1a1a;
            color: #fff;
            box-shadow: 0 0 15px #ff3333;
        }

        /* Main content */
        .main-content {
            flex: 1;
            padding: 50px 60px;
            background-color: #1a1a1a;
            box-shadow: inset 0 0 25px rgba(255,0,0,0.15);
        }

        .main-content h1 {
            color: #fff;
            font-weight: 700;
            font-size: 32px;
            border-bottom: 3px solid #ff1a1a;
            display: inline-block;
            padding-bottom: 8px;
            margin-bottom: 40px;
        }

        .profile-info {
            display: flex;
            align-items: center;
            gap: 50px;
        }

        .avatar-box img {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            border: 4px solid #ff1a1a;
            box-shadow: 0 0 20px #ff3333;
            object-fit: cover;
        }

        .avatar-box p {
            text-align: center;
            margin-top: 10px;
            color: #ccc;
        }

        .info-box p {
            font-size: 18px;
            margin: 10px 0;
        }

        .info-box p strong {
            color: #ff4d4d;
            width: 120px;
            display: inline-block;
        }

        .btn-update {
            margin-top: 20px;
            padding: 10px 25px;
            border: none;
            border-radius: 25px;
            background: linear-gradient(90deg, #b30000, #ff3333);
            color: #fff;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-update:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px #ff4d4d;
        }
    </style>
</head>
<body>
<div class="container-box">
    <!-- Sidebar -->
    <div class="sidebar">
        <a href="series">Back home</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Thông tin cá nhân</h1>
        <div class="profile-info">
            <div class="avatar-box">
                <img src="<%= user.getAvatar_url() != null ? user.getAvatar_url() : "https://i.pinimg.com/originals/6e/ea/71/6eea71cd65edef17878a46e75d2ee5f7.jpg" %>" alt="Avatar"/>
                <p>Avatar</p>
            </div>
            <div class="info-box">
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <p><strong>Username:</strong> <%= user.getUsername() %></p>
                <p><strong>Status:</strong> <%= user.getUser_level() %></p>                      
            </div>
        </div>
    </div>
</div>
</body>
</html>
