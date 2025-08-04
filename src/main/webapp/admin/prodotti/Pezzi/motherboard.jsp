<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Motherboard - Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/productStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/accessibilityStyles.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
    <div class="admin-back-btns" style="display: flex; gap: 24px; margin: 18px 0 0 18px; position: static;">
        <a href="<%=request.getContextPath()%>/adminPage" class="admin-back-btn btn-admin-area">&larr; Torna all'area admin</a>
        <a href="<%=request.getContextPath()%>/adminPage/gestioneProdotti?piece=pezzi" class="admin-back-btn btn-accessori">&larr; Torna indietro</a>
        <button type="button" class="admin-btn add-product-btn" style="margin-left:auto;" onclick="openPopup()">Nuovo Prodotto</button>
    </div>
    <div id="popup-nuovo-motherboard" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuova Motherboard</h3>
        <form id="form-nuovo-motherboard" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="pezzo" />
          <input type="hidden" name="type" value="motherboard" />
          <input type="hidden" name="category" value="fotoPezzi" />
          <input type="hidden" name="name" value="Motherboard" />
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
              <label for="socket-new" class="visually-hidden">Socket</label>
              <input type="text" id="socket-new" name="socket" required aria-label="Socket" placeholder="Socket">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="categoria-new" class="visually-hidden">Categoria</label>
              <input type="text" id="categoria-new" name="categoria" required aria-label="Categoria" placeholder="Categoria">
            </div>
            <div class="popup-field-wrapper">
              <label for="tipo_ram-new" class="visually-hidden">Tipo RAM</label>
              <input type="text" id="tipo_ram-new" name="tipo_ram" required aria-label="Tipo RAM" placeholder="Tipo RAM">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="nSlot-new" class="visually-hidden">Numero Slot RAM</label>
              <input type="number" id="nSlot-new" name="nSlot" min="1" required aria-label="Numero Slot RAM" placeholder="N° Slot RAM">
            </div>
            <div class="popup-field-wrapper">
              <label for="capacitaRAM-new" class="visually-hidden">Capacità RAM (GB)</label>
              <input type="number" id="capacitaRAM-new" name="capacitaRAM" min="1" required aria-label="Capacità RAM in GB" placeholder="Capacità RAM (GB)">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="nSata-new" class="visually-hidden">Numero Sata</label>
              <input type="number" id="nSata-new" name="nSata" min="0" required aria-label="Numero Sata" placeholder="N° Sata">
            </div>
            <div class="popup-field-wrapper">
              <label for="nM2-new" class="visually-hidden">Numero M.2</label>
              <input type="number" id="nM2-new" name="nM2" min="0" required aria-label="Numero M.2" placeholder="N° M.2">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="wifi-new" class="visually-hidden">WiFi</label>
              <select id="wifi-new" name="wifi" required aria-label="WiFi">
                <option value="true">Sì</option>
                <option value="false">No</option>
              </select>
            </div>
            <div class="popup-field-wrapper">
              <label for="pcie-new" class="visually-hidden">PCIE</label>
              <input type="text" id="pcie-new" name="pcie" required aria-label="PCIE" placeholder="PCIE">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="nPcie-new" class="visually-hidden">Numero PCIE</label>
              <input type="number" id="nPcie-new" name="nPcie" min="0" required aria-label="Numero PCIE" placeholder="N° PCIE">
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
    <h2 class="admin-title">Gestione Motherboard</h2>
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
                    <th>Socket</th>
                    <th>Categoria</th>
                    <th>Tipo RAM</th>
                    <th>n° Slot RAM</th>
                    <th>Capacità RAM (GB)</th>
                    <th>n° Sata</th>
                    <th>n° M.2</th>
                    <th>WiFi</th>
                    <th>TIPO PCIE</th>
                    <th>n°Slot PCIE</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="mb" items="${motherboards}">
                    <tr>
                        <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                            <td><input type="hidden" name="id" value="${mb.ID}" />${mb.ID}</td>
                            <td>
                              <label for="marca-${mb.ID}" class="visually-hidden">Marca</label>
                              <input type="text" id="marca-${mb.ID}" name="marca" value="${mb.marca}" aria-label="Marca" />
                            </td>
                            <td>
                              <label for="modello-${mb.ID}" class="visually-hidden">Modello</label>
                              <input type="text" id="modello-${mb.ID}" name="modello" value="${mb.modello}" aria-label="Modello" />
                            </td>
                            <td>
                              <label for="prezzo-${mb.ID}" class="visually-hidden">Prezzo</label>
                              <input type="number" id="prezzo-${mb.ID}" name="prezzo" value="${mb.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                            </td>
                            <td>
                              <label for="disponibilita-${mb.ID}" class="visually-hidden">Disponibilità</label>
                              <input type="number" id="disponibilita-${mb.ID}" name="disponibilita" value="${mb.disponibilita}" min="0" aria-label="Disponibilità" />
                            </td>
                            <td>
                              <label for="sconto-${mb.ID}" class="visually-hidden">Sconto</label>
                              <input type="number" id="sconto-${mb.ID}" name="sconto" value="${mb.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                            </td>
                            <td>
                              <label for="socket-${mb.ID}" class="visually-hidden">Socket</label>
                              <input type="text" id="socket-${mb.ID}" name="socket" value="${mb.socket}" aria-label="Socket" />
                            </td>
                            <td>
                              <label for="categoria-${mb.ID}" class="visually-hidden">Categoria</label>
                              <input type="text" id="categoria-${mb.ID}" name="categoria" value="${mb.categoria}" aria-label="Categoria" />
                            </td>
                            <td>
                              <label for="tipo_ram-${mb.ID}" class="visually-hidden">Tipo RAM</label>
                              <input type="text" id="tipo_ram-${mb.ID}" name="tipo_ram" value="${mb.tipo_ram}" aria-label="Tipo RAM" />
                            </td>
                            <td>
                              <label for="nSlot-${mb.ID}" class="visually-hidden">Numero Slot RAM</label>
                              <input type="number" id="nSlot-${mb.ID}" name="nSlot" value="${mb.nSlot}" min="1" aria-label="Numero Slot RAM" />
                            </td>
                            <td>
                              <label for="capacitaRAM-${mb.ID}" class="visually-hidden">Capacità RAM</label>
                              <input type="number" id="capacitaRAM-${mb.ID}" name="capacitaRAM" value="${mb.capacitaRAM}" min="1" aria-label="Capacità RAM in GB" />
                            </td>
                            <td>
                              <label for="nSata-${mb.ID}" class="visually-hidden">Numero Sata</label>
                              <input type="number" id="nSata-${mb.ID}" name="nSata" value="${mb.nSata}" min="0" aria-label="Numero Sata" />
                            </td>
                            <td>
                              <label for="nM2-${mb.ID}" class="visually-hidden">Numero M.2</label>
                              <input type="number" id="nM2-${mb.ID}" name="nM2" value="${mb.nM2}" min="0" aria-label="Numero M.2" />
                            </td>
                            <td>
                                <label for="wifi-${mb.ID}" class="visually-hidden">WiFi</label>
                                <select id="wifi-${mb.ID}" name="wifi" aria-label="WiFi">
                                    <option value="true" ${mb.wifi ? 'selected' : ''}>Sì</option>
                                    <option value="false" ${!mb.wifi ? 'selected' : ''}>No</option>
                                </select>
                            </td>
                            <td>
                                <label for="pcie-${mb.ID}" class="visually-hidden">PCIE</label>
                                <input type="text" id="pcie-${mb.ID}" name="pcie" value="${mb.pcie}" aria-label="PCIE" />
                            </td>
                            <td>
                                <label for="nPcie-${mb.ID}" class="visually-hidden">Numero PCIE</label>
                                <input type="number" id="nPcie-${mb.ID}" name="nPcie" value="${mb.nPcie}" min="0" aria-label="Numero PCIE" />
                            </td>
                            <td>
                                <c:set var="mbId" value="${mb.ID}" scope="request"/>
                                <% FotoDAO fotoDAO= new FotoDAO(); Object mbId = request.getAttribute("mbId"); String imagePath = fotoDAO.getFoto((Integer) mbId, "fotoPezzi", "Motherboard", (String) request.getAttribute("path")); %>
                                <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${mb.marca}_${mb.modello}" width="80">
                            </td>
                            <td>
                                <input type="hidden" name="piece" value="pezzo" />
                                <input type="hidden" name="type" value="motherboard" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                            </td>
                        </form>
                        <td colspan="20" style="padding:0; border:none;">
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${mb.ID}" />
                                <input type="hidden" name="category" value="fotoPezzi" />
                                <input type="hidden" name="name" value="Motherboard" />
                                <label for="foto-upload-${mb.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${mb.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
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
        type.value = 'motherboard';
        piece.type = 'hidden';
        piece.name = 'piece';
        piece.value = 'pezzo';
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
        document.getElementById("form-nuovo-motherboard").addEventListener("submit", newProduct);
        document.getElementById("random-id-btn").addEventListener("click", function() {
            const tempForm = document.createElement('form');
            const type = document.createElement('input');
            type.type = 'hidden';
            type.name = 'type';
            type.value = 'pezzo';
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
        document.getElementById('popup-nuovo-motherboard').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-motherboard').style.display = 'none';
    }
</script>
</html>
