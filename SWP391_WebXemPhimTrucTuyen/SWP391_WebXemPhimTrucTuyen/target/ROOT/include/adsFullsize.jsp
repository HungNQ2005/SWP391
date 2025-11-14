<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, dao.AdsDAO, entity.Ads" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    AdsDAO dao = new AdsDAO();
    List<Ads> activeAds = dao.getActiveAds();
    request.setAttribute("activeAds", activeAds);
%>

<c:if test="${sessionScope.guest == null || sessionScope.guest.user_level ne 'premium'}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Ads.css">

    <div class="ads-footer fixed-bottom">
        <button id="closeAdsBtn" class="close-ads-btn">&times;</button>

        <c:if test="${not empty activeAds}">
            <div id="adsCarousel" class="carousel slide ads-carouselFull" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="ad" items="${activeAds}" varStatus="loop">
                        <div class="carousel-item ${loop.first ? 'active' : ''}">
                            <a href="${ad.ads_link}" target="_blank">
                                <img src="${pageContext.request.contextPath}${ad.ads_image}" class="d-block w-100 ads-imageFull" alt="${ad.ads_name}">
                            </a>
                            <div class="carousel-caption ads-caption">
                                <h5>${ad.ads_name}</h5>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <button class="carousel-control-prev" type="button" data-bs-target="#adsCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#adsCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>
            </div>
        </c:if>

        <c:if test="${empty activeAds}">
            <div class="alert alert-warning text-center">⚠️ Không có quảng cáo nào đang hoạt động.</div>
        </c:if>

        <script>
            const closeBtn = document.getElementById('closeAdsBtn');
            const adsFooter = document.querySelector('.ads-footer');

            closeBtn.addEventListener('click', () => {
                adsFooter.style.display = 'none';
                setTimeout(() => {
                    adsFooter.style.display = 'block';
                }, 3000);
            });
        </script>
    </div>
</c:if>
