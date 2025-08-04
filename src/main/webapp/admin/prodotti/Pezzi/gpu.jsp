<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione GPU - Admin</title>
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
    <div id="popup-nuovo-gpu" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuova GPU</h3>
        <form id="form-nuovo-gpu" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="pezzo" />
          <input type="hidden" name="type" value="gpu" />
          <input type="hidden" name="category" value="fotoPezzi" />
          <input type="hidden" name="name" value="GPU" />
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
              <label for="produttore-new" class="visually-hidden">Produttore</label>
              <input type="text" id="produttore-new" name="produttore" required aria-label="Produttore" placeholder="Produttore">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="VRAM-new" class="visually-hidden">VRAM (GB)</label>
              <input type="number" id="VRAM-new" name="VRAM" min="1" required aria-label="VRAM in GB" placeholder="VRAM (GB)">
            </div>
            <div class="popup-field-wrapper">
              <label for="VRAMtype-new" class="visually-hidden">Tipo VRAM</label>
              <input type="text" id="VRAMtype-new" name="VRAMtype" required aria-label="Tipo VRAM" placeholder="Tipo VRAM">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="pcie-new" class="visually-hidden">PCIE</label>
              <input type="text" id="pcie-new" name="pcie" required aria-label="PCIE" placeholder="PCIE">
            </div>
            <div class="popup-field-wrapper">
              <label for="overclock-new" class="visually-hidden">Overclock</label>
              <select id="overclock-new" name="overclock" required aria-label="Overclock">
                <option value="true">Sì</option>
                <option value="false">No</option>
              </select>
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="watt-new" class="visually-hidden">Consumo (W)</label>
              <input type="number" id="watt-new" name="watt" min="0" required aria-label="Consumo in Watt" placeholder="Consumo (W)">
            </div>
            <div class="popup-field-wrapper">
              <label for="peso-new" class="visually-hidden">Peso (g)</label>
              <input type="number" id="peso-new" name="peso" min="0" step="0.01" required aria-label="Peso in grammi" placeholder="Peso (g)">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="memFrequence-new" class="visually-hidden">Frequenza Memoria</label>
              <input type="text" id="memFrequence-new" name="memFrequence" required aria-label="Frequenza memoria" placeholder="Frequenza Memoria">
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
    <h2 class="admin-title">Gestione GPU</h2>
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
                    <th>Produttore</th>
                    <th>VRAM (GB)</th>
                    <th>Tipo VRAM</th>
                    <th>PCIE</th>
                    <th>Overclock</th>
                    <th>Consumo (W)</th>
                    <th>Peso (g)</th>
                    <th>Frequenza Memoria</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="gpu" items="${gpus}">
                    <tr>
                        <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                            <td><input type="hidden" name="id" value="${gpu.ID}" />${gpu.ID}</td>
                            <td>
                              <label for="marca-${gpu.ID}" class="visually-hidden">Marca</label>
                              <input type="text" id="marca-${gpu.ID}" name="marca" value="${gpu.marca}" aria-label="Marca" />
                            </td>
                            <td>
                              <label for="modello-${gpu.ID}" class="visually-hidden">Modello</label>
                              <input type="text" id="modello-${gpu.ID}" name="modello" value="${gpu.modello}" aria-label="Modello" />
                            </td>
                            <td>
                              <label for="prezzo-${gpu.ID}" class="visually-hidden">Prezzo</label>
                              <input type="number" id="prezzo-${gpu.ID}" name="prezzo" value="${gpu.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                            </td>
                            <td>
                              <label for="disponibilita-${gpu.ID}" class="visually-hidden">Disponibilità</label>
                              <input type="number" id="disponibilita-${gpu.ID}" name="disponibilita" value="${gpu.disponibilita}" min="0" aria-label="Disponibilità" />
                            </td>
                            <td>
                              <label for="sconto-${gpu.ID}" class="visually-hidden">Sconto</label>
                              <input type="number" id="sconto-${gpu.ID}" name="sconto" value="${gpu.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                            </td>
                            <td>
                              <label for="produttore-${gpu.ID}" class="visually-hidden">Produttore</label>
                              <input type="text" id="produttore-${gpu.ID}" name="produttore" value="${gpu.produttore}" aria-label="Produttore" />
                            </td>
                            <td>
                              <label for="VRAM-${gpu.ID}" class="visually-hidden">VRAM</label>
                              <input type="number" id="VRAM-${gpu.ID}" name="VRAM" value="${gpu.VRAM}" min="1" aria-label="VRAM in GB" />
                            </td>
                            <td>
                              <label for="VRAMtype-${gpu.ID}" class="visually-hidden">Tipo VRAM</label>
                              <input type="text" id="VRAMtype-${gpu.ID}" name="VRAMtype" value="${gpu.VRAMtype}" aria-label="Tipo VRAM" />
                            </td>
                            <td>
                              <label for="pcie-${gpu.ID}" class="visually-hidden">PCIE</label>
                              <input type="text" id="pcie-${gpu.ID}" name="pcie" value="${gpu.pcie}" aria-label="PCIE" />
                            </td>
                            <td>
                              <label for="overclock-${gpu.ID}" class="visually-hidden">Overclock</label>
                              <select id="overclock-${gpu.ID}" name="overclock" aria-label="Overclock">
                                <option value="true" ${gpu.overclock ? 'selected' : ''}>Sì</option>
                                <option value="false" ${!gpu.overclock ? 'selected' : ''}>No</option>
                              </select>
                            </td>
                            <td>
                              <label for="watt-${gpu.ID}" class="visually-hidden">Consumo</label>
                              <input type="number" id="watt-${gpu.ID}" name="watt" value="${gpu.watt}" min="0" aria-label="Consumo in Watt" />
                            </td>
                            <td>
                              <label for="peso-${gpu.ID}" class="visually-hidden">Peso</label>
                              <input type="number" id="peso-${gpu.ID}" name="peso" value="${gpu.peso}" min="0" step="0.01" aria-label="Peso in grammi" />
                            </td>
                            <td>
                              <label for="memFrequence-${gpu.ID}" class="visually-hidden">Frequenza Memoria</label>
                              <input type="text" id="memFrequence-${gpu.ID}" name="memFrequence" value="${gpu.memFrequence}" aria-label="Frequenza memoria" />
                            </td>
                            <td>
                                <c:set var="gpuId" value="${gpu.ID}" scope="request"/>
                                <%
                                    FotoDAO fotoDAO= new FotoDAO();
                                    Object gpuId = request.getAttribute("gpuId");
                                    String imagePath = fotoDAO.getFoto((Integer) gpuId, "fotoPezzi", "GPU", (String) request.getAttribute("path"));
                                %>
                                <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${gpu.marca}_${gpu.modello}" width="80">
                            </td>
                            <td>
                                <input type="hidden" name="piece" value="pezzo" />
                                <input type="hidden" name="type" value="gpu" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                            </td>
                        </form>
                        <td colspan="16" style="padding:0; border:none;">
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${gpu.ID}" />
                                <input type="hidden" name="category" value="fotoPezzi" />
                                <input type="hidden" name="name" value="GPU" />
                                <label for="foto-upload-${gpu.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${gpu.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
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
        type.value = 'gpu';
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
        document.getElementById("form-nuovo-gpu").addEventListener("submit", newProduct);
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
        document.getElementById('popup-nuovo-gpu').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-gpu').style.display = 'none';
    }
</script>
</html>
