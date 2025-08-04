<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.eclipse.tags.shaded.org.apache.regexp.RE" %>
<% SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/user/yourData/yourdata.css">

<div class="personal-data-container">
    <h2 class="form-title">I Tuoi Dati Personali</h2>
    <div id="updateMessage" class="update-message">
        <% if (request.getAttribute("updateMessage") != null) { %>
        <p><%= request.getAttribute("updateMessage") %></p>
        <% } %>
    </div>
    <form class="personal-data-form" action="<%=request.getContextPath()%>/UpdateUserData" method="post">
        <div class="form-group">
            <input type="text" class="form-input" id="nome" name="nome" value="<%= user.getNome() %>" placeholder=" " required pattern="[A-Za-zÀ-ÿ'\s]{2,}" minlength="2" maxlength="30" title="Inserisci solo lettere. Minimo 2 caratteri.">
            <label for="nome" class="form-label">Nome</label>
        </div>
        
        <div class="form-group">
            <input type="text" class="form-input" id="cognome" name="cognome" value="<%= user.getCognome() %>" placeholder=" " required pattern="[A-Za-zÀ-ÿ'\s]{2,}" minlength="2" maxlength="30" title="Inserisci solo lettere. Minimo 2 caratteri.">
            <label for="cognome" class="form-label">Cognome</label>
        </div>
        
        <div class="form-group">
            <input type="email" class="form-input" id="email" name="email" value="<%= user.getEmail() %>" placeholder=" " required pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" maxlength="50" title="Inserisci una email valida.">
            <label for="email" class="form-label">Email</label>
        </div>
        
        <div class="form-group">
            <input type="tel" class="form-input" id="nTelefono" name="nTelefono" value="<%= user.getnTelefono() %>" placeholder=" " required pattern="[0-9]{8,15}" minlength="8" maxlength="15" title="Inserisci solo numeri. Minimo 8, massimo 15 cifre.">
            <label for="nTelefono" class="form-label">Numero di Telefono</label>
        </div>
        
        <div class="form-group">
            <input type="date" class="form-input date-input" id="dataDiNascita" name="dataDiNascita" 
                   value="<%= user.getDataDiNascita() != null ? dateFormat.format(user.getDataDiNascita()) : "" %>" 
                   placeholder=" " required max="2025-07-23" title="Inserisci una data valida.">
            <label for="dataDiNascita" class="form-label">Data di Nascita</label>
        </div>

        <div class="form-group username-group">
            <input type="text" class="form-input" id="username" name="username" value="<%= user.getUsername() %>" readonly>
            <label for="username" class="form-label">Username (non modificabile)</label>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="form-submit">Salva Modifiche</button>
        </div>
    </form>
</div>