<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Tastiere - Admin</title>
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
    <div id="popup-nuovo-tastiera" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuova Tastiera</h3>
        <form id="form-nuovo-tastiera" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="accessorio" />
          <input type="hidden" name="type" value="tastiera" />
          <input type="hidden" name="category" value="fotoAccessori" />
          <input type="hidden" name="name" value="Tastiere" />
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
              <label for="layout-new" class="visually-hidden">Layout</label>
              <input type="text" id="layout-new" name="layout" required aria-label="Layout" placeholder="Layout">
            </div>
            <div class="popup-field-wrapper">
              <label for="compatta-new" class="visually-hidden">Compatta</label>
              <select id="compatta-new" name="compatta" required aria-label="Compatta">
                <option value="true">Sì</option>
                <option value="false">No</option>
              </select>
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="led-new" class="visually-hidden">LED</label>
              <select id="led-new" name="led" required aria-label="LED">
                <option value="true">Sì</option>
                <option value="false">No</option>
              </select>
            </div>
            <div class="popup-field-wrapper">
              <label for="connettivita-new" class="visually-hidden">Connettività</label>
              <input type="text" id="connettivita-new" name="connettivita" required aria-label="Connettività" placeholder="Connettività">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="larghezza-new" class="visually-hidden">Larghezza (mm)</label>
              <input type="number" id="larghezza-new" name="larghezza" step="0.1" min="0" required aria-label="Larghezza (mm)" placeholder="Larghezza (mm)">
            </div>
            <div class="popup-field-wrapper">
              <label for="lunghezza-new" class="visually-hidden">Lunghezza (mm)</label>
              <input type="number" id="lunghezza-new" name="lunghezza" step="0.1" min="0" required aria-label="Lunghezza (mm)" placeholder="Lunghezza (mm)">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="peso-new" class="visually-hidden">Peso (g)</label>
              <input type="number" id="peso-new" name="peso" step="0.1" min="0" required aria-label="Peso (g)" placeholder="Peso (g)">
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
    <h2 class="admin-title">Gestione Tastiere</h2>
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
                    <th>Layout</th>
                    <th>Compatta</th>
                    <th>LED</th>
                    <th>Connettività</th>
                    <th>Larghezza (mm)</th>
                    <th>Lunghezza (mm)</th>
                    <th>Peso (g)</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="tastiera" items="${tastiere}">
                    <tr>
                        <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                            <td><input type="hidden" name="id" value="${tastiera.ID}" />${tastiera.ID}</td>
                            <td>
                              <label for="marca-${tastiera.ID}" class="visually-hidden">Marca</label>
                              <input type="text" id="marca-${tastiera.ID}" name="marca" value="${tastiera.marca}" aria-label="Marca" />
                            </td>
                            <td>
                              <label for="modello-${tastiera.ID}" class="visually-hidden">Modello</label>
                              <input type="text" id="modello-${tastiera.ID}" name="modello" value="${tastiera.modello}" aria-label="Modello" />
                            </td>
                            <td>
                              <label for="prezzo-${tastiera.ID}" class="visually-hidden">Prezzo</label>
                              <input type="number" id="prezzo-${tastiera.ID}" name="prezzo" value="${tastiera.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                            </td>
                            <td>
                              <label for="disponibilita-${tastiera.ID}" class="visually-hidden">Disponibilità</label>
                              <input type="number" id="disponibilita-${tastiera.ID}" name="disponibilita" value="${tastiera.disponibilita}" min="0" aria-label="Disponibilità" />
                            </td>
                            <td>
                              <label for="sconto-${tastiera.ID}" class="visually-hidden">Sconto</label>
                              <input type="number" id="sconto-${tastiera.ID}" name="sconto" value="${tastiera.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                            </td>
                            <td>
                              <label for="categoria-${tastiera.ID}" class="visually-hidden">Categoria</label>
                              <input type="text" id="categoria-${tastiera.ID}" name="categoria" value="${tastiera.categoria}" aria-label="Categoria" />
                            </td>
                            <td>
                              <label for="layout-${tastiera.ID}" class="visually-hidden">Layout</label>
                              <input type="text" id="layout-${tastiera.ID}" name="layout" value="${tastiera.layout}" aria-label="Layout" />
                            </td>
                            <td>
                                <label for="compatta-${tastiera.ID}" class="visually-hidden">Compatta</label>
                                <select id="compatta-${tastiera.ID}" name="compatta" aria-label="Compatta">
                                    <option value="true" ${tastiera.compatta ? 'selected' : ''}>Sì</option>
                                    <option value="false" ${!tastiera.compatta ? 'selected' : ''}>No</option>
                                </select>
                            </td>
                            <td>
                                <label for="led-${tastiera.ID}" class="visually-hidden">LED</label>
                                <select id="led-${tastiera.ID}" name="led" aria-label="LED">
                                    <option value="true" ${tastiera.led ? 'selected' : ''}>Sì</option>
                                    <option value="false" ${!tastiera.led ? 'selected' : ''}>No</option>
                                </select>
                            </td>
                            <td>
                              <label for="connettivita-${tastiera.ID}" class="visually-hidden">Connettività</label>
                              <input type="text" id="connettivita-${tastiera.ID}" name="connettivita" value="${tastiera.connettivita}" aria-label="Connettività" />
                            </td>
                            <td>
                              <label for="larghezza-${tastiera.ID}" class="visually-hidden">Larghezza (mm)</label>
                              <input type="number" id="larghezza-${tastiera.ID}" name="larghezza" value="${tastiera.larghezza}" step="0.1" min="0" aria-label="Larghezza (mm)" />
                            </td>
                            <td>
                              <label for="lunghezza-${tastiera.ID}" class="visually-hidden">Lunghezza (mm)</label>
                              <input type="number" id="lunghezza-${tastiera.ID}" name="lunghezza" value="${tastiera.lunghezza}" step="0.1" min="0" aria-label="Lunghezza (mm)" />
                            </td>
                            <td>
                              <label for="peso-${tastiera.ID}" class="visually-hidden">Peso (g)</label>
                              <input type="number" id="peso-${tastiera.ID}" name="peso" value="${tastiera.peso}" step="0.1" min="0" aria-label="Peso (g)" />
                            </td>
                            <td>
                                <c:set var="tastieraId" value="${tastiera.ID}" scope="request"/>
                                <%
                                    FotoDAO fotoDAO= new FotoDAO();
                                    Object tastieraId = request.getAttribute("tastieraId");
                                    String imagePath = fotoDAO.getFoto((Integer) tastieraId, "fotoAccessori", "Tastiere", (String) request.getAttribute("path"));
                                %>
                                <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${tastiera.marca}_${tastiera.modello}" width="80">
                            </td>
                            <td>
                                <input type="hidden" name="piece" value="accessorio" />
                                <input type="hidden" name="type" value="tastiera" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                            </td>
                        </form>
                        <td colspan="16" style="padding:0; border:none;">
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${tastiera.ID}" />
                                <input type="hidden" name="category" value="fotoAccessori" />
                                <input type="hidden" name="name" value="Tastiere" />
                                <label for="foto-upload-${tastiera.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${tastiera.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
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
        type.value = 'tastiera';
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
        Array.from(document.querySelectorAll('form[action$="/updateFotoProduct"]')).forEach(form => {
            form.addEventListener('submit', updateFoto);
        });
        document.getElementById("form-nuovo-tastiera").addEventListener("submit", newProduct);
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
        document.getElementById('popup-nuovo-tastiera').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-tastiera').style.display = 'none';
    }
</script>
</html>
