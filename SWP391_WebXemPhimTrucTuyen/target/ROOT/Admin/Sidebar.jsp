<%-- 
    Document   : Sideber
    Created on : Nov 11, 2025, 3:21:23 PM
    Author     : Chau Tan Cuong - CE190026
--%>

<!DOCTYPE html>
<html>
    
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="admin-info text-center mb-3">
                <img
                    src="${pageContext.request.contextPath}/${sessionScope.guest.avatar_url}"
                    alt="Admin"
                    width="80"
                    height="80"
                    class="rounded-circle"
                    />

            </div>
            <a href="series?action=allOfSeries">Home</a>
            <a href="Ads">Ads Management</a>
            <a href="adminMovie?action=sendSeriesDashboard">Movie Management</a>
            <a href="${pageContext.request.contextPath}/performerAdmin">Performers Management</a>
            <a href="admin?action=sendAccountDashboard" class="active">Accounts Management</a>
            <a href="adminCategory?action=list">Category Management</a>
            <a href="adminCountry?action=list">Country Management</a>
            <a href="${pageContext.request.contextPath}/admin/retail">Retail Management</a>         
            <a href="${pageContext.request.contextPath}/admin/cdkey">CdKey Management</a>
            <a href="#">Episode Management</a>
        </div>
    </body>
</html>
