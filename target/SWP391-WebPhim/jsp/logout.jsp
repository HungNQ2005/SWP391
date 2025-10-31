<%-- 
    Document   : logout
    Created on : Oct 27, 2025, 12:03:28 AM
    Author     : Nguyen Van Phi - CE190465
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Xóa session hiện tại
    session.invalidate();

    // Chuyển hướng về trang login
    response.sendRedirect("login.jsp");
%>
