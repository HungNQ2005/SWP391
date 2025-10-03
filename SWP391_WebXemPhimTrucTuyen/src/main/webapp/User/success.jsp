<%-- 
    Document   : success.jsp
    Created on : Oct 3, 2025, 6:12:51 PM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Password Reset Successful</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" />
    <script>
      setTimeout(function () {
        window.location.href = "${pageContext.request.contextPath}/login.jsp";
      }, 5000);
    </script>
  </head>

  <body>
    <div class="login-wrapper">
      <div class="card login-card text-center p-4">
        <h2 class="text-light mb-3">Password Reset Successful</h2>
        <p class="text-light">
          Your password has been reset successfully.<br />
          You will be redirected to the login page in
          <strong>5 seconds</strong>.
        </p>
        <a href="${pageContext.request.contextPath}/User/login.jsp" class="btn btn-danger mt-3"> 
          Back to Login Now 
        </a>
      </div>
    </div>
  </body>
</html>
