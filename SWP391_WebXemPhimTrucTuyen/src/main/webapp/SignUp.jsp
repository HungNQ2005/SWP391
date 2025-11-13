<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sign up</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link href="css/signup.css" rel="stylesheet" type="text/css"/>

    </head>

    <body>
        <div class="login-wrapper">
            <div class="card login-card">
                <div class="row g-0">
                    <div class="col-md-6">
                        <img src="${pageContext.request.contextPath}/Images/imgform.jpg" alt="Login Image" class="left-img" />
                    </div>

                    <div class="col-md-6 d-flex align-items-center">
                        <div class="p-4 w-100">
                            <h2 class="text-light text-center mb-4">Sign Up</h2>
                            <p class="text-light text-center mb-3">
                                If you have an account, 
                                <a href="${pageContext.request.contextPath}/User/login.jsp">login now</a>
                            </p>

                            <c:if test="${not empty requestScope.errorMsg}">
                                <div class="alert alert-danger" style="color:red;">
                                    <c:out value="${requestScope.errorMsg}" escapeXml="false"/>
                                </div>
                            </c:if>

                            <c:if test="${not empty requestScope.message}">
                                <div class="alert alert-success" style="color:green;">
                                        ${requestScope.message}
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/user" method="post">
                                <input type="hidden" name="action" value="signUp" />

                                <div class="mb-4">
                                    <input
                                        type="text"
                                        class="form-control"
                                        placeholder="Username"
                                        name="username"
                                        required
                                        />
                                </div>
                                <div class="mb-4">
                                    <input
                                        type="email"
                                        class="form-control"
                                        placeholder="Email"
                                        name="email"
                                        required
                                        />
                                </div>
                                <div class="mb-4 position-relative">
                                    <input
                                        id="password1"
                                        type="password"
                                        class="form-control"
                                        placeholder="Password"
                                        name="password"
                                        required
                                        />
                                    <span
                                        class="toggle-password"
                                        onclick="togglePassword('password1')"
                                        >👁</span>
                                </div>

                                <div class="mb-4 position-relative">
                                    <input
                                        id="password2"
                                        type="password"
                                        class="form-control"
                                        placeholder="Confirm password"
                                        name="passwordConfirm"
                                        required
                                        />
                                    <span
                                        class="toggle-password"
                                        onclick="togglePassword('password2')"
                                        >👁</span>
                                </div>



                                <div class="d-grid mb-4">
                                    <button type="submit" class="btn btn-danger">Sign Up</button>
                                </div>
                            </form>

                            <div class="d-grid mt-4">
                                <a href="${pageContext.request.contextPath}/series?action=allOfSeries" class="btn btn-secondary">
                                    Cancel
                                </a>
                            </div>

                           
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/Signup.js"></script>
    </body>
</html>