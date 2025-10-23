<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Reset Password</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="css/login.css" />
        <style>
            .position-relative {
                position: relative;
            }
            .toggle-password {
                position: absolute;
                top: 50%;
                right: 15px;
                transform: translateY(-50%);
                cursor: pointer;
                user-select: none;
            }
            .left-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        </style>
    </head>

    <body>
        <div class="login-wrapper">
            <div class="card login-card">
                <div class="row g-0">
                    <div class="col-md-6">
                        <img src="Images/imgform.jpg" alt="Reset Password Image" class="left-img" />
                    </div>

                    <div class="col-md-6 d-flex align-items-center">
                        <div class="p-4 w-100">
                            <h2 class="text-light text-center mb-4">Reset Password</h2>
                            <p class="text-light text-center mb-3">Enter your new password below.</p>

                            <form action="user" method="post">
                                <input type="hidden" name="action" value="resetPassword" />
                                <!-- Token nh?n t? servlet -->
                                <input type="hidden" name="token" value="${token}" />

                                <div class="mb-3">
                                    <input
                                        type="password"
                                        name="password"
                                        class="form-control"
                                        placeholder="New Password"
                                        required
                                        />
                                </div>

                                <div class="d-grid mb-3">
                                    <button type="submit" class="btn btn-danger">Reset Password</button>
                                </div>

                                <div class="text-center">
                                    <a href="user?action=sendLogin" class="text-light">Back to Login</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
