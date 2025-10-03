<%-- 
    Document   : contactus.jsp
    Created on : Oct 3, 2025, 5:44:17 PM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Contact Us</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css" />
  </head>

  <body>
    <div class="container py-5">
      <a href="${pageContext.request.contextPath}/index.jsp" class="back-btn mb-4 d-inline-block">
        <i class="fa-solid fa-arrow-left"></i>
      </a>

      <div class="row g-4 align-items-stretch">
        <!-- Info -->
        <div class="col-lg-6 d-flex flex-column justify-content-center">
          <h2 class="fw-bold mb-4">Contact Netflop</h2>
          <p class="text-secondary mb-5 fs-5">
            If you encounter any issues while watching movies or want to
            cooperate, please contact us.
          </p>

          <div class="d-flex align-items-center mb-4 fs-5">
            <i class="fa-solid fa-envelope fs-3 me-3"></i>
            <div>
              <div class="fw-bold">Email :</div>
              <small class="text-secondary">support@netflop.com</small>
            </div>
          </div>

          <div class="d-flex align-items-center mb-4 fs-5">
            <i class="fa-solid fa-phone fs-3 me-3"></i>
            <div>
              <div class="fw-bold">Hotline :</div>
              <small class="text-secondary">0123 456 789</small>
            </div>
          </div>

          <div>
            <div class="fw-bold mb-2 fs-5">Social :</div>
            <div class="d-flex gap-4 fs-3">
              <a href="#" class="social-link"><i class="fa-brands fa-facebook"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-tiktok"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-x-twitter"></i></a>
            </div>
          </div>
        </div>

        <!-- Contact form -->
        <div class="col-lg-6">
          <div class="contact-box h-100">
            <h2 class="text-center">Contact Us</h2>
            <p class="text-secondary text-center mb-4">
              Fill up the form below to send us a message.
            </p>

            <form action="${pageContext.request.contextPath}/contact" method="post">
              <div class="mb-3">
                <input
                  type="text"
                  class="form-control"
                  placeholder="Full Name"
                  name="fullname"
                  value="${param.fullname}"
                  required
                />
              </div>
              <div class="mb-3">
                <input
                  type="email"
                  class="form-control"
                  placeholder="Email"
                  name="email"
                  value="${param.email}"
                  required
                />
              </div>
              <div class="mb-3">
                <textarea
                  class="form-control"
                  rows="5"
                  placeholder="Message"
                  name="message"
                  required
                >${param.message}</textarea>
              </div>
              <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-red w-50">Send</button>
              </div>
            </form>

            <!-- Hiển thị thông báo -->
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
  </body>
</html>
