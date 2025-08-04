<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Foto.FotoDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/tableStyle.css">

<div class="data-container">
    <div class="filter-section">
        <h2>Filtri</h2>
        <div class="filter-group">
            <h3>Marca</h3>
            <div class="filter-item">
                <select id="marcaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${marche}" var="marca">
                        <option value="${marca}">${marca}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Tipo di connessione</h3>
            <div class="filter-item">
                <select id="connectionFilter">
                    <option value="">Tutti</option>
                    <c:forEach items="${connectionTypes}" var="connection">
                        <option value="${connection}">${connection}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Numero di tasti</h3>
            <div class="filter-item price-range">
                <input type="number" id="minTasti" placeholder="Min" min="0">
                <span>-</span>
                <input type="number" id="maxTasti" placeholder="Max" min="0">
            </div>
        </div>

        <div class="filter-group">
            <h3>Tipo di tasti</h3>
            <div class="filter-options">
                <c:forEach items="${tipiTasti}" var="tipo">
                    <div class="checkbox-item">
                        <input type="checkbox" id="tipo-${tipo}" name="tipo" value="${tipo}">
                        <label for="tipo-${tipo}">${tipo}</label>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="filter-group">
            <h3>Stato</h3>
            <div class="filter-item">
                <select id="statoFilter">
                    <option value="">Tutti</option>
                    <option value="disponibile">Disponibile</option>
                    <option value="non-disponibile">Non disponibile</option>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Offerte</h3>
            <div class="filter-item">
                <select id="scontoFilter">
                    <option value="">Tutti</option>
                    <option value="in-sconto">In sconto</option>
                    <option value="no-sconto">Prezzo pieno</option>
                </select>
            </div>
        </div>

        <div class="filter-actions">
            <button id="resetFilters" class="btn btn-secondary">Reimposta Filtri</button>
        </div>
    </div>

    <div class="table-section" id="streemdeck-table">
        <h2 style="padding: 20px 20px 0">Elenco Stream Deck</h2>
        <div class="filtered-count"></div>
        <table class="data-table">
            <thead>
            <tr>
                <th onclick="sortTable(0)">Immagine</th>
                <th onclick="sortTable(1)">Marca</th>
                <th onclick="sortTable(2)">Modello</th>
                <th onclick="sortTable(3)">Num. Tasti</th>
                <th onclick="sortTable(4)">Tipo Tasti</th>
                <th onclick="sortTable(5)">Connessione</th>
                <th onclick="sortTable(6)">Dimensioni (L×P)</th>
                <th onclick="sortTable(7)">Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
        <tbody>
        <c:forEach items="${streamDecks}" var="streamDeck">
            <tr data-marca="${streamDeck.marca}" data-tasti="${streamDeck.nTasti}" data-tipotasti="${streamDeck.tipoTasti}" data-connection="${streamDeck.connectionType}" data-disponibile="${streamDeck.disponibilita > 0 ? 'true' : 'false'}" data-sconto="${streamDeck.sconto}">
                <td class="streamdeck-image">
                    <c:set var="streamDeckId" value="${streamDeck.ID}" scope="request"/>
                    <%
                        FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                        Object streamDeckId = request.getAttribute("streamDeckId");
                        String imagePath = fotoDAO.getFoto((Integer) streamDeckId, "fotoAccessori", "StreamDeck", (String) request.getAttribute("path"));
                    %>
                    <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${streamDeck.marca}_${streamDeck.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'StreamDeck', '${streamDeck.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'StreamDeck', '${streamDeck.ID}')">
                </td>
                <td>${streamDeck.marca}</td>
                <td>${streamDeck.modello}</td>
                <td>${streamDeck.nTasti}</td>
                <td>${streamDeck.tipoTasti}</td>
                <td>${streamDeck.connectionType}</td>
                <td>${streamDeck.lunghezza} × ${streamDeck.larghezza} cm</td>
                <td class="${streamDeck.sconto > 0 ? 'prezzo-scontato' : ''}">
                    <c:if test="${streamDeck.sconto>0}">
                        <span class="prezzo-originale">${Math.round(streamDeck.prezzo*100)/100}€</span>
                        <span class="sconto-badge">-${streamDeck.sconto}%</span>
                    </c:if>
                    <span class="prezzo-finale">${Math.floor((streamDeck.prezzoScontato)*100)/100}€</span>
                </td>
                <td>
                    <c:set var="button" value="${streamDeck.disponibilita > 0 ? 'Aggiungi al carrello' : 'SOLD OUT'}"/>
                    <c:set var="buttonDisabled" value="${streamDeck.disponibilita > 0 ? '' : 'disabled'}"/>
                    <button name="acquista" class="acquista ${buttonDisabled}" type="button" onclick="acquista(${streamDeck.ID},'accessori','streamdeck')" ${buttonDisabled}>${button}</button>
                </td>
            </tr>
        </c:forEach>
            </tbody>
                    </table>
                </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const selectElements = [
            document.getElementById('marcaFilter'),
            document.getElementById('connectionFilter'),
            document.getElementById('statoFilter'),
            document.getElementById('scontoFilter')
        ];

        selectElements.forEach(select => {
            select.addEventListener('change', applyFilters);
        });

        document.querySelectorAll('input[name="tipo"]').forEach(function(checkbox) {
            checkbox.addEventListener('change', applyFilters);
        });

        document.getElementById('minTasti').addEventListener('input', applyFilters);
        document.getElementById('maxTasti').addEventListener('input', applyFilters);

        document.getElementById('resetFilters').addEventListener('click', resetFilters);
    });

    function applyFilters() {
        const marcaSelezionata = document.getElementById('marcaFilter').value;
        const connectionSelezionata = document.getElementById('connectionFilter').value;
        const tipiSelezionati = Array.from(document.querySelectorAll('input[name="tipo"]:checked')).map(el => el.value);
        const statoFilter = document.getElementById('statoFilter').value;
        const scontoFilter = document.getElementById('scontoFilter').value;

        const minTasti = parseInt(document.getElementById('minTasti').value) || 0;
        const maxTasti = parseInt(document.getElementById('maxTasti').value) || Infinity;

        const rows = document.querySelectorAll('.data-table tbody tr');
        let visibleRows = 0;
    
        rows.forEach(function(row) {
            let shouldShow = true;
    
            if (marcaSelezionata && row.getAttribute('data-marca') !== marcaSelezionata) {
                shouldShow = false;
            }
    
            if (connectionSelezionata && row.getAttribute('data-connection') !== connectionSelezionata) {
                shouldShow = false;
            }
            
            if (tipiSelezionati.length > 0) {
                const tipiTastiProdotto = row.cells[4].textContent.trim();
                for(let i = 0; i < tipiSelezionati.length; i++) {
                    if (tipiTastiProdotto.indexOf(tipiSelezionati[i]) === -1) {
                        shouldShow = false;
                        break;
                    }
                }
            }
            
            const nTasti = parseInt(row.getAttribute('data-tasti'));
            if (nTasti < minTasti || (maxTasti !== Infinity && nTasti > maxTasti)) {
                shouldShow = false;
            }
            
            const isDisponibile = row.getAttribute('data-disponibile') === 'true';
            const matchesStato = statoFilter === '' ||
                (statoFilter === 'disponibile' && isDisponibile) ||
                (statoFilter === 'non-disponibile' && !isDisponibile);
            if (!matchesStato) {
                shouldShow = false;
            }
            
            const sconto = parseInt(row.getAttribute('data-sconto')) || 0;
            const matchesSconto = scontoFilter === '' ||
                (scontoFilter === 'in-sconto' && sconto > 0) ||
                (scontoFilter === 'no-sconto' && sconto === 0);
            if (!matchesSconto) {
                shouldShow = false;
            }
    
            row.style.display = shouldShow ? '' : 'none';
            
            if (shouldShow) {
                visibleRows++;
            }
        });
    }

    function resetFilters() {
        document.getElementById('marcaFilter').value = '';
        document.getElementById('connectionFilter').value = '';
        document.getElementById('statoFilter').value = '';
        document.getElementById('scontoFilter').value = '';
    
        document.querySelectorAll('input[name="tipo"]').forEach(function(checkbox) {
            checkbox.checked = false;
        });

        document.getElementById('minTasti').value = '';
        document.getElementById('maxTasti').value = '';
    
        const rows = document.querySelectorAll('.data-table tbody tr');
        rows.forEach(row => {
            row.style.display = '';
        });
    }

    function sortTable(n) {
        var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
        table = document.querySelector(".data-table");
        switching = true;
        dir = "asc";
        
        while (switching) {
            switching = false;
            rows = table.rows;
            
            for (i = 1; i < (rows.length - 1); i++) {
                shouldSwitch = false;
                x = rows[i].getElementsByTagName("TD")[n];
                y = rows[i + 1].getElementsByTagName("TD")[n];
                
                if (n === 0 || n === 8) {
                    shouldSwitch = false;
                    break;
                }
                
                if (dir == "asc") {
                    if (x.innerText.toLowerCase() > y.innerText.toLowerCase()) {
                        shouldSwitch = true;
                        break;
                    }
                } else if (dir == "desc") {
                    if (x.innerText.toLowerCase() < y.innerText.toLowerCase()) {
                        shouldSwitch = true;
                        break;
                    }
                }
            }
            
            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                switchcount++;
            } else {
                if (switchcount == 0 && dir == "asc") {
                    dir = "desc";
                    switching = true;
                }
            }
        }
    }
    function adjustTableForMobile() {
        const isMobile = window.innerWidth <= 768;

        const columnsToHide = [1, 2, 3, 4, 5, 6]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('streemdeck-table');

        if (!table) return;

        const rows = table.querySelectorAll('tr');

        rows.forEach(row => {
            const cells = Array.from(row.children);
            columnsToHide.forEach(index => {
                if (cells[index]) {
                    cells[index].style.display = isMobile ? 'none' : '';
                }
            });
        });
    }

    // Esegui al primo caricamento
    adjustTableForMobile();

    // Esegui anche ogni volta che la finestra viene ridimensionata
    window.addEventListener('resize', adjustTableForMobile);

</script>
