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
        <link href="../css/performerinfomation.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <a href="${pageContext.request.contextPath}/performer/list" class="text-secondary text-decoration-none mb-4 d-inline-block">
            <i class="bi bi-arrow-left"></i> Quay Lại
        </a>
        <div class="container py-5">
            <div class="row justify-content-center align-items-start">
                <div class="col-md-4 mt-5">
                    <img
                        src="${pageContext.request.contextPath}/${performer.photoUrl}" alt="${performer.name}"
                        class="actor-photo"/>
                    <div class="actor-details mt-4 text-start">
                        <h3 class="text-white">${performer.name}</h3>
                        <p>
                            <strong>Giới thiệu:</strong>
                            ${performer.description}
                        </p>
                        <p><strong>Giới tính:</strong> ${performer.gender}</p>
                        <p><strong>Ngày sinh:</strong> ${performer.dateOfBirth}</p>
                    </div>
                </div>

                <div class="col-md-8 mt-4 mt-md-0">
                    <h3 class="mb-4">Các phim đã tham gia</h3>

                    <div class="film-items row g-3">
                        <c:forEach var="s" items="${seriesList}">
                            <div class="col-6 col-md-4 col-lg-3">
                                <a href="seriesDetail?id=${s.seriesID}" class="film-link">
                                    <img src="${pageContext.request.contextPath}/${s.posteUrl}"
                                         alt="${s.title}"
                                         class="img-fluid rounded shadow-sm"/>
                                    <p class="mt-2 text-center text-white">${s.title}</p>
                                </a>
                            </div>
                        </c:forEach>
                    </div>

                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                </body>
                </html>
