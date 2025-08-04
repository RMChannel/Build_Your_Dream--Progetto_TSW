<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Gestione Ordini</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/ordini/gestioneOrdini.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <style>
        .sr-only {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border: 0;
        }
    </style>
</head>
<body>
    <a href="<%=request.getContextPath()%>/adminPage" class="admin-back-btn" title="Torna indietro">
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" class="back-icon"><path d="M13.5 17L8 11L13.5 5" stroke="#0074D9" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/></svg>
        Indietro
    </a>
    <div class="gestione-ordini-table-container">
        <div class="gestione-ordini-title">Gestione Ordini</div>
        <form class="ordini-search-form" onsubmit="event.preventDefault(); filtraOrdini();">
            <label for="searchId">Cerca per ID ordine:</label>
            <input type="number" id="searchId" min="1" placeholder="ID ordine">
            <button type="submit">Cerca</button>
        </form>
        <div class="gestione-ordini-table-responsive">
            <table class="gestione-ordini-table">
                <thead>
                    <tr>
                        <th>ID Ordine</th>
                        <th>Stato</th>
                        <th>Data</th>
                        <th>Utente</th>
                        <th>Telefono</th>
                        <th>Indirizzo</th>
                        <th>Totale</th>
                        <th>Prodotti</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ordine" items="${orders}" varStatus="status">
                        <tr class="ordine-row" data-ordine-id="${ordine.codice}">
                            <td>${ordine.codice}</td>
                            <td>
                                <form class="update-stato-form" data-ordine-id="${ordine.codice}" onsubmit="return aggiornaStatoOrdine(event, this);">
                                    <input type="hidden" name="ordineId" value="${ordine.codice}" />
                                    <label for="stato-${ordine.codice}" class="sr-only">Stato ordine ${ordine.codice}</label>
                                    <select name="stato" id="stato-${ordine.codice}">
                                        <option value="-2" ${ordine.status == -2 ? 'selected' : ''}>Annullato</option>
                                        <option value="-1" ${ordine.status == -1 ? 'selected' : ''}>Rimborsato</option>
                                        <option value="0" ${ordine.status == 0 ? 'selected' : ''}>In preparazione</option>
                                        <option value="1" ${ordine.status == 1 ? 'selected' : ''}>Spedito</option>
                                        <option value="2" ${ordine.status == 2 ? 'selected' : ''}>Consegnato</option>
                                    </select>
                                    <button type="submit">Salva</button>
                                </form>
                            </td>
                            <td>${ordine.data}</td>
                            <td>${ordine.id_user}</td>
                            <td>${ordine.nTel}</td>
                            <td>${ordine.via}, ${ordine.civico}, ${ordine.cap}, ${ordine.citta}</td>
                            <td>€ <fmt:formatNumber value="${ordine.totale}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                            <td>
                                <ul>
                                    <c:forEach var="item" items="${ordine.carrello.objects}">
                                        <li>${item.object.toString()} x ${item.quantity}</li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
<script>
function filtraOrdini() {
    var searchId = document.getElementById('searchId').value.trim();
    var rows = document.querySelectorAll('.ordine-row');
    if (!searchId) {
        rows.forEach(row => row.style.display = '');
        return;
    }
    rows.forEach(row => {
        if (row.getAttribute('data-ordine-id') === searchId) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

function aggiornaStatoOrdine(event, form) {
    event.preventDefault();
    var ordineId = form.querySelector('input[name="ordineId"]').value;
    var stato = form.querySelector('select[name="stato"]').value;
    fetch('<%=request.getContextPath()%>/changeOrderState', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'ordineId=' + encodeURIComponent(ordineId) + '&stato=' + encodeURIComponent(stato)
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            location.reload();
        } else {
            alert('Errore: ' + (data.message || 'Impossibile aggiornare lo stato dell\'ordine.'));
        }
    })
    .catch(() => {
        alert('Errore di rete. Riprova.');
    });
    return false;
}
</script>
</html>
