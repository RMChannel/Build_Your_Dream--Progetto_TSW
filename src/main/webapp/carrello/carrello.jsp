<%@ page import="java.util.HashMap" %>
<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/headerStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/footerStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/carrello/carrello.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/tableStyle.css">
    <%FotoDAO fotoDAO=new FotoDAO();%>
    <title>Build Your Dream - Carrello</title>
</head>
<body>
<%@ include file="/components/header.jsp"%>
<div class="cart-container">
    <div class="cart-title">Il tuo carrello</div>
    <c:choose>
        <c:when test="${carrello.isEmpty()}">
            <br><div class="empty-cart">Il carrello è vuoto.</div>
        </c:when>
        <c:otherwise>
            <!-- Wrapper per scroll orizzontale -->
            <div id="cart-table-wrapper" style="overflow-x:auto;">
                <table class="cart-list data-table" id="cart-table">
                    <thead>
                    <tr>
                        <th>Foto</th>
                        <th>Tipo Prodotto</th>
                        <th>Marca</th>
                        <th>Modello</th>
                        <th>Prezzo</th>
                        <th>Quantità</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%HashMap<String,String> classes=carrello.getClasses();%>
                    <c:forEach var="item" items="${carrello.objects}">
                        <tr>
                            <c:set var="prodotto" value="${item.object}"/>
                            <c:set var="key" value="${prodotto.ID}${prodotto.TYPE}" scope="request"/>
                            <c:set var="pID" value="${prodotto.ID}" scope="request"/>
                            <c:set var="pType" value="${prodotto.TYPE}" scope="request"/>
                            <%
                                Object pID= request.getAttribute("pID");
                                String categoria="";
                                String imagePath="";
                                if(request.getAttribute("pType").equals("Prebuilt")) {
                                    imagePath=fotoDAO.getFirstFotoOfPrebuilt((int) request.getAttribute("pID"),(String) request.getAttribute("path"));
                                }
                                else {
                                    if(request.getAttribute("pType").equals("Pezzo")) categoria="fotoPezzi";
                                    else categoria="fotoAccessori";
                                    String prodotto="";
                                    if(classes.get(request.getAttribute("key"))!=null) prodotto=classes.get(request.getAttribute("key"));
                                    if(prodotto.equals("Tappetino")) prodotto="Tappetini";
                                    else if(prodotto.equals("Tastiera")) prodotto="Tastiere";
                                    imagePath=fotoDAO.getFoto((Integer) pID, categoria,prodotto,(String) request.getAttribute("path"));
                                }
                            %>
                            <td class="cpu-image"><img class="cart-img" src='<%=request.getContextPath()%>/<%=imagePath%>' alt="Foto prodotto"/></td>
                            <td><%=classes.get(request.getAttribute("key"))%></td>
                            <td>${prodotto.marca}</td>
                            <td>${prodotto.modello}</td>
                            <td class="prezzo-cell ${prodotto.sconto > 0 ? 'prezzo-scontato' : ''}">
                                <c:if test="${prodotto.sconto > 0}">
                                    <span class="prezzo-originale">${Math.round(prodotto.prezzo * 100) / 100}€</span>
                                    <span class="sconto-badge">-${prodotto.sconto}%</span>
                                </c:if>
                                <span class="prezzo-finale">${Math.round((prodotto.prezzo * (1 - prodotto.sconto / 100)) * 100) / 100}€</span>
                            </td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 5px; margin:0;">
                                    <button type="button" class="quantity-btn" onclick="updateQuantity('${prodotto.ID}', '${prodotto.TYPE}', 'decrementa', this)">-</button>
                                    <span class="quantity-value">${item.quantity}</span>
                                    <button type="button" class="quantity-btn" onclick="updateQuantity('${prodotto.ID}', '${prodotto.TYPE}', 'incrementa', this)">+</button>
                                </div>
                                <c:if test="${item.quantity > prodotto.disponibilita}">
                                        <span class="cart-warning">
                                            <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='#FFD600' viewBox='0 0 16 16' style='vertical-align: middle;'><path d='M7.938 2.016a.13.13 0 0 1 .125 0l6.857 11.856c.03.052.03.117 0 .17a.13.13 0 0 1-.125.063H1.205a.13.13 0 0 1-.125-.063.145.145 0 0 1 0-.17L7.938 2.016zm.823-1.447a1.13 1.13 0 0 0-1.624 0L.28 12.425C-.37 13.54.457 15 1.705 15h12.59c1.248 0 2.075-1.46 1.425-2.575L8.76.569zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1-2.002 0 1 1 0 0 1 2.002 0z'/></svg>
                                            <span>Attenzione: quantità richiesta superiore alla disponibilità (<b>${prodotto.disponibilita}</b>)</span>
                                        </span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="cart-summary-section">
                <div class="cart-total">Totale carrello: <span class="cart-total-value" id="cart-total">${Math.round(carrello.getTotale()*100)/100}€</span></div>
                <button type="submit" class="proceed-order-btn" onclick="chartToOrder()">Procedi con l'ordine</button>
                <button id="remove-all-btn" type="button" class="remove-all-btn">Rimuovi tutto</button>
                <div id="error-div" class="error-div" style="color: #d32f2f; margin-top: 10px;"></div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("cart-icon").src="<%=request.getContextPath()%>/media/cartSelected.png";
        const removeAllBtn = document.getElementById("remove-all-btn");
        if(removeAllBtn) {
            removeAllBtn.addEventListener("click", function() {
                fetch("<%=request.getContextPath()%>/removeAllFromChart", {
                    method: "POST",
                    headers: { 'X-Requested-With': 'XMLHttpRequest' }
                })
                .then(response => response.json())
                .then(data => {
                    if(data.status === "success") {
                        location.reload();
                    }
                });
            });
        }
    });

    function chartToOrder() {
        const form = document.createElement('form');
        const formData = new FormData(form);
        const errorDiv = document.getElementById('error-div');
        if (errorDiv) errorDiv.textContent = '';
        fetch('<%=request.getContextPath()%>/chartToOrder', {
            method: 'POST',
            body: formData,
        }).then(response => response.json()).then(data => {
            if (data.status === "success") {
                location.replace('<%=request.getContextPath()%>/orderPage');
            } else {
                if (errorDiv) errorDiv.textContent = data.message || 'Errore durante l\'operazione';
            }
        });
    }

    function updateQuantity(idProdotto, typeProdotto, action, btn) {
        const errorDiv = document.getElementById('error-div');
        if (errorDiv) errorDiv.textContent = '';
        fetch('<%=request.getContextPath()%>/UpdateQuantitaCarrello', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({
                idProdotto: idProdotto,
                typeProdotto: typeProdotto,
                action: action
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                if (data.reload) {
                    location.reload();
                } else if (data.newQuantity !== undefined) {
                    // Aggiorna la quantità visualizzata
                    const quantitySpan = btn.parentElement.querySelector('.quantity-value');
                    if (quantitySpan) quantitySpan.textContent = data.newQuantity;
                    document.getElementById('cartCount').innerHTML = data.cartCount;
                    document.getElementById('cartCountMobile').innerHTML = data.cartCount;
                    document.getElementById('cart-total').innerHTML = data.totale;
                }
            } else {
                if (errorDiv) errorDiv.textContent = data.message || 'Errore durante l\'operazione';
            }
        })
        .catch(() => {
            if (errorDiv) errorDiv.textContent = 'Errore di comunicazione con il server';
        });
    }

    // Funzione per ridurre la dimensione del testo se la tabella supera 470px
    function adjustCartTableFontSize() {
        const table = document.getElementById('cart-table');
        if (!table) return;
        if (table.offsetWidth < 470) {
            table.style.fontSize = '0.85em';
        } else {
            table.style.fontSize = '';
        }
    }
    window.addEventListener('resize', adjustCartTableFontSize);
    document.addEventListener('DOMContentLoaded', adjustCartTableFontSize);
</script>
<%@ include file="/components/footer.jsp"%>
</body>
</html>