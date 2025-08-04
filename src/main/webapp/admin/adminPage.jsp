<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Build Your Dream - Admin Page</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
    <a href="<%=request.getContextPath()%>/" class="admin-back-btn" title="Torna al sito">
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" style="vertical-align:middle; margin-right:6px;"><path d="M13.5 17L8 11L13.5 5" stroke="#0074D9" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/></svg>
        Torna al sito
    </a>
    <h1 class="admin-title">Area Amministrazione</h1>
    <div class="admin-quadrants-container">
        <div class="admin-quadrant">
            <div class="admin-quadrant-title">Gestione Ordini</div>
            <div class="admin-quadrant-desc">Visualizza e gestisci tutti gli ordini degli utenti.</div>
            <button class="admin-quadrant-btn" onclick="changePage('orders')">Vai</button>
        </div>
        <div class="admin-quadrant">
            <c:if test="${isBloccato}">
                <div class="admin-quadrant-title">Sblocca Sito</div>
                <div class="admin-quadrant-desc">Il sito è attualmente bloccato per manutenzione.</div>
                <button class="admin-quadrant-btn" onclick="bloccaSito()">Sblocca</button>
            </c:if>
            <c:if test="${!isBloccato}">
                <div class="admin-quadrant-title">Blocca Sito</div>
                <div class="admin-quadrant-desc">Blocca temporaneamente l'accesso al sito per manutenzione.</div>
                <button class="admin-quadrant-btn" onclick="bloccaSito()">Blocca</button>
            </c:if>
        </div>
        <div class="admin-quadrant">
            <div class="admin-quadrant-title">Gestione Prodotti</div>
            <div class="admin-quadrant-desc">Aggiungi, modifica o rimuovi prodotti dal catalogo.</div>
            <button class="admin-quadrant-btn" onclick="changePage('gestioneProdotti')">Gestisci</button>
        </div>
        <div class="admin-quadrant">
            <div class="admin-quadrant-title">Gestione Utenti</div>
            <div class="admin-quadrant-desc">Visualizza e modifica i dati degli utenti registrati.</div>
            <button class="admin-quadrant-btn" onclick="changePage('users')">Utenti</button>
        </div>
        <div class="admin-quadrant">
            <div class="admin-quadrant-title">Gestione NewsLetter</div>
            <div class="admin-quadrant-desc">Visualizza tutte le email che si sono iscritte alla newsletter.</div>
            <button class="admin-quadrant-btn" onclick="changePage('newsletter')">Gestione Newsletter</button>
        </div>
        <div class="admin-quadrant">
            <div class="admin-quadrant-title">Gestione messaggi</div>
            <div class="admin-quadrant-desc">Visualizza i messaggi inviati tramite il form "Contattaci".</div>
            <button class="admin-quadrant-btn" onclick="changePage('contactus')">Gestione messaggi</button>
        </div>
    </div>
</body>
<script>
    function bloccaSito() {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = "<%=request.getContextPath()%>/bloccaSito";
        form.target='_self';
        document.body.appendChild(form);
        form.submit();
    }

    function changePage(page) {
        const form = document.createElement('form');
        if(page==='gestioneProdotti') {
            form.method = 'GET';
            form.action = "<%=request.getContextPath()%>/adminPage/gestioneProdotti";
            form.target='_self';
        }
        else {
            form.method = 'POST';
            form.action = "<%=request.getContextPath()%>/adminPage";
            form.target='_self';
            const input1 = document.createElement('input');
            input1.type = 'hidden';
            input1.name = 'page';
            input1.value = page;
            form.appendChild(input1);
        }
        document.body.appendChild(form);
        form.submit();
    }
</script>
</html>