<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Netflop Premium</title>

  <!-- ✅ CSS nội tuyến để bạn dễ test (sau có thể tách ra Premium.css) -->
  <style>
   /* ===========================
   Premium.css - Fixed layout
   =========================== */
body {
  margin: 0;
  padding: 0;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: radial-gradient(circle at center, #111 0%, #000 100%);
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  color: #fff;
  overflow: hidden; /* ✅ Ngăn tràn dọc */
}

.container {
  text-align: center;
  background: rgba(20, 20, 20, 0.9);
  border-radius: 20px;
  padding: 30px 50px;
  box-shadow: 0 0 25px 5px rgba(255, 0, 0, 0.3); /* ✅ Giữ glow nhưng không làm tràn */
  max-width: 400px;
  width: 90%;
}

h1 {
  color: #ff4040;
  margin-bottom: 25px;
  font-size: 1.8em;
}

.plan-card {
  background: #181818;
  border-radius: 15px;
  padding: 20px;
  box-shadow: inset 0 0 10px rgba(255, 0, 0, 0.2);
}

.premium-img {
  width: 200px;
  height: auto;
  border-radius: 10px;
  margin-bottom: 15px;
}

h2 {
  color: #ff3b3b;
  font-size: 1.4em;
  margin-bottom: 10px;
}

.label {
  font-weight: bold;
  color: #fff;
}

.value {
  color: #ff6666;
}

.buy-btn {
  display: inline-block;
  background: linear-gradient(90deg, #ff0000, #ff4d4d);
  color: white;
  padding: 12px 30px;
  border-radius: 25px;
  text-decoration: none;
  font-weight: bold;
  font-size: 1em;
  transition: 0.3s;
  margin-top: 20px;
}

.buy-btn:hover {
  transform: scale(1.05);
  box-shadow: 0 0 20px rgba(255, 50, 50, 0.7);
}

/* ✅ Responsive */
@media (max-height: 650px) {
  body {
    overflow-y: auto; /* Cho phép cuộn nếu màn hình quá nhỏ */
  }
}

  </style>
</head>
<body>
  <div class="container">
    
    <h1>Welcome to Netflop Premium</h1>

    <div class="plan-card">
      <!-- ✅ Ảnh trực tiếp từ URL -->
      <img 
        src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHSjLj8WyOsveqO1GQE67dbly1Ter9iabdDA&s" 
        alt="Premium Plan"
        class="premium-img"
      >

      <!-- ✅ Bỏ dòng “Premium Plan” -->
      <p><span class="label">Price:</span> <span class="value">$12.99</span></p>
      <p><span class="label">Time:</span> <span class="value">6 months</span></p>

      <!-- ✅ Nút dẫn sang trang kích hoạt -->
      <a href="${pageContext.request.contextPath}/jsp/activation.jsp" class="buy-btn">Buy Now</a>
    </div>
  </div>
</body>
</html>