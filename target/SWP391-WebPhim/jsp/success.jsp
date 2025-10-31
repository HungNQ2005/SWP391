<%-- 
    Document   : success
    Created on : Oct 31, 2025, 2:08:23 PM
    Author     : Nguyen Van Phi - CE190465
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%
    // ✅ Tính ngày bắt đầu và kết thúc (180 ngày)
    LocalDate startDate = LocalDate.now();
    LocalDate endDate = startDate.plusDays(180);
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="refresh" content="5;url=${pageContext.request.contextPath}/jsp/home.jsp" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Success - Netflop Premium</title>

  <style>
    body {
      margin: 0;
      padding: 0;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      background: radial-gradient(circle at center, #111 0%, #000 100%);
      color: #fff;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      overflow: hidden;
    }

    .success-box {
      background: rgba(20, 20, 20, 0.95);
      border: 1px solid #ff2a2a;
      box-shadow: 0 0 25px rgba(255, 50, 50, 0.4);
      border-radius: 20px;
      padding: 40px 60px;
      text-align: center;
      max-width: 450px;
      animation: fadeIn 0.8s ease;
    }

    .success-icon {
      font-size: 60px;
      color: #00ff88;
      margin-bottom: 20px;
      animation: pop 0.6s ease-out;
    }

    h2 {
      color: #ff4040;
      margin-bottom: 15px;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    p {
      margin: 6px 0;
      font-size: 15px;
      color: #ccc;
    }

    .date-range {
      color: #ff6666;
      font-weight: bold;
    }

    .redirect {
      margin-top: 25px;
      font-size: 13.5px;
      color: #aaa;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes pop {
      from { transform: scale(0.6); opacity: 0; }
      to { transform: scale(1); opacity: 1; }
    }

    .glow {
      position: absolute;
      width: 300px;
      height: 300px;
      background: radial-gradient(circle, rgba(255,0,0,0.3) 0%, transparent 70%);
      animation: glowPulse 2s infinite alternate;
      z-index: -1;
    }

    @keyframes glowPulse {
      from { transform: scale(1); opacity: 0.4; }
      to { transform: scale(1.3); opacity: 0.7; }
    }
  </style>
</head>
<body>
  <div class="success-box">
    <div class="success-icon">✅</div>
    <h2>Premium Activated!</h2>
    <p>Bạn đã mua gói <b>Netflop Premium</b> thành công 🎉</p>
    <p>Thời gian sử dụng: <span class="date-range">
      <%= startDate.format(formatter) %> → <%= endDate.format(formatter) %>
    </span></p>
    <p>Thời hạn: <b>180 ngày</b></p>

    <div class="redirect">
      ⏳ Bạn sẽ được chuyển hướng về <b>Home</b> trong 5 giây...<br>
      Nếu không, <a href="${pageContext.request.contextPath}/jsp/home.jsp" style="color:#ff4d4d; text-decoration:none;">nhấn vào đây</a>.
    </div>
  </div>

  <div class="glow"></div>
</body>
</html>
