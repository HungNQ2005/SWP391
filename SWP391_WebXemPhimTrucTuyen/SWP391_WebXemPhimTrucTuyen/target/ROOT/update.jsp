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
    <meta charset="UTF-8">
    <title>Cập nhật tài khoản</title>
    <style>
        body {
            background-color: #0d0d0d;
            color: #fff;
            font-family: "Poppins", sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .update-box {
            background: #1a1a1a;
            padding: 40px;
            border-radius: 15px;
            width: 450px;
            box-shadow: 0 0 25px rgba(255, 0, 0, 0.4);
        }

        h2 {
            color: #ff3333;
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 10px;
            color: #ff6666;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 10px;
            background: #111;
            color: #fff;
            border: 1px solid #333;
            border-radius: 8px;
            margin-top: 5px;
        }

        input:focus {
            border-color: #ff3333;
            outline: none;
            box-shadow: 0 0 8px #ff3333;
        }

        input[readonly] {
            background-color: #222;
            color: #aaa;
            cursor: not-allowed;
        }

        .toggle-eye {
            position: absolute;
            right: 10px;
            top: 10px;
            cursor: pointer;
        }

        .error-text {
            color: #ff4d4d;
            font-size: 13px;
            margin-top: 4px;
            min-height: 16px;
        }

        .msg {
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 6px;
        }

        .msg.error { background: #440000; border-left: 4px solid #ff3333; }
        .msg.success { background: #003300; border-left: 4px solid #00cc66; }

        .strength-bar {
            height: 6px;
            border-radius: 4px;
            margin-top: 6px;
            transition: 0.3s;
        }

        ul.rules {
            font-size: 13px;
            color: #ccc;
            margin-top: 5px;
            margin-bottom: 0;
            padding-left: 18px;
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
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-save {
            background: linear-gradient(90deg, #b30000, #ff1a1a);
            color: #fff;
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
    </style>
</head>
<body>
<div class="update-box">
    <h2>Cập nhật tài khoản</h2>

    <% if (error != null) { %>
        <div class="msg error"><%= error %></div>
    <% } else if (success != null) { %>
        <div class="msg success"><%= success %></div>
    <% } %>

    <form id="updateForm" action="<%= request.getContextPath() %>/UpdateAccountServlet" method="post">
        <label>Tên đăng nhập</label>
        <input type="text" name="username" value="<%= user.getUsername() %>" readonly>

        <label>Email</label>
        <input type="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" readonly>

        <label>Mật khẩu hiện tại <span style="color:#ff8080;">*</span></label>
        <div style="position: relative;">
            <input type="password" name="currentPassword" placeholder="Nhập mật khẩu hiện tại" required autocomplete="off">
            <span class="toggle-eye" onclick="togglePassword(this)">👁️</span>
        </div>
        <div class="error-text" id="currentError"></div>

        <label>Mật khẩu mới</label>
        <div style="position: relative;">
            <input type="password" name="newPassword" placeholder="Để trống nếu không muốn đổi" autocomplete="new-password">
            <span class="toggle-eye" onclick="togglePassword(this)">👁️</span>
        </div>
        <div class="strength-bar" id="strengthBar"></div>
        <div class="error-text" id="newError"></div>
        <ul class="rules">
            <li>Tối thiểu 8 ký tự</li>
            <li>Ít nhất 1 chữ hoa, 1 chữ thường</li>
            <li>Ít nhất 1 số và 1 ký tự đặc biệt</li>
        </ul>

        <label>Xác nhận mật khẩu mới</label>
        <div style="position: relative;">
            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu mới" autocomplete="new-password">
            <span class="toggle-eye" onclick="togglePassword(this)">👁️</span>
        </div>
        <div class="error-text" id="confirmError"></div>

        <div class="btn-box">
            <button type="submit" class="btn-save">Lưu</button>
            <a href="profile.jsp" class="btn-cancel">Hủy</a>
        </div>
    </form>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.4.2/zxcvbn.js"></script>
<script>
function togglePassword(el) {
    const input = el.previousElementSibling;
    input.type = input.type === "password" ? "text" : "password";
}

// Kiểm tra hợp lệ khi submit
document.addEventListener("DOMContentLoaded", () => {
    const current = document.querySelector("[name='currentPassword']");
    const newPass = document.querySelector("[name='newPassword']");
    const confirm = document.querySelector("[name='confirmPassword']");
    const bar = document.getElementById("strengthBar");
    const currentErr = document.getElementById("currentError");
    const newErr = document.getElementById("newError");
    const confirmErr = document.getElementById("confirmError");

    const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_\-+=\[{\]};:'",.<>?/|~]).{8,}$/;

    function checkCurrent() {
        if (!current.value.trim()) {
            currentErr.textContent = "⚠️ Vui lòng nhập mật khẩu hiện tại.";
            return false;
        }
        currentErr.textContent = "";
        return true;
    }

    function checkNew() {
        const val = newPass.value.trim();
        if (val === "") {
            newErr.textContent = "";
            bar.style.width = "0";
            return true; // không đổi mật khẩu
        }

        const strength = zxcvbn(val);
        const colors = ["#ff3333","#ff8800","#ffcc00","#99cc00","#00cc66"];
        bar.style.background = colors[strength.score];
        bar.style.width = (strength.score + 1) * 20 + "%";

        if (!strongRegex.test(val)) {
            newErr.textContent = "❌ Mật khẩu chưa đáp ứng yêu cầu.";
            return false;
        }
        newErr.textContent = "";
        return true;
    }

    function checkConfirm() {
        if (newPass.value && confirm.value !== newPass.value) {
            confirmErr.textContent = "❌ Mật khẩu xác nhận không khớp.";
            return false;
        }
        confirmErr.textContent = "";
        return true;
    }

    document.getElementById("updateForm").addEventListener("submit", e => {
        if (!(checkCurrent() && checkNew() && checkConfirm())) {
            e.preventDefault();
            alert("⚠️ Vui lòng sửa lỗi trước khi lưu.");
        }
    });
});
</script>
</body>
</html>
