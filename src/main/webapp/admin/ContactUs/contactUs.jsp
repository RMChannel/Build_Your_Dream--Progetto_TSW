<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione ContactUs</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/ContactUs/contactUs.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
    <a href="<%=request.getContextPath()%>/adminPage" class="admin-back-btn" title="Torna indietro">
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" style="vertical-align:middle; margin-right:6px;"><path d="M13.5 17L8 11L13.5 5" stroke="#0074D9" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/></svg>
        Indietro
    </a>
    <div class="contactus-table-container">
        <div class="contactus-title">Messaggi ContactUs</div>
        <table class="contactus-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Messaggio</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="msg" items="${messages}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${msg.name}</td>
                        <td>${msg.email}</td>
                        <td>${msg.message}</td>
                        <td><button class="contactus-delete-btn" onclick="deleteMessage(${msg.ID})">Cancella</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
<script>
    function deleteMessage(id) {
        const data = new URLSearchParams();
        data.append('id', id);

        fetch('<%= request.getContextPath() %>/removeMessage', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data
        })
            .then(response => {
                if (!response.ok) throw new Error("Errore nella richiesta");
                return response.text();
            })
            .then(result => {
                location.reload();
            })
            .catch(error => {
                console.error("Errore:", error);
            });
    }
</script>
</html>
