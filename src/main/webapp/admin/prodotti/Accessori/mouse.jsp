<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Mouse - Admin</title>
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
    <div id="popup-nuovo-mouse" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuovo Mouse</h3>
        <form id="form-nuovo-mouse" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="accessorio" />
          <input type="hidden" name="type" value="mouse" />
          <input type="hidden" name="category" value="fotoAccessori" />
          <input type="hidden" name="name" value="Mouse" />
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
              <label for="connectionType-new" class="visually-hidden">Connessione</label>
              <input type="text" id="connectionType-new" name="connectionType" required aria-label="Connessione" placeholder="Es: Wireless, USB">
            </div>
            <div class="popup-field-wrapper">
              <label for="forma-new" class="visually-hidden">Forma</label>
              <input type="text" id="forma-new" name="forma" required aria-label="Forma" placeholder="Es: Ergonomica, Ambidestro">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="sensore-new" class="visually-hidden">Sensore</label>
              <input type="text" id="sensore-new" name="sensore" required aria-label="Sensore" placeholder="Es: Ottico, Laser">
            </div>
            <div class="popup-field-wrapper">
              <label for="dpi-new" class="visually-hidden">DPI</label>
              <input type="number" id="dpi-new" name="dpi" min="0" required aria-label="DPI" placeholder="DPI max">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="peso-new" class="visually-hidden">Peso (g)</label>
              <input type="number" id="peso-new" name="peso" min="0" required aria-label="Peso (g)" placeholder="Peso">
            </div>
            <div class="popup-field-wrapper">
              <label for="led-new" class="visually-hidden">LED</label>
              <select id="led-new" name="led" required aria-label="LED">
                <option value="true">Sì</option>
                <option value="false">No</option>
              </select>
            </div>
          </div>
          <div class="popup-fields-row">
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
    <h2 class="admin-title">Gestione Mouse</h2>
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
                    <th>Categoria</th>
                    <th>Connessione</th>
                    <th>Forma</th>
                    <th>Sensore</th>
                    <th>DPI</th>
                    <th>Peso (g)</th>
                    <th>LED</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="mouse" items="${mouses}">
                    <tr>
                        <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                            <td><input type="hidden" name="id" value="${mouse.ID}" />${mouse.ID}</td>
                            <td>
                              <label for="marca-${mouse.ID}" class="visually-hidden">Marca</label>
                              <input type="text" id="marca-${mouse.ID}" name="marca" value="${mouse.marca}" aria-label="Marca" />
                            </td>
                            <td>
                              <label for="modello-${mouse.ID}" class="visually-hidden">Modello</label>
                              <input type="text" id="modello-${mouse.ID}" name="modello" value="${mouse.modello}" aria-label="Modello" />
                            </td>
                            <td>
                              <label for="prezzo-${mouse.ID}" class="visually-hidden">Prezzo</label>
                              <input type="number" id="prezzo-${mouse.ID}" name="prezzo" value="${mouse.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                            </td>
                            <td>
                              <label for="disponibilita-${mouse.ID}" class="visually-hidden">Disponibilità</label>
                              <input type="number" id="disponibilita-${mouse.ID}" name="disponibilita" value="${mouse.disponibilita}" min="0" aria-label="Disponibilità" />
                            </td>
                            <td>
                              <label for="sconto-${mouse.ID}" class="visually-hidden">Sconto</label>
                              <input type="number" id="sconto-${mouse.ID}" name="sconto" value="${mouse.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                            </td>
                            <td>
                              <label for="categoria-${mouse.ID}" class="visually-hidden">Categoria</label>
                              <input type="text" id="categoria-${mouse.ID}" name="categoria" value="${mouse.categoria}" aria-label="Categoria" />
                            </td>
                            <td>
                              <label for="connectionType-${mouse.ID}" class="visually-hidden">Connessione</label>
                              <input type="text" id="connectionType-${mouse.ID}" name="connectionType" value="${mouse.connectionType}" aria-label="Connessione" />
                            </td>
                            <td>
                              <label for="forma-${mouse.ID}" class="visually-hidden">Forma</label>
                              <input type="text" id="forma-${mouse.ID}" name="forma" value="${mouse.forma}" aria-label="Forma" />
                            </td>
                            <td>
                              <label for="sensore-${mouse.ID}" class="visually-hidden">Sensore</label>
                              <input type="text" id="sensore-${mouse.ID}" name="sensore" value="${mouse.sensore}" aria-label="Sensore" />
                            </td>
                            <td>
                              <label for="dpi-${mouse.ID}" class="visually-hidden">DPI</label>
                              <input type="number" id="dpi-${mouse.ID}" name="dpi" value="${mouse.DPI}" min="0" aria-label="DPI" />
                            </td>
                            <td>
                              <label for="peso-${mouse.ID}" class="visually-hidden">Peso (g)</label>
                              <input type="number" id="peso-${mouse.ID}" name="peso" value="${mouse.peso}" min="0" aria-label="Peso (g)" />
                            </td>
                            <td>
                                <label for="led-${mouse.ID}" class="visually-hidden">LED</label>
                                <select id="led-${mouse.ID}" name="led" aria-label="LED">
                                    <option value="true" ${mouse.led ? 'selected' : ''}>Sì</option>
                                    <option value="false" ${!mouse.led ? 'selected' : ''}>No</option>
                                </select>
                            </td>
                            <td>
                                <c:set var="mouseId" value="${mouse.ID}" scope="request"/>
                                <%
                                    FotoDAO fotoDAO= new FotoDAO();
                                    Object mouseId = request.getAttribute("mouseId");
                                    String imagePath = fotoDAO.getFoto((Integer) mouseId, "fotoAccessori", "Mouse", (String) request.getAttribute("path"));
                                %>
                                <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${mouse.marca}_${mouse.modello}" width="80">
                            </td>
                            <td>
                                <input type="hidden" name="piece" value="accessorio" />
                                <input type="hidden" name="type" value="mouse" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                            </td>
                        </form>
                        <td colspan="15" style="padding:0; border:none;">
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${mouse.ID}" />
                                <input type="hidden" name="category" value="fotoAccessori" />
                                <input type="hidden" name="name" value="Mouse" />
                                <label for="foto-upload-${mouse.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${mouse.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
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
        type.value = 'mouse';
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
        document.getElementById("form-nuovo-mouse").addEventListener("submit", newProduct);
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
        document.getElementById('popup-nuovo-mouse').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-mouse').style.display = 'none';
    }
</script>
</html>
