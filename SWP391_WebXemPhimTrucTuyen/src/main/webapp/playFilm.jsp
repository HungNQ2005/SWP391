html
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String id = request.getParameter("id");
    if (id == null) { out.println("Missing id"); return; }
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Play Film</title>
    <style>video{width:100%;max-width:960px;height:auto;}</style>
</head>
<body>
<video controls poster="<%= request.getParameter("poster") != null ? request.getParameter("poster") : "" %>">
    <source src="<%= request.getContextPath() %>/film?id=<%= id %>" type="video/mp4">
    Your browser does not support the video tag.
</video>
</body>
</html>
