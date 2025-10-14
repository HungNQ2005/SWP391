<%@ page import="entity.User" %>
<%
    User user = (User) session.getAttribute("guest");
%>
<h2>Xin chào, <%= user.getUsername() %></h2>

<img src="<%= user.getAvatar_url() %>" width="150" height="150" alt="Avatar">

<br><a href="updateAvatar.jsp">C?p nh?t ?nh ??i di?n</a>
