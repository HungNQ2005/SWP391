<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Forgot Password</title>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="css/login.css" />
    </head>

    <body>
        <div class="login-wrapper">
            <div class="card login-card">
                <div class="row g-0">
                    <div class="col-md-6">
                        <img
                            src="Images/imgform.jpg"
                            alt="Forgot Password Image"
                            class="left-img"
                            />
                    </div>

                    <div class="col-md-6 d-flex align-items-center">
                        <div class="p-4 w-100">
                            <h2 class="text-light text-center mb-4">Forgot Password</h2>
                            <p class="text-light text-center mb-3">
                                Enter your registered email below and weâ€™ll send you a link to
                                reset your password.
                            </p>

                            <!-- Thông báo -->
                            <c:if test="${not empty message}">
                                <div class="alert alert-success text-center">${message}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger text-center">${error}</div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/user" method="post">
                                <input type="hidden" name="action" value="forgotPassword">
                                <div class="mb-3">
                                    <input
                                        type="email"
                                        class="form-control"
                                        placeholder="Enter your email"
                                        name="email"
                                        required
                                        />
                                </div>

                                <div class="d-grid mb-3">
                                    <button type="submit" class="btn btn-danger">
                                        Send Reset Link
                                    </button>
                                </div>

                                <div
                                    class="d-flex justify-content-between align-items-center text-light"
                                    >
                                    <a href="login.html">Back to Login</a>
                                </div>

                                <div class="d-grid mt-3">
                                    <button
                                        type="button"
                                        class="btn btn-secondary"
                                        onclick="window.location.href = 'login.jsp'"
                                        >
                                        Cancel
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/dangnhap.js"></script>
    </body>
</html>
