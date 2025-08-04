
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Orders.Order" %>
<%@ page import="Model.Carrello.Item" %>
<%@ page import="Model.Carrello.Carrello" %>
<%@ page import="Foto.FotoDAO" %>
<%@ page import="Model.Accessori.Accessorio" %>
<%@ page import="Model.Pezzi.Pezzo" %>
<%@ page import="Model.PreBuilts.PreBuilt" %>

<%@ page import="java.util.HashMap" %>
<%@ page import="Model.Orders.Stato" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/user/yourOrders/yourorders.css"/>

<div class="your-orders-container">
    <h2 class="your-orders-title">I tuoi ordini</h2>
    <div class="your-orders-list">
        <% 
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        FotoDAO fotoDAO = new FotoDAO();
        String realPath = application.getRealPath("");
        if (orders != null && !orders.isEmpty()) {
            for (Order order : orders) {
        %>
        <section class="order-section">
            <div class="order-header">
                <span class="order-code">Ordine #<%= order.getCodice() %></span>
                <span class="order-date">Data: <%= order.getData() %></span>
                <span class="order-status">Stato: <%= Stato.getStato(order.getStatus()) %></span>
                <span class="order-total">Totale: <%= String.format("%.2f", order.getTotale()) %> €</span>
                <% boolean isRimborsato = (order.getStatus() == -1 || order.getStatus() == -2 || order.getStatus()==2); %>
                <button class="refund-btn" <%= isRimborsato ? "disabled style='opacity:0.5;cursor:not-allowed;'" : "onclick='rimborsaOrdine(" + order.getCodice() + ")'" %>>Effettua rimborso</button>
            </div>
            <div class="order-products">
                <% 
                Carrello carrello2 = order.getCarrello();
                HashMap<String,String> classes=carrello2.getClasses();
                for (Item item : carrello2.getObjects()) {
                    Object obj = item.getObject();
                    String nome = "";
                    String categoria = "";
                    int id = -1;
                    String foto = "media/notFound.jpg";
                    double prezzo = 0;
                    String tipo = "";
                    String prodotto="";
                    if (obj instanceof Accessorio) {
                        Accessorio a = (Accessorio) obj;
                        nome = a.getMarca()+" "+a.getModello();
                        id = a.getID();
                        if(classes.get((id+a.getTYPE()))!=null) prodotto=classes.get(id+a.getTYPE());
                        if(prodotto.equals("Tappetino")) prodotto="Tappetini";
                        else if(prodotto.equals("Tastiera")) prodotto="Tastiere";
                        foto = fotoDAO.getFoto(id, "fotoAccessori",prodotto, realPath);
                        prezzo = a.getPrezzoScontato();
                        tipo = "Accessorio";
                    } else if (obj instanceof Pezzo) {
                        Pezzo p = (Pezzo) obj;
                        nome = p.getMarca()+" "+p.getModello();
                        id = p.getID();
                        if(classes.get((id+p.getTYPE()))!=null) prodotto=classes.get(id+p.getTYPE());
                        foto = fotoDAO.getFoto(id, "fotoPezzi", prodotto, realPath);
                        prezzo = p.getPrezzoScontato();
                        tipo = "Pezzo";
                    } else if (obj instanceof PreBuilt) {
                        PreBuilt pb = (PreBuilt) obj;
                        nome = pb.getMarca()+" "+pb.getModello();
                        id = pb.getID();
                        foto = fotoDAO.getFirstFotoOfPrebuilt(id, realPath);
                        tipo = "PreBuilt";
                        prezzo= pb.getPrezzoScontato();
                    }
                %>
                <div class="order-product">
                    <img class="product-photo" src="<%=request.getContextPath()%>/<%=foto%>" alt="foto prodotto"/>
                    <div class="product-details">
                        <span class="product-name"><%= nome %></span>
                        <span class="product-type">Tipo: <%= tipo %></span>
                        <span class="product-qty">Quantità: <%= item.getQuantity() %></span>
                        <span class="product-price">Prezzo: <%= String.format("%.2f", prezzo) %> €</span>
                    </div>
                </div>
                <% } %>
            </div>
            <div class="order-info">
                <h4>Dettagli ordine</h4>
                <div class="order-address">
                    <span>Indirizzo: <%= order.getVia() %>, <%= order.getCivico() %>, <%= order.getCap() %>, <%= order.getCitta() %></span>
                </div>
                <div class="order-card">
                    <span>Carta utilizzata: **** **** **** <%= order.getnCarta().substring(order.getnCarta().length()-4) %></span>
                </div>
            </div>
        </section>
        <%   }
        } else { %>
            <div class="no-orders">
                <p>Non hai ancora effettuato ordini.</p>
            </div>
        <% } %>
    </div>
<script>
function rimborsaOrdine(idOrdine) {
    if(!confirm('Sei sicuro di voler rimborsare questo ordine?')) return;
    fetch('<%=request.getContextPath()%>/rimborsaOrdine', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'id=' + encodeURIComponent(idOrdine)
    })
    .then(response => response.json())
    .then(data => {
        console.log(data.status);
        if(data.status==='success') {
            location.reload();
        } else {
            alert('Errore Server, contatta l\'amministratore');
        }
    })
    .catch(() => {
        alert('Errore Server, contatta l\'amministratore');
    });
}
</script>
</div>
