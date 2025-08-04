<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Prebuilt - Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/productStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/PreBuilt/prebuilt.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/accessibilityStyles.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
    <div class="admin-back-btns" style="display: flex; gap: 24px; margin: 18px 0 0 18px; position: static;">
        <a href="<%=request.getContextPath()%>/adminPage" class="admin-back-btn btn-admin-area">&larr; Torna all'area admin</a>
        <a href="<%=request.getContextPath()%>/adminPage/gestioneProdotti?" class="admin-back-btn btn-accessori">&larr; Torna indietro</a>
        <button type="button" class="admin-btn add-product-btn" style="margin-left:auto;" onclick="openPopup()">Nuovo Prebuilt</button>
    </div>
    <div id="popup-nuovo-prebuilt" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuovo Prebuilt</h3>
        <form id="form-nuovo-prebuilt" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="prebuilt" />
          <input type="hidden" name="type" value="prebuilt" />
          <input type="hidden" name="category" value="PreBuilt" />
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
              <label for="RAM-new" class="visually-hidden">RAM (GB)</label>
              <input type="number" id="RAM-new" name="RAM" min="1" required aria-label="RAM (GB)" placeholder="RAM in GB">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="memory-new" class="visually-hidden">Storage (GB)</label>
              <input type="number" id="memory-new" name="memory" min="1" required aria-label="Storage (GB)" placeholder="Storage in GB">
            </div>
            <div class="popup-field-wrapper">
              <label for="CPU-new" class="visually-hidden">CPU</label>
              <input type="text" id="CPU-new" name="CPU" required aria-label="CPU" placeholder="Modello CPU">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="GPU-new" class="visually-hidden">GPU</label>
              <input type="text" id="GPU-new" name="GPU" required aria-label="GPU" placeholder="Modello GPU">
            </div>
            <div class="popup-field-wrapper">
              <label for="descrizione-new" class="visually-hidden">Descrizione</label>
              <input type="text" id="descrizione-new" name="descrizione" required aria-label="Descrizione" placeholder="Descrizione">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="foto-new" class="visually-hidden">Foto</label>
              <input type="file" id="foto-new" name="foto" accept="image/*" multiple aria-label="Seleziona foto">
            </div>
          </div>
          <button type="submit" class="admin-btn enhanced-btn">Salva</button>
          <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
        </form>
      </div>
    </div>
    <h2 class="admin-title">Gestione Prebuilt</h2>
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
                    <th>RAM (GB)</th>
                    <th>Storage (GB)</th>
                    <th>CPU</th>
                    <th>GPU</th>
                    <th>Descrizione</th>
                    <th>Foto</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="prebuilt" items="${prebuilts}">
                    <tr>
                        <td>${prebuilt.ID}<input type="hidden" name="id" value="${prebuilt.ID}" /></td>
                        <td>
                          <label for="marca-${prebuilt.ID}" class="visually-hidden">Marca</label>
                          <input type="text" id="marca-${prebuilt.ID}" name="marca" value="${prebuilt.marca}" form="update-form-${prebuilt.ID}" aria-label="Marca" />
                        </td>
                        <td>
                          <label for="modello-${prebuilt.ID}" class="visually-hidden">Modello</label>
                          <input type="text" id="modello-${prebuilt.ID}" name="modello" value="${prebuilt.modello}" form="update-form-${prebuilt.ID}" aria-label="Modello" />
                        </td>
                        <td>
                          <label for="prezzo-${prebuilt.ID}" class="visually-hidden">Prezzo</label>
                          <input type="number" id="prezzo-${prebuilt.ID}" name="prezzo" value="${prebuilt.prezzo}" step="0.01" min="0" form="update-form-${prebuilt.ID}" aria-label="Prezzo" />
                        </td>
                        <td>
                          <label for="disponibilita-${prebuilt.ID}" class="visually-hidden">Disponibilità</label>
                          <input type="number" id="disponibilita-${prebuilt.ID}" name="disponibilita" value="${prebuilt.disponibilita}" min="0" form="update-form-${prebuilt.ID}" aria-label="Disponibilità" />
                        </td>
                        <td>
                          <label for="sconto-${prebuilt.ID}" class="visually-hidden">Sconto</label>
                          <input type="number" id="sconto-${prebuilt.ID}" name="sconto" value="${prebuilt.sconto}" min="0" max="100" form="update-form-${prebuilt.ID}" aria-label="Sconto percentuale" />
                        </td>
                        <td>
                          <label for="RAM-${prebuilt.ID}" class="visually-hidden">RAM (GB)</label>
                          <input type="number" id="RAM-${prebuilt.ID}" name="RAM" value="${prebuilt.RAM}" min="1" form="update-form-${prebuilt.ID}" aria-label="RAM (GB)" />
                        </td>
                        <td>
                          <label for="memory-${prebuilt.ID}" class="visually-hidden">Storage (GB)</label>
                          <input type="number" id="memory-${prebuilt.ID}" name="memory" value="${prebuilt.memory}" min="1" form="update-form-${prebuilt.ID}" aria-label="Storage (GB)" />
                        </td>
                        <td>
                          <label for="CPU-${prebuilt.ID}" class="visually-hidden">CPU</label>
                          <input type="text" id="CPU-${prebuilt.ID}" name="CPU" value="${prebuilt.CPU}" form="update-form-${prebuilt.ID}" aria-label="CPU" />
                        </td>
                        <td>
                          <label for="GPU-${prebuilt.ID}" class="visually-hidden">GPU</label>
                          <input type="text" id="GPU-${prebuilt.ID}" name="GPU" value="${prebuilt.GPU}" form="update-form-${prebuilt.ID}" aria-label="GPU" />
                        </td>
                        <td>
                          <label for="descrizione-${prebuilt.ID}" class="visually-hidden">Descrizione</label>
                          <input type="text" id="descrizione-${prebuilt.ID}" name="descrizione" value="${prebuilt.descrizione}" form="update-form-${prebuilt.ID}" aria-label="Descrizione" />
                        </td>
                        <td>
                            <c:set var="prebuiltId" value="${prebuilt.ID}" scope="request"/>
                            <%
                                FotoDAO fotoDAO= new FotoDAO();
                                Object prebuiltId = request.getAttribute("prebuiltId");
                                java.util.List<String> images = fotoDAO.getFotoForPrebuilt((Integer) prebuiltId, (String) request.getAttribute("path"));
                            %>
                            <div class="prebuilt-foto-list">
                                <% if (images != null && !images.isEmpty()) { %>
                                    <% for (String img : images) { %>
                                        <div class="prebuilt-foto-item">
                                            <img src="<%=request.getContextPath()%>/<%=img%>" alt="foto" width="60">
                                            <form action="<%=request.getContextPath()%>/deleteFotoProduct" method="post" style="display:inline;" onsubmit="removeSingleFoto(event, '<%=img%>', '${prebuilt.ID}')">
                                                <input type="hidden" name="imgPath" value="<%=img%>" />
                                                <button type="submit" class="admin-btn delete-foto" title="Elimina foto">🗑️</button>
                                            </form>
                                        </div>
                                    <% } %>
                                <% } else { %>
                                    <span>Nessuna foto</span>
                                <% } %>
                            </div>
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${prebuilt.ID}" />
                                <input type="hidden" name="category" value="PreBuilt" />
                                <input type="hidden" name="name" value="Prebuilt" />
                                <label for="foto-upload-${prebuilt.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${prebuilt.ID}" name="foto" accept="image/*" multiple style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
                                <button type="submit" class="admin-btn" style="margin-top:2px;">Aggiungi Foto</button>
                            </form>
                        </td>
                        <td>
                            <form id="update-form-${prebuilt.ID}" class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                                <input type="hidden" name="id" value="${prebuilt.ID}" />
                                <input type="hidden" name="piece" value="prebuilt" />
                                <input type="hidden" name="type" value="prebuilt" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
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
        type.value = 'prebuilt';
        piece.type = 'hidden';
        piece.name = 'piece';
        piece.value = 'prebuilt';
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
        fetch('<%=request.getContextPath()%>/addFotoToPrebuilt', {
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
        Array.from(document.querySelectorAll('form.update-form .delete')).forEach(deleteBtn => {
            deleteBtn.addEventListener('click', function(e) {
                const row = deleteBtn.closest('tr');
                const idInput = row.querySelector('input[name="id"]');
                const id = idInput ? idInput.value : null;
                removeProduct(e, id);
            });
        });
        Array.from(document.querySelectorAll('form[action$="/updateFotoProduct"]')).forEach(form => {
            form.addEventListener('submit', updateFoto);
        });
        document.getElementById("form-nuovo-prebuilt").addEventListener("submit", newProduct);
        document.getElementById("random-id-btn").addEventListener("click", function() {
            const tempForm = document.createElement('form');
            const type = document.createElement('input');
            type.type = 'hidden';
            type.name = 'type';
            type.value = 'prebuilt';
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

    function removeSingleFoto(event, img, id) {
        event.preventDefault();
        const formData = new FormData();
        formData.append('imgPath', img);
        fetch('<%=request.getContextPath()%>/deleteFotoProduct', {
            method: 'POST',
            body: formData,
        }).then(response => response.json()).then(data => {
            if (data.status === "success") {
                location.reload();
            } else {
                alert(data.message || 'Errore durante la cancellazione della foto.');
            }
        });
    }

    function openPopup() {
        document.getElementById('popup-nuovo-prebuilt').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-prebuilt').style.display = 'none';
    }
</script>
</html>
