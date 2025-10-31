<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Account Activation</title>

  <style>
    /* 🎨 Tổng thể giao diện */
    body {
      background: linear-gradient(145deg, #111, #1a1a1a);
      color: #ffffff;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
      padding: 0;
      overflow: hidden;
    }

    .container {
      background: #1a1a1a;
      padding: 30px 35px;
      border-radius: 14px;
      box-shadow: 0 0 25px rgba(184, 0, 0, 0.45);
      width: 360px;
      text-align: center;
      border: 1px solid #b80000;
      max-height: 90vh;
      overflow-y: auto;
      animation: fadeIn 0.6s ease;
    }

    h2 {
      color: #ff3b3b;
      margin-bottom: 20px;
      font-weight: 700;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      font-size: 22px;
    }

    label {
      display: block;
      text-align: left;
      margin: 6px 0 4px;
      font-size: 13px;
      color: #ccc;
    }

    input[type="text"] {
      width: 100%;
      padding: 9px;
      border: none;
      border-radius: 6px;
      background-color: #202020;
      color: white;
      margin-bottom: 12px;
      font-size: 14px;
      outline: none;
      transition: 0.2s ease;
    }

    input[type="text"]:focus {
      background-color: #292929;
      box-shadow: 0 0 0 2px #ff3b3b;
    }

    .checkbox-group {
      display: flex;
      align-items: center;
      gap: 6px;
      margin: 8px 0 15px;
      font-size: 12.5px;
      color: #ccc;
      text-align: left;
    }

    .checkbox-group input[type="checkbox"] {
      accent-color: #ff3b3b;
      transform: scale(1.1);
      cursor: pointer;
    }

    .checkbox-group a {
      color: #ff3b3b;
      text-decoration: none;
      font-weight: bold;
      cursor: pointer;
    }

    .checkbox-group a:hover {
      text-decoration: underline;
    }

    input[type="submit"] {
      width: 100%;
      padding: 11px;
      background: linear-gradient(90deg, #b80000, #ff3b3b);
      border: none;
      border-radius: 8px;
      color: white;
      font-weight: bold;
      font-size: 14px;
      cursor: pointer;
      transition: all 0.25s ease;
      text-transform: uppercase;
    }

    input[type="submit"]:hover {
      background: linear-gradient(90deg, #ff3b3b, #b80000);
      transform: scale(1.02);
      box-shadow: 0 0 10px rgba(255, 59, 59, 0.6);
    }

    input[type="submit"]:active {
      transform: scale(0.98);
    }

    .message {
      margin-top: 12px;
      background: #202020;
      border-left: 4px solid #ff3b3b;
      padding: 10px;
      border-radius: 6px;
      color: #e5e5e5;
      font-size: 13.5px;
      animation: fadeIn 0.5s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(5px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* 🧾 Modal Điều khoản */
    .modal {
      display: none;
      position: fixed;
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.7);
    }

    .modal-content {
      background-color: #1a1a1a;
      margin: 8% auto;
      padding: 20px;
      border: 1px solid #b80000;
      border-radius: 12px;
      width: 380px;
      color: #fff;
      position: relative;
      text-align: left;
      line-height: 1.6;
    }

    .modal-content h3 {
      color: #ff3b3b;
      margin-top: 0;
    }

    .close {
      color: #ff3b3b;
      position: absolute;
      top: 10px;
      right: 15px;
      font-size: 22px;
      font-weight: bold;
      cursor: pointer;
    }

    .close:hover {
      color: #ff6666;
    }

    /* 📱 Responsive */
    @media (max-width: 420px) {
      .container {
        width: 90%;
        padding: 25px 20px;
      }
      .modal-content {
        width: 90%;
      }
    }
  </style>
</head>

<body>
  <div class="container">
    <h2>Activate Premium</h2>

    <!-- FORM -->
    <form method="post" action="${pageContext.request.contextPath}/activation">
      <label>Username</label>
      <input type="text" name="username" placeholder="Nhập tên tài khoản..." required />

      <label>CD Key</label>
      <input type="text" name="cdkey" placeholder="XXXXX-XXXXX-XXXXX" required />

      <div class="checkbox-group">
        <input type="checkbox" id="agree" name="agree" required />
        <label for="agree">
          Tôi đồng ý với <a id="terms-link">Điều khoản sử dụng</a>
        </label>
      </div>

      <input type="submit" value="Kích hoạt ngay" />
    </form>

    <!-- MESSAGE BOX -->
    <c:choose>
      <c:when test="${not empty message}">
        <div class="message">${message}</div>
      </c:when>
      <c:otherwise>
        <div class="message">💡 Nhập CD Key hợp lệ để kích hoạt Premium.</div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- Modal Điều khoản -->
  <div id="termsModal" class="modal">
    <div class="modal-content">
      <span class="close">&times;</span>
      <h3>Điều khoản sử dụng</h3>
      <p>
        1. Người dùng phải cung cấp thông tin chính xác khi đăng ký.<br>
        2. CD Key chỉ được sử dụng cho một tài khoản duy nhất.<br>
        3. Không được chia sẻ hoặc bán CD Key cho người khác.<br>
        4. Vi phạm điều khoản có thể dẫn đến hủy kích hoạt tài khoản.<br>
        5. Chúng tôi có quyền thay đổi điều khoản mà không cần thông báo trước.<br>
        6. Mỗi key có giá trị sử dụng trong 180 ngày kể từ ngày kích hoạt.
      </p>
    </div>
  </div>

  <script>
    const modal = document.getElementById("termsModal");
    const link = document.getElementById("terms-link");
    const closeBtn = document.querySelector(".close");

    link.onclick = function () {
      modal.style.display = "block";
    };

    closeBtn.onclick = function () {
      modal.style.display = "none";
    };

    window.onclick = function (event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    };
  </script>
</body>
</html>
