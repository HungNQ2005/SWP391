<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account Activation</title>
    <style>
        body {
            background: #23272A;
            color: white;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .box {
            background: #2C2F33;
            padding: 20px;
            border-radius: 8px;
            width: 350px;
        }
        input[type=text] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: none;
            border-radius: 4px;
        }
        input[type=submit] {
            width: 100%;
            padding: 10px;
            background: #5865F2;
            border: none;
            border-radius: 4px;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        .message {
            margin-top: 10px;
            padding: 10px;
            background: #444;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="box">
        <h2>Activate Premium</h2>
        <form method="post" action="${pageContext.request.contextPath}/activation">
            <label>Username:</label>
            <input type="text" name="username" required />
            <label>CD Key:</label>
            <input type="text" name="cdkey" required placeholder="XXXXX-XXXXX-XXXXX"/>

            <div style="margin: 10px 0;">
                    <input type="checkbox" name="agree" required />
                    <label for="agree">Tôi đồng ý với <a href="#">Điều khoản sử dụng</a></label>
            </div>

            <input type="submit" value="Activate"/>
        </form>
        <%
            String msg = (String) request.getAttribute("message");
            if (msg != null) {
        %>
            <div class="message"><%= msg %></div>
        <% } %>
    </div>
</body>
</html>
