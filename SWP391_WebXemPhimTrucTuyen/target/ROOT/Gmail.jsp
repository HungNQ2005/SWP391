<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.User" %>
<%
    User user = (User) session.getAttribute("guest");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Update Email</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #0d0d0d;
            font-family: "Poppins", sans-serif;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .update-box {
            background-color: #1f1f1f;
            border-radius: 15px;
            padding: 40px;
            width: 420px;
            box-shadow: 0 0 25px rgba(255,0,0,0.4);
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #ff3333;
            margin-bottom: 25px;
            font-weight: 700;
        }

        label {
            color: #ff6666;
            margin-top: 12px;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 10px;
            background-color: #111;
            color: #fff;
            border: 1px solid #333;
            border-radius: 8px;
            margin-top: 5px;
        }

        input:focus {
            outline: none;
            border-color: #ff3333;
            box-shadow: 0 0 8px #ff3333;
        }

        .btn-box {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
        }

        .btn-save, .btn-cancel {
            width: 48%;
            padding: 10px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-save {
            background: linear-gradient(90deg, #b30000, #ff1a1a);
            color: white;
        }

        .btn-save:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px #ff3333;
        }

        .btn-cancel {
            background: #333;
            color: #ccc;
            text-align: center;
            text-decoration: none;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .btn-cancel:hover {
            background: #555;
        }

        .msg {
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 6px;
        }

        .msg.error { background: #440000; border-left: 4px solid #ff3333; }
        .msg.success { background: #003300; border-left: 4px solid #00cc66; }

        .error-text {
            color: #ff4d4d;
            font-size: 13px;
            margin-top: 4px;
            min-height: 16px;
        }
    </style>
</head>
<body>
<div class="update-box">
    <h2>Update Email</h2>

    <% if (error != null) { %>
    <div class="msg error"><%= error %></div>
    <% } else if (success != null) { %>
    <div class="msg success"><%= success %></div>
    <% } %>

    <form id="updateForm" action="<%= request.getContextPath() %>/UpdateEmailServlet" method="post">

        <label>Username</label>
        <input type="text" name="username" value="<%= user.getUsername() %>" readonly style="background-color:#222; cursor:not-allowed;">

        <label>Current Email</label>
        <input type="email" name="oldEmail" placeholder="Nhập email hiện tại" required>
        <div class="error-text" id="oldEmailError"></div>

        <label>New Email</label>
        <input type="email" name="newEmail" placeholder="Nhập email mới" required>
        <div class="error-text" id="newEmailError"></div>

        <div class="btn-box">
            <button type="submit" class="btn-save">Lưu</button>
            <a href="profile.jsp" class="btn-cancel">Quay lại</a>
        </div>
    </form>
</div>

<!-- ✅ Realtime Validation -->
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const oldEmail = document.querySelector("[name='oldEmail']");
        const newEmail = document.querySelector("[name='newEmail']");
        const form = document.getElementById("updateForm");
        const oldEmailErr = document.getElementById("oldEmailError");
        const newEmailErr = document.getElementById("newEmailError");

        function validateEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }

        function checkOldEmail() {
            if (!oldEmail.value.trim()) {
                oldEmailErr.textContent = "⚠️ Vui lòng nhập email hiện tại.";
                return false;
            }
            if (!validateEmail(oldEmail.value)) {
                oldEmailErr.textContent = "❌ Email hiện tại không hợp lệ.";
                return false;
            }
            oldEmailErr.textContent = "";
            return true;
        }

        function checkNewEmail() {
            if (!newEmail.value.trim()) {
                newEmailErr.textContent = "⚠️ Vui lòng nhập email mới.";
                return false;
            }
            if (!validateEmail(newEmail.value)) {
                newEmailErr.textContent = "❌ Email mới không hợp lệ.";
                return false;
            }
            if (oldEmail.value.trim() && oldEmail.value.trim() === newEmail.value.trim()) {
                newEmailErr.textContent = "❌ Email mới không được trùng email cũ.";
                return false;
            }
            newEmailErr.textContent = "";
            return true;
        }

        [oldEmail, newEmail].forEach(i => i.addEventListener("input", () => {
            checkOldEmail(); checkNewEmail();
        }));

        form.addEventListener("submit", e => {
            if (!(checkOldEmail() && checkNewEmail())) {
                e.preventDefault();
                alert("⚠️ Vui lòng kiểm tra lại thông tin email.");
            }
        });
    });
</script>
</body>
</html>
