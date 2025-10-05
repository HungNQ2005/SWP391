<%-- 
    Document   : PerformersInfomation
    Created on : Oct 1, 2025, 5:21:33 PM
    Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Thông tin diễn viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link href="../asset/css/Performerinfo.css" rel="stylesheet" type="text/css"/>
</head>

<body>

    <!-- Infor Actor bên trái -->
    <div class="container py-5">
        <div class="row justify-content-center align-items-start">
            <div class="col-md-4 mt-5">
                <img
                    src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Tom_Holland_by_Gage_Skidmore.jpg/960px-Tom_Holland_by_Gage_Skidmore.jpg"
                    alt="Tom Holland"
                    class="actor-photo"
                />
                <div class="actor-details mt-4 text-start">
                    <h3 class="text-white">Tom Holland</h3>
                    <p>
                        <strong>Giới thiệu:</strong>
                        Thomas Stanley Holland (born 1 June 1996) is an English actor.
                        The recipient of numerous accolades, including a BAFTA Award,
                        he was featured on the Forbes 30 Under 30 Europe list of 2019.
                        Some publications have called him one of the most popular actors of his generation.
                    </p>
                    <p><strong>Giới tính:</strong> Nam</p>
                    <p><strong>Ngày sinh:</strong> 01/06/1996</p>
                </div>
            </div>

            <!-- List phim bên phải -->
            <div class="col-md-8 mt-4 mt-md-0">
                <h3 class="mb-4">Các phim đã tham gia</h3>

                <div class="film-items row g-3">
                    <div class="col-6 col-md-4 col-lg-3">
                        <a href="#" class="film-link">
                            <img src="https://image.tmdb.org/t/p/w500/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg"
                                 alt="Spider-Man: Homecoming"
                                 class="img-fluid rounded shadow-sm"/>
                            <p class="mt-2 text-center text-white">Spider-Man: Homecoming</p>
                        </a>
                    </div>

                    <div class="col-6 col-md-4 col-lg-3">
                        <a href="#" class="film-link">
                            <img src="https://image.tmdb.org/t/p/w500/lcq8dVxeeOqHvvgcte707K0KVx5.jpg"
                                 alt="Spider-Man: Far From Home"
                                 class="img-fluid rounded shadow-sm"/>
                            <p class="mt-2 text-center text-white">Spider-Man: Far From Home</p>
                        </a>
                    </div>

                    <div class="col-6 col-md-4 col-lg-3">
                        <a href="#" class="film-link">
                            <img src="https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg"
                                 alt="Spider-Man: No Way Home"
                                 class="img-fluid rounded shadow-sm"/>
                            <p class="mt-2 text-center text-white">Spider-Man: No Way Home</p>
                        </a>
                    </div>

                    <div class="col-6 col-md-4 col-lg-3">
                        <a href="#" class="film-link">
                            <img src="https://image.tmdb.org/t/p/w500/rJHC1RUORuUhtfNb4Npclx0xnOf.jpg"
                                 alt="Uncharted"
                                 class="img-fluid rounded shadow-sm"/>
                            <p class="mt-2 text-center text-white">Uncharted</p>
                        </a>
                    </div>

                    <div class="col-6 col-md-4 col-lg-3">
                        <a href="#" class="film-link">
                            <img src="https://m.media-amazon.com/images/M/MV5BYmExOWUxZDMtZmM1ZS00NjQ4LWEwODAtY2E0N2Y1Y2MzZTkwXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"
                                 alt="The Devil All the Time"
                                 class="img-fluid rounded shadow-sm"/>
                            <p class="mt-2 text-center text-white">The Devil All the Time</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
