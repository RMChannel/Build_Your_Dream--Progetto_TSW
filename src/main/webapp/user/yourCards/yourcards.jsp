<%@ page import="Model.Users.Carte.Carta" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/user/yourCards/yourcards.css">
<%
    List<Carta> carte=(List<Carta>) request.getAttribute("carte");
%>

<div class="your-cards-container">
    <h2 class="section-title">Le Tue Carte</h2>
    
    <% if(carte == null || carte.isEmpty()) { %>
        <div class="no-cards-message">
            <p>Non hai ancora aggiunto nessuna carta di pagamento</p>
            <button class="add-card-button" onclick="changePage('addcard')">
                Aggiungi la tua prima carta
            </button>
        </div>
    <% } else { %>
        <div class="cards-list">
            <% for(Carta carta : carte) { %>
                <div class="card-item">
                    <div class="card-details">
                        <div class="card-number">
                            <span class="detail-label">Numero Carta:</span>
                            <span class="detail-value">**** **** **** <%= carta.getNumeroCarta().substring(carta.getNumeroCarta().length() - 4) %></span>
                        </div>
                        <div class="card-holder">
                            <span class="detail-label">Titolare:</span>
                            <span class="detail-value"><%= carta.getNome() %> <%= carta.getCognome() %></span>
                        </div>
                        <div class="card-expiry">
                            <span class="detail-label">Data di Scadenza:</span>
                            <span class="detail-value"><%= carta.getDataDiScadenza().toLocalDate().getMonthValue() %>/<%= carta.getDataDiScadenza().toLocalDate().getYear() %></span>
                        </div>
                    </div>
                    <div class="card-actions">
                        <form action="userPage/removeCarta" method="post">
                            <input type="hidden" name="numeroDiCarta" value="<%= carta.getNumeroCarta() %>">
                            <input type="hidden" name="dataDiScadenza" value="<%= carta.getDataDiScadenza() %>">
                            <input type="hidden" name="cvv" value="<%= carta.getCVV() %>">
                            <button type="submit" class="delete-card-button">
                                <i class="fas fa-trash"></i> Elimina
                            </button>
                        </form>
                    </div>
                </div>
            <% } %>
            
            <div class="add-new-card">
                <button class="add-card-button" onclick="changePage('addcard')">
                    Aggiungi nuova carta
                </button>
            </div>
        </div>
    <% } %>
</div>