<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione StreamDeck - Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/productStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/accessibilityStyles.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
    <div class="admin-back-btns" style="display: flex; gap: 24px; margin: 18px 0 0 18px; position: static;">
        <a href="<%=request.getContextPath()%>/adminPage" class="admin-back-btn btn-admin-area">&larr; Torna all'area admin</a>
        <a href="<%=request.getContextPath()%>/adminPage/gestioneProdotti?piece=accessori" class="admin-back-btn btn-accessori">&larr; Torna indietro</a>
        <button type="button" class="admin-btn add-product-btn" style="margin-left:auto;" onclick="openPopup()">Nuovo Prodotto</button>
    </div>
    <div id="popup-nuovo-streamdeck" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuovo StreamDeck</h3>
        <form id="form-nuovo-streamdeck" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="accessorio" />
          <input type="hidden" name="type" value="streamdeck" />
          <input type="hidden" name="category" value="fotoAccessori" />
          <input type="hidden" name="name" value="StreamDeck" />
          <div class="id-field-wrapper">
            <div class="popup-field-wrapper">
              <label for="random-id-input" class="visually-hidden">ID</label>
              <input type="text" id="random-id-input" name="id" required placeholder="ID univoco" aria-label="ID">
            </div>
            <button type="button" id="random-id-btn">RandomID</button>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="marca-new" class="visually-hidden">Marca</label>
              <input type="text" id="marca-new" name="marca" required aria-label="Marca" placeholder="Marca">
            </div>
            <div class="popup-field-wrapper">
              <label for="modello-new" class="visually-hidden">Modello</label>
              <input type="text" id="modello-new" name="modello" required aria-label="Modello" placeholder="Modello">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="prezzo-new" class="visually-hidden">Prezzo (€)</label>
              <input type="number" id="prezzo-new" name="prezzo" step="0.01" min="0" required aria-label="Prezzo" placeholder="Prezzo">
            </div>
            <div class="popup-field-wrapper">
              <label for="disponibilita-new" class="visually-hidden">Disponibilità</label>
              <input type="number" id="disponibilita-new" name="disponibilita" min="0" required aria-label="Disponibilità" placeholder="Quantità">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="sconto-new" class="visually-hidden">Sconto (%)</label>
              <input type="number" id="sconto-new" name="sconto" min="0" max="100" value="0" required aria-label="Sconto percentuale" placeholder="0">
            </div>
            <div class="popup-field-wrapper">
              <label for="categoria-new" class="visually-hidden">Categoria</label>
              <input type="text" id="categoria-new" name="categoria" required aria-label="Categoria" placeholder="Categoria">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="nTasti-new" class="visually-hidden">Numero Tasti</label>
              <input type="number" id="nTasti-new" name="nTasti" min="1" required aria-label="Numero Tasti" placeholder="N° tasti">
            </div>
            <div class="popup-field-wrapper">
              <label for="tipoTasti-new" class="visually-hidden">Tipo Tasti</label>
              <input type="text" id="tipoTasti-new" name="tipoTasti" required placeholder="Es: LCD, Meccanico..." aria-label="Tipo Tasti">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="connectionType-new" class="visually-hidden">Tipo Connessione</label>
              <input type="text" id="connectionType-new" name="connectionType" required aria-label="Tipo Connessione" placeholder="Es: USB-C">
            </div>
            <div class="popup-field-wrapper">
              <label for="lunghezza-new" class="visually-hidden">Lunghezza (cm)</label>
              <input type="number" id="lunghezza-new" name="lunghezza" step="0.1" min="0" required aria-label="Lunghezza (cm)" placeholder="cm">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="larghezza-new" class="visually-hidden">Larghezza (cm)</label>
              <input type="number" id="larghezza-new" name="larghezza" step="0.1" min="0" required aria-label="Larghezza (cm)" placeholder="cm">
            </div>
            <div class="popup-field-wrapper">
              <label for="foto-new" class="visually-hidden">Foto</label>
              <input type="file" id="foto-new" name="foto" accept="image/*" aria-label="Seleziona foto">
            </div>
          </div>
          <button type="submit" class="admin-btn enhanced-btn">Salva</button>
          <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
        </form>
      </div>
    </div>
    <h2 class="admin-title">Gestione StreamDeck</h2>
    <div class="admin-table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Marca</th>
                    <th>Modello</th>
                    <th>Prezzo</th>
                    <th>Disponibilità</th>
                    <th>Sconto (%)</th>
                    <th>Numero Tasti</th>
                    <th>Tipo Tasti</th>
                    <th>Tipo Connessione</th>
                    <th>Lunghezza (cm)</th>
                    <th>Larghezza (cm)</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="streamdeck" items="${streamDecks}">
                    <tr>
                        <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                            <td><input type="hidden" name="id" value="${streamdeck.ID}" />${streamdeck.ID}</td>
                            <td>
                              <label for="marca-${streamdeck.ID}" class="visually-hidden">Marca</label>
                              <input type="text" id="marca-${streamdeck.ID}" name="marca" value="${streamdeck.marca}" aria-label="Marca" />
                            </td>
                            <td>
                              <label for="modello-${streamdeck.ID}" class="visually-hidden">Modello</label>
                              <input type="text" id="modello-${streamdeck.ID}" name="modello" value="${streamdeck.modello}" aria-label="Modello" />
                            </td>
                            <td>
                              <label for="prezzo-${streamdeck.ID}" class="visually-hidden">Prezzo</label>
                              <input type="number" id="prezzo-${streamdeck.ID}" name="prezzo" value="${streamdeck.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                            </td>
                            <td>
                              <label for="disponibilita-${streamdeck.ID}" class="visually-hidden">Disponibilità</label>
                              <input type="number" id="disponibilita-${streamdeck.ID}" name="disponibilita" value="${streamdeck.disponibilita}" min="0" aria-label="Disponibilità" />
                            </td>
                            <td>
                              <label for="sconto-${streamdeck.ID}" class="visually-hidden">Sconto</label>
                              <input type="number" id="sconto-${streamdeck.ID}" name="sconto" value="${streamdeck.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                            </td>
                            <td>
                              <label for="nTasti-${streamdeck.ID}" class="visually-hidden">Numero Tasti</label>
                              <input type="number" id="nTasti-${streamdeck.ID}" name="nTasti" value="${streamdeck.nTasti}" min="1" aria-label="Numero Tasti" />
                            </td>
                            <td>
                              <label for="tipoTasti-${streamdeck.ID}" class="visually-hidden">Tipo Tasti</label>
                              <input type="text" id="tipoTasti-${streamdeck.ID}" name="tipoTasti" value="<c:forEach var="tipotasto" items="${streamdeck.tipoTasti}">${tipotasto}, </c:forEach>" aria-label="Tipo Tasti" />
                            </td>
                            <td>
                              <label for="connectionType-${streamdeck.ID}" class="visually-hidden">Tipo Connessione</label>
                              <input type="text" id="connectionType-${streamdeck.ID}" name="connectionType" value="${streamdeck.connectionType}" aria-label="Tipo Connessione" />
                            </td>
                            <td>
                              <label for="lunghezza-${streamdeck.ID}" class="visually-hidden">Lunghezza (cm)</label>
                              <input type="number" id="lunghezza-${streamdeck.ID}" name="lunghezza" value="${streamdeck.lunghezza}" step="0.1" min="0" aria-label="Lunghezza (cm)" />
                            </td>
                            <td>
                              <label for="larghezza-${streamdeck.ID}" class="visually-hidden">Larghezza (cm)</label>
                              <input type="number" id="larghezza-${streamdeck.ID}" name="larghezza" value="${streamdeck.larghezza}" step="0.1" min="0" aria-label="Larghezza (cm)" />
                            </td>
                            <td>
                                <c:set var="streamdeckId" value="${streamdeck.ID}" scope="request"/>
                                <%
                                    FotoDAO fotoDAO= new FotoDAO();
                                    Object streamdeckId = request.getAttribute("streamdeckId");
                                    String imagePath = fotoDAO.getFoto((Integer) streamdeckId, "fotoAccessori", "StreamDeck", (String) request.getAttribute("path"));
                                %>
                                <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${streamdeck.marca}_${streamdeck.modello}" width="80">
                            </td>
                            <td>
                                <input type="hidden" name="piece" value="accessorio" />
                                <input type="hidden" name="type" value="streamdeck" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                            </td>
                        </form>
                        <td colspan="14" style="padding:0; border:none;">
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${streamdeck.ID}" />
                                <input type="hidden" name="category" value="fotoAccessori" />
                                <input type="hidden" name="name" value="StreamDeck" />
                                <label for="foto-upload-${streamdeck.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${streamdeck.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
                                <button type="submit" class="admin-btn" style="margin-top:2px;">Aggiungi Foto</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
<script>
    function updateProduct(event) {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form);
        const errorDiv = form.closest('tr').querySelector('.error-message');
        if (errorDiv) errorDiv.textContent = '';
        fetch('<%=request.getContextPath()%>/updateProduct', {
            method: 'POST',
            body: formData,
        }).then(response => response.json()).then(data => {
            if (data.status === "success") {
                location.reload();
            } else {
                if (errorDiv) errorDiv.textContent = data.message || 'Errore durante l\'aggiornamento.';
            }
        });
    }

    function newProduct(event) {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form);
        fetch('<%=request.getContextPath()%>/newProduct', {
            method: 'POST',
            body: formData,
        }).then(response => response.json()).then(data => {
            if (data.status === "success") {
                location.reload();
            } else {
                alert(data.message || 'Errore durante l\'inserimento.');
            }
        });
    }

    function removeProduct(event, id) {
        event.preventDefault();
        const tempForm = document.createElement('form');
        const idInput = document.createElement('input');
        const type = document.createElement('input');
        const piece = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = id;
        type.type = 'hidden';
        type.name = 'type';
        type.value = 'streamdeck';
        piece.type = 'hidden';
        piece.name = 'piece';
        piece.value = 'accessorio';
        tempForm.appendChild(idInput);
        tempForm.appendChild(type);
        tempForm.appendChild(piece);
        const formData = new FormData(tempForm);
        const button = event.target;
        const errorDiv = button.closest('tr').querySelector('.error-message');
        if (errorDiv) errorDiv.textContent = '';
        fetch('<%=request.getContextPath()%>/removeProduct', {
            method: 'POST',
            body: formData,
        }).then(response => response.json()).then(data => {
            if (data.status === "success") {
                location.reload();
            } else {
                if (errorDiv) errorDiv.textContent = data.message || 'Errore durante la cancellazione.';
            }
        });
    }

    function updateFoto(event) {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form);
        const errorDiv = form.closest('tr').querySelector('.error-message');
        if (errorDiv) errorDiv.textContent = '';
        fetch('<%=request.getContextPath()%>/updateFotoProduct', {
            method: 'POST',
            body: formData,
        }).then(response => response.json()).then(data => {
            if (data.status === "success") {
                location.reload();
            } else {
                if (errorDiv) errorDiv.textContent ='Errore durante l\'aggiornamento.';
            }
        });
    }

    window.addEventListener('DOMContentLoaded', function() {
        Array.from(document.querySelectorAll('.update-form')).forEach(form => {
            form.addEventListener('submit', updateProduct);
        });
        Array.from(document.querySelectorAll('.delete')).forEach(deleteBtn => {
            deleteBtn.addEventListener('click', function(e) {
                const row = deleteBtn.closest('tr');
                const idInput = row.querySelector('input[name="id"]');
                const id = idInput ? idInput.value : null;
                removeProduct(e, id);
            });
        });
        // Aggiunta: listener per i form di cambio foto
        Array.from(document.querySelectorAll('form[action$="/updateFotoProduct"]')).forEach(form => {
            form.addEventListener('submit', updateFoto);
        });
        document.getElementById("form-nuovo-streamdeck").addEventListener("submit", newProduct);
        document.getElementById("random-id-btn").addEventListener("click", function() {
            const tempForm = document.createElement('form');
            const type = document.createElement('input');
            type.type = 'hidden';
            type.name = 'type';
            type.value = 'accessorio';
            tempForm.appendChild(type);
            const formData = new FormData(tempForm);
            fetch('<%=request.getContextPath()%>/getRandomID', {
                method: 'POST',
                body: formData,
            }).then(response => response.json()).then(data => {
                document.getElementById("random-id-input").value = data.id;
            });
        });
    });

    function openPopup() {
        document.getElementById('popup-nuovo-streamdeck').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-streamdeck').style.display = 'none';
    }
</script>
</html>
