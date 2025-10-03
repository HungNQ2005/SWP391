<%-- 
    Document   : forgotpassword.jsp
    Created on : Oct 3, 2025, 5:47:27 PM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Forgot Password</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link href="../css/login.css" rel="stylesheet" type="text/css"/>
  </head>

  <body>
    <div class="login-wrapper">
      <div class="card login-card">
        <div class="row g-0">
          <!-- Cột ảnh -->
          <div class="col-md-6">
            <img
              src="${pageContext.request.contextPath}/Images/imgform.jpg"
              alt="Forgot Password Image"
              class="left-img"
            />
          </div>

          <!-- Cột form -->
          <div class="col-md-6 d-flex align-items-center">
            <div class="p-4 w-100">
              <h2 class="text-light text-center mb-4">Forgot Password</h2>
              <p class="text-light text-center mb-3">
                Enter your registered email below and we’ll send you a link to
                reset your password.
              </p>

              <form action="#" method="post">
                <div class="mb-3">
                  <input
                    type="email"
                    class="form-control"
                    placeholder="Enter your email"
                    name="email"
                    value="${param.email}"
                    required
                  />
                </div>

                <div class="d-grid mb-3">
                  <button type="submit" class="btn btn-danger">
                    Send Reset Link
                  </button>
                </div>

                <div class="d-flex justify-content-between align-items-center text-light">
                  <a href="${pageContext.request.contextPath}/User/login.jsp">Back to Login</a>
                </div>

                <div class="d-grid mt-3">
                  <a href="${pageContext.request.contextPath}/User/login.jsp" class="btn btn-secondary">
                    Cancel
                  </a>
                </div>
              </form>

              <!-- Thông báo -->
              <c:if test="${not empty requestScope.successMsg}">
                <div class="alert alert-success mt-3 text-center">
                  ${requestScope.successMsg}
                </div>
              </c:if>
              <c:if test="${not empty requestScope.errorMsg}">
                <div class="alert alert-danger mt-3 text-center">
                  ${requestScope.errorMsg}
                </div>
              </c:if>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/dangnhap.js"></script>
  </body>
</html>
