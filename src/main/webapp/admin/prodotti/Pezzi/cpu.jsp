<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione CPU - Admin</title>
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
    <div id="popup-nuovo-cpu" class="popup-overlay" style="display:none;">
      <div class="popup-content enhanced-popup">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <h3>Nuova CPU</h3>
        <form id="form-nuovo-cpu" action="<%=request.getContextPath()%>/newProduct" method="post" enctype="multipart/form-data">
          <div id="popup-error-message" class="error-message" style="display:none; color:#ff4136; font-size:1em; margin-bottom:10px;"></div>
          <input type="hidden" name="piece" value="pezzo" />
          <input type="hidden" name="type" value="cpu" />
          <input type="hidden" name="category" value="fotoPezzi" />
          <input type="hidden" name="name" value="CPU" />
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
              <label for="famiglia-new" class="visually-hidden">Famiglia</label>
              <input type="text" id="famiglia-new" name="famiglia" required aria-label="Famiglia" placeholder="Es: Ryzen, Core">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="generazione-new" class="visually-hidden">Generazione</label>
              <input type="text" id="generazione-new" name="generazione" required aria-label="Generazione" placeholder="Generazione">
            </div>
            <div class="popup-field-wrapper">
              <label for="nCore-new" class="visually-hidden">Numero Core</label>
              <input type="number" id="nCore-new" name="nCore" min="1" required aria-label="Numero core" placeholder="Core">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="nThreads-new" class="visually-hidden">Numero Threads</label>
              <input type="number" id="nThreads-new" name="nThreads" min="1" required aria-label="Numero threads" placeholder="Threads">
            </div>
            <div class="popup-field-wrapper">
              <label for="baseFrequence-new" class="visually-hidden">Frequenza Base (GHz)</label>
              <input type="number" id="baseFrequence-new" name="baseFrequence" step="0.01" min="0" required aria-label="Frequenza base in GHz" placeholder="GHz Base">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="turboFrequence-new" class="visually-hidden">Frequenza Turbo (GHz)</label>
              <input type="number" id="turboFrequence-new" name="turboFrequence" step="0.01" min="0" required aria-label="Frequenza turbo in GHz" placeholder="GHz Turbo">
            </div>
            <div class="popup-field-wrapper">
              <label for="TDP-new" class="visually-hidden">TDP (W)</label>
              <input type="number" id="TDP-new" name="TDP" min="0" required aria-label="TDP in Watt" placeholder="Watt">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="litografia-new" class="visually-hidden">Litografia</label>
              <input type="text" id="litografia-new" name="litografia" required aria-label="Litografia" placeholder="Es: 7nm">
            </div>
            <div class="popup-field-wrapper">
              <label for="socket-new" class="visually-hidden">Socket</label>
              <input type="text" id="socket-new" name="socket" required aria-label="Socket" placeholder="Es: AM4, LGA1700">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="memSup-new" class="visually-hidden">Memoria Supportata</label>
              <input type="text" id="memSup-new" name="memSup" required aria-label="Memoria supportata" placeholder="Es: DDR4, DDR5">
            </div>
            <div class="popup-field-wrapper">
              <label for="memFrequence-new" class="visually-hidden">Frequenza Memoria</label>
              <input type="text" id="memFrequence-new" name="memFrequence" required aria-label="Frequenza memoria" placeholder="Es: 3200MHz">
            </div>
          </div>
          <div class="popup-fields-row">
            <div class="popup-field-wrapper">
              <label for="PCIE-new" class="visually-hidden">PCIE</label>
              <input type="text" id="PCIE-new" name="PCIE" required aria-label="PCIE" placeholder="Es: PCIe 4.0">
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
    <h2 class="admin-title">Gestione CPU</h2>
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
                    <th>Famiglia</th>
                    <th>Generazione</th>
                    <th>Core</th>
                    <th>Threads</th>
                    <th>Base Freq. (GHz)</th>
                    <th>Turbo Freq. (GHz)</th>
                    <th>TDP (W)</th>
                    <th>Litografia</th>
                    <th>Socket</th>
                    <th>Mem. Supportata</th>
                    <th>Frequenza Mem.</th>
                    <th>PCIE</th>
                    <th>Immagine</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cpu" items="${cpus}">
                    <tr>
                        <form class="update-form" action="<%=request.getContextPath()%>/updateProduct" method="post">
                            <td><input type="hidden" name="id" value="${cpu.ID}" />${cpu.ID}</td>
                            <td>
                              <label for="marca-${cpu.ID}" class="visually-hidden">Marca</label>
                              <input type="text" id="marca-${cpu.ID}" name="marca" value="${cpu.marca}" aria-label="Marca" />
                            </td>
                            <td>
                              <label for="modello-${cpu.ID}" class="visually-hidden">Modello</label>
                              <input type="text" id="modello-${cpu.ID}" name="modello" value="${cpu.modello}" aria-label="Modello" />
                            </td>
                            <td>
                              <label for="prezzo-${cpu.ID}" class="visually-hidden">Prezzo</label>
                              <input type="number" id="prezzo-${cpu.ID}" name="prezzo" value="${cpu.prezzo}" step="0.01" min="0" aria-label="Prezzo" />
                            </td>
                            <td>
                              <label for="disponibilita-${cpu.ID}" class="visually-hidden">Disponibilità</label>
                              <input type="number" id="disponibilita-${cpu.ID}" name="disponibilita" value="${cpu.disponibilita}" min="0" aria-label="Disponibilità" />
                            </td>
                            <td>
                              <label for="sconto-${cpu.ID}" class="visually-hidden">Sconto</label>
                              <input type="number" id="sconto-${cpu.ID}" name="sconto" value="${cpu.sconto}" min="0" max="100" aria-label="Sconto percentuale" />
                            </td>
                            <td>
                              <label for="famiglia-${cpu.ID}" class="visually-hidden">Famiglia</label>
                              <input type="text" id="famiglia-${cpu.ID}" name="famiglia" value="${cpu.famiglia}" aria-label="Famiglia" />
                            </td>
                            <td>
                              <label for="generazione-${cpu.ID}" class="visually-hidden">Generazione</label>
                              <input type="text" id="generazione-${cpu.ID}" name="generazione" value="${cpu.generazione}" aria-label="Generazione" />
                            </td>
                            <td>
                              <label for="nCore-${cpu.ID}" class="visually-hidden">Core</label>
                              <input type="number" id="nCore-${cpu.ID}" name="nCore" value="${cpu.nCore}" min="1" aria-label="Numero core" />
                            </td>
                            <td>
                              <label for="nThreads-${cpu.ID}" class="visually-hidden">Threads</label>
                              <input type="number" id="nThreads-${cpu.ID}" name="nThreads" value="${cpu.nThreads}" min="1" aria-label="Numero threads" />
                            </td>
                            <td>
                              <label for="baseFrequence-${cpu.ID}" class="visually-hidden">Base Frequency</label>
                              <input type="number" id="baseFrequence-${cpu.ID}" name="baseFrequence" value="${cpu.baseFrequence}" step="0.01" min="0" aria-label="Frequenza base in GHz" />
                            </td>
                            <td>
                              <label for="turboFrequence-${cpu.ID}" class="visually-hidden">Turbo Frequency</label>
                              <input type="number" id="turboFrequence-${cpu.ID}" name="turboFrequence" value="${cpu.turboFrequence}" step="0.01" min="0" aria-label="Frequenza turbo in GHz" />
                            </td>
                            <td>
                              <label for="TDP-${cpu.ID}" class="visually-hidden">TDP</label>
                              <input type="number" id="TDP-${cpu.ID}" name="TDP" value="${cpu.TDP}" min="0" aria-label="TDP in Watt" />
                            </td>
                            <td>
                              <label for="litografia-${cpu.ID}" class="visually-hidden">Litografia</label>
                              <input type="text" id="litografia-${cpu.ID}" name="litografia" value="${cpu.litografia}" aria-label="Litografia" />
                            </td>
                            <td>
                              <label for="socket-${cpu.ID}" class="visually-hidden">Socket</label>
                              <input type="text" id="socket-${cpu.ID}" name="socket" value="${cpu.socket}" aria-label="Socket" />
                            </td>
                            <td>
                              <label for="memSup-${cpu.ID}" class="visually-hidden">Memoria Supportata</label>
                              <input type="text" id="memSup-${cpu.ID}" name="memSup" value="${cpu.memSup}" aria-label="Memoria supportata" />
                            </td>
                            <td>
                              <label for="memFrequence-${cpu.ID}" class="visually-hidden">Frequenza Memoria</label>
                              <input type="text" id="memFrequence-${cpu.ID}" name="memFrequence" value="${cpu.memFrequence}" aria-label="Frequenza memoria" />
                            </td>
                            <td>
                              <label for="PCIE-${cpu.ID}" class="visually-hidden">PCIE</label>
                              <input type="text" id="PCIE-${cpu.ID}" name="PCIE" value="${cpu.PCIE}" aria-label="PCIE" />
                            </td>
                            <td>
                                <c:set var="cpuId" value="${cpu.ID}" scope="request"/>
                                <%
                                    FotoDAO fotoDAO= new FotoDAO();
                                    Object cpuId = request.getAttribute("cpuId");
                                    String imagePath = fotoDAO.getFoto((Integer) cpuId, "fotoPezzi", "CPU", (String) request.getAttribute("path"));
                                %>
                                <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${cpu.marca}_${cpu.modello}" width="80">
                            </td>
                            <td>
                                <input type="hidden" name="piece" value="pezzo" />
                                <input type="hidden" name="type" value="cpu" />
                                <button type="submit" class="admin-btn aggiorna-btn">Aggiorna</button>
                                <button type="button" class="admin-btn delete" name="delete">Elimina</button>
                                <div class="error-message" style="color:red; font-size:0.9em; margin-top:4px;"></div>
                            </td>
                        </form>
                        <td colspan="20" style="padding:0; border:none;">
                            <form action="<%=request.getContextPath()%>/updateFotoProduct" method="post" enctype="multipart/form-data" style="margin-top:8px; display:inline-block;">
                                <input type="hidden" name="id" value="${cpu.ID}" />
                                <input type="hidden" name="category" value="fotoPezzi" />
                                <input type="hidden" name="name" value="CPU" />
                                <label for="foto-upload-${cpu.ID}" class="visually-hidden">Carica foto</label>
                                <input type="file" id="foto-upload-${cpu.ID}" name="foto" accept="image/*" style="margin-bottom:4px;" required aria-label="Carica nuova foto" />
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
        type.value = 'cpu';
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
        document.getElementById("form-nuovo-cpu").addEventListener("submit", newProduct);
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
        document.getElementById('popup-nuovo-cpu').style.display = 'flex';
    }

    function closePopup() {
        document.getElementById('popup-nuovo-cpu').style.display = 'none';
    }
</script>
</html>
