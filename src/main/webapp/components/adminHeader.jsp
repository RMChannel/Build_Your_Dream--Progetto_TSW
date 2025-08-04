<%@ page import="Model.Users.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/adminHeader.css">
</head>
  <body>
  <div class="header">
    <h5>Bentornato <%=user.getUsername()%>, clicca <a href="<%=request.getContextPath()%>/adminPage">qui</a> per entrare nella pagina admin</h5>
  </div>
  </body>
</html>
