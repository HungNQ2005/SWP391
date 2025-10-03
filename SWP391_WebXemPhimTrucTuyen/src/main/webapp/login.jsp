<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Login</title>
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
                        <img src="Images/imgform.jpg" alt="Login Image" class="left-img" />
                    </div>

                    <div class="col-md-6 d-flex align-items-center">
                        <div class="p-4 w-100">
                            <h2 class="text-light text-center mb-4">Login</h2>
                            <p class="text-light text-center mb-3">
                                If you don't have an account,
                                <a href="${pageContext.request.contextPath}/user?action=sendSignUp">register now</a>
                            </p>

                            <form action="${pageContext.request.contextPath}/user" method="post">
                                <input type="hidden" name="action" value="login">
                                <div class="mb-3">
                                    <input
                                        type="text"
                                        class="form-control"
                                        placeholder="Username"
                                        name="username"
                                        required
                                        />
                                </div>

                                <div class="mb-3 position-relative">
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
                                        >👁</span
                                    >
                                </div>

                                <div class="d-grid mb-3">
                                    <button type="submit" class="btn btn-danger">Login</button>
                                </div>
                            </form>


                            <div
                                class="d-flex justify-content-between align-items-center text-light"
                                >
                                <div>
                                    <input type="checkbox" name="remember" checked />
                                    <label>Remember me</label>
                                </div>
                                <a href="${pageContext.request.contextPath}/user?action=sendFogortPassword">Forgot password?</a>
                            </div>

                            <div class="d-grid mt-3">
                                <button type="button" class="btn btn-secondary">
                                    Cancel
                                </button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/dangnhap.js"></script>
    </body>
</html>
