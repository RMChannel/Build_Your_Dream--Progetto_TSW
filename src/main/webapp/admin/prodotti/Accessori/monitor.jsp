<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Monitor - Admin</title>
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
<div id="popup-nuovo-monitor" class="popup-overlay" style="display:none;">
    <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuovo Monitor</h3>
        <form id="form-nuovo-monitor" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
            <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
            <input type="hidden" name="piece" value="accessorio" />
            <input type="hidden" name="type" value="monitor" />
            <input type="hidden" name="category" value="fotoAccessori" />
            <input type="hidden" name="name" value="Monitor" />
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
              <label for="dimensione-new" class="visually-hidden">Dimensione (pollici)</label>
              <input type="number" id="dimensione-new" name="dimensione" min="0" required aria-label="Dimensione in pollici" placeholder="Pollici">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="risoluzione-new" class="visually-hidden">Risoluzione</label>
              <input type="text" id="risoluzione-new" name="risoluzione" required aria-label="Risoluzione" placeholder="Es: 1920x1080">
            </div>
            <div class="popup-field-wrapper">
              <label for="aspectRatio-new" class="visually-hidden">Aspect Ratio</label>
              <input type="text" id="aspectRatio-new" name="aspectRatio" required aria-label="Aspect Ratio" placeholder="Es: 16:9">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="tipo-new" class="visually-hidden">Tipo Pannello</label>
              <input type="text" id="tipo-new" name="tipo" required aria-label="Tipo" placeholder="Es: IPS, VA, TN">
            </div>
            <div class="popup-field-wrapper">
              <label for="responseTime-new" class="visually-hidden">Tempo di risposta (ms)</label>
              <input type="number" id="responseTime-new" name="responseTime" step="0.1" min="0" required aria-label="Tempo di risposta in ms" placeholder="ms">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="frequenza-new" class="visually-hidden">Frequenza (Hz)</label>
              <input type="number" id="frequenza-new" name="frequenza" min="0" required aria-label="Frequenza in Hz" placeholder="Hz">
            </div>
            <div class="popup-field-wrapper">
              <label for="hdr-new" class="visually-hidden">HDR</label>
              <select id="hdr-new" name="hdr" required aria-label="HDR">
                <option value="true">Sì</option>
                <option value="false">No</option>
              </select>
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="casse-new" class="visually-hidden">Casse Integrate</label>
              <select id="casse-new" name="casse" required aria-label="Casse">
                <option value="true">Sì</option>
                <option value="false">No</option>
              </select>
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
<h2 class="admin-title">Gestione Monitor</h2>
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
            <th>Dimensione (pollici)</th>
            <th>Risoluzione</th>
            <th>Aspect Ratio</th>
            <th>Tipo</th>
            <th>Tempo di risposta (ms)</th>
            <th>Frequenza (Hz)</th>
            <th>HDR</th>
            <th>Casse</th>
            <th>Immagine</th>
            <th>Azioni</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="monitor" items="${monitors}">
            <tr>
                <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                    <td><input type="hidden" name="id" value="${monitor.ID}" />${monitor.ID}</td>
                    <td>
                        <label for="marca-${monitor.ID}" class="visually-hidden">Marca</label>
                        <input type="text" id="marca-${monitor.ID}" name="marca" value="${monitor.marca}" aria-label="Marca" />
                    </td>
                    <td>
                        <label for="modello-${monitor.ID}" class="visually-hidden">Modello</label>
                        <input type="text" id="modello-${monitor.ID}" name="modello" value="${monitor.modello}" aria-label="Modello" />
                    </td>
                    <td>
                        <label for="prezzo-${monitor.ID}" class="visually-hidden">Prezzo</label>
                        <input type="number" id="prezzo-${monitor.ID}" name="prezzo" value="${monitor.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                    </td>
                    <td>
                        <label for="disponibilita-${monitor.ID}" class="visually-hidden">Disponibilità</label>
                        <input type="number" id="disponibilita-${monitor.ID}" name="disponibilita" value="${monitor.disponibilita}" min="0" aria-label="Disponibilità" />
                    </td>
                    <td>
                        <label for="sconto-${monitor.ID}" class="visually-hidden">Sconto</label>
                        <input type="number" id="sconto-${monitor.ID}" name="sconto" value="${monitor.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                    </td>
                    <td>
                        <label for="dimensione-${monitor.ID}" class="visually-hidden">Dimensione</label>
                        <input type="number" id="dimensione-${monitor.ID}" name="dimensione" value="${monitor.dimensione}" min="0" aria-label="Dimensione in pollici" />
                    </td>
                    <td>
                        <label for="risoluzione-${monitor.ID}" class="visually-hidden">Risoluzione</label>
                        <input type="text" id="risoluzione-${monitor.ID}" name="risoluzione" value="${monitor.risoluzione}" aria-label="Risoluzione" />
                    </td>
                    <td>
                        <label for="aspectRatio-${monitor.ID}" class="visually-hidden">Aspect Ratio</label>
                        <input type="text" id="aspectRatio-${monitor.ID}" name="aspectRatio" value="${monitor.aspectRatio}" aria-label="Aspect Ratio" />
                    </td>
                    <td>
                        <label for="tipo-${monitor.ID}" class="visually-hidden">Tipo</label>
                        <input type="text" id="tipo-${monitor.ID}" name="tipo" value="${monitor.tipo}" aria-label="Tipo" />
                    </td>
                    <td>
                        <label for="responseTime-${monitor.ID}" class="visually-hidden">Tempo di risposta</label>
                        <input type="number" id="responseTime-${monitor.ID}" name="responseTime" value="${monitor.responseTime}" step="0.1" min="0" aria-label="Tempo di risposta in ms" />
                    </td>
                    <td>
                        <label for="frequenza-${monitor.ID}" class="visually-hidden">Frequenza</label>
                        <input type="number" id="frequenza-${monitor.ID}" name="frequenza" value="${monitor.frequenza}" min="0" aria-label="Frequenza in Hz" />
                    </td>
                    <td>
                        <label for="hdr-${monitor.ID}" class="visually-hidden">HDR</label>
                        <select id="hdr-${monitor.ID}" name="hdr" aria-label="HDR">
                            <option value="true" ${monitor.hdr ? 'selected' : ''}>Sì</option>
                            <option value="false" ${!monitor.hdr ? 'selected' : ''}>No</option>
                        </select>
                    </td>
                    <td>
                        <label for="casse-${monitor.ID}" class="visually-hidden">Casse</label>
                        <select id="casse-${monitor.ID}" name="casse" aria-label="Casse">
                            <option value="true" ${monitor.casse ? 'selected' : ''}>Sì</option>
                            <option value="false" ${!monitor.casse ? 'selected' : ''}>No</option>
                        </select>
                    </td>
                    <td>
                        <c:set var="monitorId" value="${monitor.ID}" scope="request"/>
                        <%
                            FotoDAO fotoDAO= new FotoDAO();
                            Object monitorId = request.getAttribute("monitorId");
                            String imagePath = fotoDAO.getFoto((Integer) monitorId, "fotoAccessori", "Monitor", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${monitor.marca}_${monitor.modello}" width="80">
                    </td>
                    <td>
                        <input type="hidden" name="piece" value="accessorio" />
                        <input type="hidden" name="type" value="monitor" />
                        <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                        <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                        <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                    </td>
                </form>
                <td colspan="16" style="padding:0; border:none;">
                    <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                        <input type="hidden" name="id" value="${monitor.ID}" />
                        <input type="hidden" name="category" value="fotoAccessori" />
                        <input type="hidden" name="name" value="Monitor" />
                        <label for="foto-upload-${monitor.ID}" class="visually-hidden">Carica foto</label>
                        <input type="file" id="foto-upload-${monitor.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
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
        type.value = 'monitor';
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
        document.getElementById("form-nuovo-monitor").addEventListener("submit", newProduct);
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
        document.getElementById('popup-nuovo-monitor').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-monitor').style.display = 'none';
    }
</script>
</html>