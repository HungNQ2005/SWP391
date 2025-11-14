<%-- 
Document   : PerformerDetail.
Created on : Oct 8, 2025, 8:15:17 PM
Author     : Vo Thi Phi Yen - CE190428
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title> Thông tin diễn viên</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/asset/css/PerformerDetails.css" rel="stylesheet">
    </head>

    <body class="bg-dark text-white">
        <div class="container py-5">
            <a href="${pageContext.request.contextPath}/admin/performer" class="text-secondary text-decoration-none mb-4 d-inline-block">
                <i class="bi bi-arrow-left"></i> Quay Lại
            </a>
            <div class="row g-5">

                <div class="col-md-4 text-center">

                    <img src="${pageContext.request.contextPath}/${performer.photoUrl}" 
                         alt="${performer.name}"  class="img-fluid rounded shadow-lg">
                </div>
                <div class="col-md-8">
                    <h2 class="fw-bold">${performer.name}</h2>
                    <p class="text-secondary mb-1">
                        Giới Tính: 
                        <strong>
                            <c:choose>
                                <c:when test="${performer.gender == 'Male'}">Nam</c:when>
                                <c:when test="${performer.gender == 'Female'}">Nữ</c:when>
                            </c:choose>
                        </strong>
                    </p>

                    <p class="text-secondary mb-1">Ngày Sinh: <strong>${performer.dateOfBirth}</strong></p>
                    <p class="text-secondary mb-1">Quốc Gia <strong>${performer.nationality}</strong></p>
                    <hr>
                    <h5 class="mt-3">Mô Tả</h5>
                    <p>${performer.description}</p>
                </div>
            </div>
        </div>

    </body>
</html>
