<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="refresh" content="5;url=login.jsp" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Password Reset Successful</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

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

    .redirect {
      margin-top: 25px;
      font-size: 13.5px;
      color: #aaa;
    }

    .btn-back {
      margin-top: 20px;
      background: linear-gradient(90deg,#86090d,#a61313);
      color: #fff;
      border: none;
    }
    .btn-back:hover {
      background: linear-gradient(90deg,#a61313,#dc3545);
      color: #fff;
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

  <script>
    setTimeout(function () {
      window.location.href = "login.jsp";
    }, 5000);
  </script>
</head>

<body>
  <div class="success-box">
    <div class="success-icon">✅</div>
    <h2>Password Reset Successful!</h2>
    <p>Your password has been reset successfully.<br>
       You will be redirected to the login page in <strong>5 seconds</strong>.
    </p>
    <a href="login.jsp" class="btn btn-back">Back to Login Now</a>
  </div>

  <div class="glow"></div>
</body>
</html>
