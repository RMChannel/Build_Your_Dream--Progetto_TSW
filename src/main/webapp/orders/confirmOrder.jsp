<%@ page import="Model.Orders.Order" %>
<%@ page import="Model.Carrello.Item" %>
<%@ page import="Model.Pezzi.Pezzo" %>
<%@ page import="Model.Accessori.Accessorio" %>
<%@ page import="Model.PreBuilts.PreBuilt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Conferma Ordine <%=request.getAttribute("id")%></title>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/headerStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/footerStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/orders/order.css">
</head>
<body>
<%@ include file="/components/header.jsp"%>
<div class="order-container">
<div class="order-title"><i class="fa fa-check-circle"></i>Ordine Confermato</div>
    <div class="order-section confirm-box">
        <h3 class="order-products-title">Prodotti ordinati</h3>
        <% Order order = null; %><c:choose>
        <c:when test="${empty ordine.carrello}">
                <div class="empty-cart">Nessun prodotto nell'ordine.</div>
            </c:when>
        <c:otherwise>
            <div class="order-table-responsive">
                <table class="order-table cart-list data-table">
                    <thead>
                    <tr>
                        <th>Tipo Prodotto</th>
                        <th>Marca</th>
                        <th>Modello</th>
                        <th>Prezzo</th>
                        <th>Quantità</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        order = (Order) request.getAttribute("ordine");
                        Carrello carrello2 = order.getCarrello();
                        for (Item item : carrello2.getObjects()) {
                            if (item.getObject() instanceof Pezzo) {
                                Pezzo pezzo = (Pezzo) item.getObject();
                                float prezzo = (float) Math.round(pezzo.getPrezzoScontato() * 100) / 100;
                    %>
                    <tr>
                        <td><%=pezzo.getTYPE()%></td>
                        <td><%=pezzo.getMarca()%></td>
                        <td><%=pezzo.getModello()%></td>
                        <td class="prezzo-cell"><%=prezzo%>€</td>
                        <td><%=item.getQuantity()%></td>
                    </tr>
                    <%
                    } else if (item.getObject() instanceof Accessorio) {
                        Accessorio accessorio = (Accessorio) item.getObject();
                        float prezzo = (float) Math.round(accessorio.getPrezzoScontato() * 100) / 100;
                    %>
                    <tr>
                        <td><%=accessorio.getTYPE()%></td>
                        <td><%=accessorio.getMarca()%></td>
                        <td><%=accessorio.getModello()%></td>
                        <td class="prezzo-cell"><%=prezzo%>€</td>
                        <td><%=item.getQuantity()%></td>
                    </tr>
                    <%
                    } else if (item.getObject() instanceof PreBuilt) {
                        PreBuilt preBuilt = (PreBuilt) item.getObject();
                        float prezzo = (float) Math.round(preBuilt.getPrezzoScontato() * 100) / 100;
                    %>
                    <tr>
                        <td><%=preBuilt.getTYPE()%></td>
                        <td><%=preBuilt.getMarca()%></td>
                        <td><%=preBuilt.getModello()%></td>
                        <td class="prezzo-cell"><%=prezzo%>€</td>
                        <td><%=item.getQuantity()%></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <div class="cart-summary-section confirm-summary">
                <div class="cart-total confirm-total">
                    Totale ordine: <span class="cart-total-value confirm-value">${Math.round(ordine.totale*100)/100}€</span>
                </div>
            </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="order-section order-details-box">
        <h3 class="order-details-title">Dettagli ordine</h3>
        <div class="order-details-flex">
            <div class="order-details-col">
                <div class="order-details-row"><b>Codice ordine:</b> <%=order.getCodice()%></div>
                <div class="order-details-row"><b>Data:</b> <%=order.getData()%></div>
                <div class="order-details-row"><b>Stato:</b> <%=order.getStatus()%></div>
            </div>
            <div class="order-details-col">
                <div class="order-details-row"><b>Nome utente:</b> <%=order.getId_user()%></div>
                <div class="order-details-row"><b>Telefono:</b> <%=order.getnTel()%></div>
            </div>
            <div class="order-details-col address">
                <div class="order-details-row"><b>Indirizzo:</b> <%=order.getVia()%>, <%=order.getCivico()%>, <%=order.getCap()%>, <%=order.getCitta()%></div>
                <div class="order-details-row"><b>Carta:</b> **** **** **** <%=order.getnCarta() != null && order.getnCarta().length() >= 4 ? order.getnCarta().substring(order.getnCarta().length() - 4) : "----"%></div>
            </div>
        </div>
    </div>
    <div class="order-section confirm-actions">
        <form action="<%=request.getContextPath()%>/" method="get" style="display:inline;">
            <button type="submit" class="order-form button confirm-home">🏠 Torna alla home</button>
        </form>
        <form action="<%=request.getContextPath()%>/userPage" method="post" style="display:inline;">
            <input type="hidden" name="option" value="yourorders">
            <button type="submit" class="order-form button confirm-orders">📦 Vai alla gestione ordini</button>
        </form>
    </div>
</div>
<%@ include file="/components/footer.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* Responsive table container */
.order-table-responsive {
    width: 100%;
    overflow-x: auto;
}
.order-table {
    width: 100%;
    min-width: 400px;
    box-sizing: border-box;
}
</style>
<script>
window.addEventListener('DOMContentLoaded', function() {
    var table = document.querySelector('.order-table');
    if (table && table.offsetWidth > 400) {
        table.style.fontSize = '0.85em';
    }
    // Se vuoi ridurre ancora di più, puoi aggiungere altre soglie
    if (table && table.offsetWidth > 500) {
        table.style.fontSize = '0.75em';
    }
});
</script>
</body>
</html>
