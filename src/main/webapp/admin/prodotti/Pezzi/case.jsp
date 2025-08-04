<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Case - Admin</title>
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
    <div id="popup-nuovo-case" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuovo Case</h3>
        <form id="form-nuovo-case" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="pezzo" />
          <input type="hidden" name="type" value="case" />
          <input type="hidden" name="category" value="fotoPezzi" />
          <input type="hidden" name="name" value="Case" />
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
              <label for="altezza-new" class="visually-hidden">Altezza (mm)</label>
              <input type="number" id="altezza-new" name="altezza" step="0.01" min="0" required aria-label="Altezza (mm)" placeholder="Altezza (mm)">
            </div>
            <div class="popup-field-wrapper">
              <label for="larghezza-new" class="visually-hidden">Larghezza (mm)</label>
              <input type="number" id="larghezza-new" name="larghezza" step="0.01" min="0" required aria-label="Larghezza (mm)" placeholder="Larghezza (mm)">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="profondita-new" class="visually-hidden">Profondità (mm)</label>
              <input type="number" id="profondita-new" name="profondita" step="0.01" min="0" required aria-label="Profondità (mm)" placeholder="Profondità (mm)">
            </div>
            <div class="popup-field-wrapper">
              <label for="peso-new" class="visually-hidden">Peso (kg)</label>
              <input type="number" id="peso-new" name="peso" step="0.01" min="0" required aria-label="Peso (kg)" placeholder="Peso (kg)">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="dotazione-new" class="visually-hidden">Dotazione</label>
              <input type="text" id="dotazione-new" name="dotazione" required aria-label="Dotazione" placeholder="Dotazione">
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
    <h2 class="admin-title">Gestione Case</h2>
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
                    <th>Altezza (mm)</th>
                    <th>Larghezza (mm)</th>
                    <th>Profondità (mm)</th>
                    <th>Peso (kg)</th>
                    <th>Dotazione</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="case2" items="${cases}">
                    <tr>
                        <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                            <td><input type="hidden" name="id" value="${case2.ID}" />${case2.ID}</td>
                            <td>
                              <label for="marca-${case2.ID}" class="visually-hidden">Marca</label>
                              <input type="text" id="marca-${case2.ID}" name="marca" value="${case2.marca}" aria-label="Marca" />
                            </td>
                            <td>
                              <label for="modello-${case2.ID}" class="visually-hidden">Modello</label>
                              <input type="text" id="modello-${case2.ID}" name="modello" value="${case2.modello}" aria-label="Modello" />
                            </td>
                            <td>
                              <label for="prezzo-${case2.ID}" class="visually-hidden">Prezzo</label>
                              <input type="number" id="prezzo-${case2.ID}" name="prezzo" value="${case2.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                            </td>
                            <td>
                              <label for="disponibilita-${case2.ID}" class="visually-hidden">Disponibilità</label>
                              <input type="number" id="disponibilita-${case2.ID}" name="disponibilita" value="${case2.disponibilita}" min="0" aria-label="Disponibilità" />
                            </td>
                            <td>
                              <label for="sconto-${case2.ID}" class="visually-hidden">Sconto</label>
                              <input type="number" id="sconto-${case2.ID}" name="sconto" value="${case2.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                            </td>
                            <td>
                              <label for="categoria-${case2.ID}" class="visually-hidden">Categoria</label>
                              <input type="text" id="categoria-${case2.ID}" name="categoria" value="${case2.categoria}" aria-label="Categoria" />
                            </td>
                            <td>
                              <label for="altezza-${case2.ID}" class="visually-hidden">Altezza (mm)</label>
                              <input type="number" id="altezza-${case2.ID}" name="altezza" value="${case2.altezza}" step="0.01" min="0" aria-label="Altezza (mm)" />
                            </td>
                            <td>
                              <label for="larghezza-${case2.ID}" class="visually-hidden">Larghezza (mm)</label>
                              <input type="number" id="larghezza-${case2.ID}" name="larghezza" value="${case2.larghezza}" step="0.01" min="0" aria-label="Larghezza (mm)" />
                            </td>
                            <td>
                              <label for="profondita-${case2.ID}" class="visually-hidden">Profondità (mm)</label>
                              <input type="number" id="profondita-${case2.ID}" name="profondita" value="${case2.profondita}" step="0.01" min="0" aria-label="Profondità (mm)" />
                            </td>
                            <td>
                              <label for="peso-${case2.ID}" class="visually-hidden">Peso (kg)</label>
                              <input type="number" id="peso-${case2.ID}" name="peso" value="${case2.peso}" step="0.01" min="0" aria-label="Peso (kg)" />
                            </td>
                            <td>
                              <label for="dotazione-${case2.ID}" class="visually-hidden">Dotazione</label>
                              <input type="text" id="dotazione-${case2.ID}" name="dotazione" value="${case2.dotazione}" aria-label="Dotazione" />
                            </td>
                            <td>
                                <c:set var="caseId" value="${case2.ID}" scope="request"/>
                                <%
                                    FotoDAO fotoDAO= new FotoDAO();
                                    Object caseId = request.getAttribute("caseId");
                                    String imagePath = fotoDAO.getFoto((Integer) caseId, "fotoPezzi", "Case", (String) request.getAttribute("path"));
                                %>
                                <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${case2.marca}_${case2.modello}" width="80">
                            </td>
                            <td>
                                <input type="hidden" name="piece" value="pezzo" />
                                <input type="hidden" name="type" value="case" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                            </td>
                        </form>
                        <td colspan="20" style="padding:0; border:none;">
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${case2.ID}" />
                                <input type="hidden" name="category" value="fotoPezzi" />
                                <input type="hidden" name="name" value="Case" />
                                <label for="foto-upload-${case2.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${case2.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
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
        type.value = 'case';
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
        document.getElementById("form-nuovo-case").addEventListener("submit", newProduct);
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
        document.getElementById('popup-nuovo-case').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-case').style.display = 'none';
    }
</script>
</html>
