<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Air Cooling - Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/productStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/accessibilityStyles.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
    <div class="admin-back-btns" style="display: flex; gap: 24px; margin: 18px 0 0 18px; position: static;">
    <button type="button" class="admin-btn add-product-btn" style="margin-left:auto;" onclick="openPopup()">Nuovo Prodotto</button>
</div>
<div id="popup-nuovo-aircooling" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuovo Air Cooling</h3>
        <form id="form-nuovo-aircooling" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="pezzo" />
          <input type="hidden" name="type" value="aircooling" />
          <input type="hidden" name="category" value="fotoPezzi" />
          <input type="hidden" name="name" value="AirCooling" />
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
              <label for="socket-new" class="visually-hidden">Socket Supportati</label>
              <input type="text" id="socket-new" name="socket" required aria-label="Socket Supportati" placeholder="Socket Supportati">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="altezza-new" class="visually-hidden">Altezza (mm)</label>
              <input type="number" id="altezza-new" name="altezza" min="0" required aria-label="Altezza (mm)" placeholder="Altezza (mm)">
            </div>
            <div class="popup-field-wrapper">
              <label for="nVentole-new" class="visually-hidden">Numero Ventole</label>
              <input type="number" id="nVentole-new" name="nVentole" min="1" required aria-label="Numero Ventole" placeholder="N° Ventole">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="dimVentola-new" class="visually-hidden">Dimensione Ventole (mm)</label>
              <input type="number" id="dimVentola-new" name="dimVentola" required aria-label="Dimensione Ventole (mm)" placeholder="Dim. Ventole (mm)">
            </div>
            <div class="popup-field-wrapper">
              <label for="maxRPM-new" class="visually-hidden">max RPM</label>
              <input type="number" id="maxRPM-new" name="maxRPM" min="0" required aria-label="max RPM" placeholder="Max RPM">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="tdp-new" class="visually-hidden">TDP</label>
              <input type="number" id="tdp-new" name="tdp" min="0" required aria-label="TDP" placeholder="TDP">
            </div>
            <div class="popup-field-wrapper">
              <label for="colore-new" class="visually-hidden">Colore</label>
              <input type="text" id="colore-new" name="colore" required aria-label="Colore" placeholder="Colore">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="rgb-new" class="visually-hidden">RGB</label>
              <select id="rgb-new" name="rgb" required aria-label="RGB">
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
    <h2 class="admin-title">Gestione Air Cooling</h2>
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
                    <th>Socket Supportati</th>
                    <th>Altezza (mm)</th>
                    <th>Numero Ventole</th>
                    <th>Dimensione Ventole (mm)</th>
                    <th>RPM</th>
                    <th>TDP</th>
                    <th>Colore</th>
                    <th>RGB</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="aircooling" items="${aircoolings}">
                    <tr>
                        <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                            <td><input type="hidden" name="id" value="${aircooling.ID}" />${aircooling.ID}</td>
                            <td>
                              <label for="marca-${aircooling.ID}" class="visually-hidden">Marca</label>
                              <input type="text" id="marca-${aircooling.ID}" name="marca" value="${aircooling.marca}" aria-label="Marca" />
                            </td>
                            <td>
                              <label for="modello-${aircooling.ID}" class="visually-hidden">Modello</label>
                              <input type="text" id="modello-${aircooling.ID}" name="modello" value="${aircooling.modello}" aria-label="Modello" />
                            </td>
                            <td>
                              <label for="prezzo-${aircooling.ID}" class="visually-hidden">Prezzo</label>
                              <input type="number" id="prezzo-${aircooling.ID}" name="prezzo" value="${aircooling.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                            </td>
                            <td>
                              <label for="disponibilita-${aircooling.ID}" class="visually-hidden">Disponibilità</label>
                              <input type="number" id="disponibilita-${aircooling.ID}" name="disponibilita" value="${aircooling.disponibilita}" min="0" aria-label="Disponibilità" />
                            </td>
                            <td>
                              <label for="sconto-${aircooling.ID}" class="visually-hidden">Sconto</label>
                              <input type="number" id="sconto-${aircooling.ID}" name="sconto" value="${aircooling.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                            </td>
                            <td>
                              <label for="socket-${aircooling.ID}" class="visually-hidden">Socket Supportati</label>
                              <input type="text" id="socket-${aircooling.ID}" name="socket" value="${aircooling.socket}" aria-label="Socket Supportati" />
                            </td>
                            <td>
                              <label for="altezza-${aircooling.ID}" class="visually-hidden">Altezza (mm)</label>
                              <input type="number" id="altezza-${aircooling.ID}" name="altezza" value="${aircooling.altezza}" min="0" aria-label="Altezza (mm)" />
                            </td>
                            <td>
                              <label for="nVentole-${aircooling.ID}" class="visually-hidden">Numero Ventole</label>
                              <input type="number" id="nVentole-${aircooling.ID}" name="nVentole" value="${aircooling.nVentole}" min="1" aria-label="Numero Ventole" />
                            </td>
                            <td>
                              <label for="dimVentola-${aircooling.ID}" class="visually-hidden">Dimensione Ventole (mm)</label>
                              <input type="number" id="dimVentola-${aircooling.ID}" name="dimVentola" value="${aircooling.dimVentola}" aria-label="Dimensione Ventole (mm)" />
                            </td>
                            <td>
                              <label for="maxRPM-${aircooling.ID}" class="visually-hidden">max RPM</label>
                              <input type="number" id="maxRPM-${aircooling.ID}" name="maxRPM" value="${aircooling.maxRPM}" min="0" aria-label="max RPM" />
                            </td>
                            <td>
                              <label for="tdp-${aircooling.ID}" class="visually-hidden">TDP</label>
                              <input type="number" id="tdp-${aircooling.ID}" name="tdp" value="${aircooling.TDP}" min="0" aria-label="TDP" />
                            </td>
                            <td>
                              <label for="colore-${aircooling.ID}" class="visually-hidden">Colore</label>
                              <input type="text" id="colore-${aircooling.ID}" name="colore" value="${aircooling.colore}" aria-label="Colore" />
                            </td>
                            <td>
                                <label for="rgb-${aircooling.ID}" class="visually-hidden">RGB</label>
                                <select id="rgb-${aircooling.ID}" name="rgb" aria-label="RGB">
                                    <option value="true" ${aircooling.rgb ? 'selected' : ''}>Si</option>
                                    <option value="false" ${!aircooling.rgb ? 'selected' : ''}>No</option>
                                </select>
                            </td>
                            <td>
                                <c:set var="aircoolingId" value="${aircooling.ID}" scope="request"/>
                                <%
                                    FotoDAO fotoDAO= new FotoDAO();
                                    Object aircoolingId = request.getAttribute("aircoolingId");
                                    String imagePath = fotoDAO.getFoto((Integer) aircoolingId, "fotoPezzi", "AirCooling", (String) request.getAttribute("path"));
                                %>
                                <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${aircooling.marca}_${aircooling.modello}" width="80">
                            </td>
                            <td>
                                <input type="hidden" name="piece" value="pezzo" />
                                <input type="hidden" name="type" value="aircooling" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                            </td>
                        </form>
                        <td colspan="16" style="padding:0; border:none;">
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${aircooling.ID}" />
                                <input type="hidden" name="category" value="fotoPezzi" />
                                <input type="hidden" name="name" value="AirCooling" />
                                <label for="foto-upload-${aircooling.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${aircooling.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
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
        type.value = 'aircooling';
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
        Array.from(document.querySelectorAll('form[action$="/updateFotoProduct"]')).forEach(form => {
            form.addEventListener('submit', updateFoto);
        });
        document.getElementById("form-nuovo-aircooling").addEventListener("submit", newProduct);
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
        document.getElementById('popup-nuovo-aircooling').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-aircooling').style.display = 'none';
    }
</script>
</html>
