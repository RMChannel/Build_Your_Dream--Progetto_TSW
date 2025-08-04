<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Newsletter</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/NewsLetter/gestioneNewsletter.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
    <a href="<%=request.getContextPath()%>/admin/adminPage.jsp" class="admin-back-btn" title="Torna indietro">
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" style="vertical-align:middle; margin-right:6px;"><path d="M13.5 17L8 11L13.5 5" stroke="#0074D9" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/></svg>
        Indietro
    </a>
    <div class="newsletter-table-container">
        <div class="newsletter-title">Email Newsletter</div>
        <table class="newsletter-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="email" items="${emails}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${email}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
