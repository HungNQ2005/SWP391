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

            <a href="${pageContext.request.contextPath}/series?action=allOfSeries">Home</a>
            <a href="ads">Ads Management</a>
            <a href="movie?action=sendSeriesDashboard">Movie Management</a>
            <a href="${pageContext.request.contextPath}/admin/performer">Performers Management</a>
            <a href="account?action=sendAccountDashboard" class="active">Accounts Management</a>
            <a href="category?action=list">Category Management</a>
            <a href="country?action=list">Country Management</a>
            <a href="${pageContext.request.contextPath}/admin/retail">Retail Management</a>         
            <a href="${pageContext.request.contextPath}/admin/cdkey">CdKey Management</a>
        </div>
    </body>
</html>
