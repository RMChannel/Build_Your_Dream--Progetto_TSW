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
            <h3>Categoria</h3>
            <div class="filter-item">
                <select id="categoriaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${categorie}" var="categoria">
                        <option value="${categoria}">${categoria}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Connettività</h3>
            <div class="filter-item">
                <select id="connettivitaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${connectivies}" var="conn">
                        <option value="${conn}">${conn}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Microfono</h3>
            <div class="filter-item">
                <select id="microfonoFilter">
                    <option value="">Tutti</option>
                    <option value="true">Con microfono</option>
                    <option value="false">Senza microfono</option>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>LED</h3>
            <div class="filter-item">
                <select id="ledFilter">
                    <option value="">Tutti</option>
                    <option value="true">Si</option>
                    <option value="false">No</option>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Prezzo</h3>
            <div class="filter-item price-range">
                <input type="number" id="minPrice" placeholder="Min €" min="0">
                <span>-</span>
                <input type="number" id="maxPrice" placeholder="Max €" min="0">
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

    <div class="table-section">
        <h2 style="padding: 20px 20px 0">Elenco <%=request.getAttribute("table")%></h2>
        <table id="headset-table" class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Categoria</th>
                <th>Connettività</th>
                <th>Microfono</th>
                <th>LED</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${headsets}" var="headset">
                <c:set var="prezzoClass" value="${headset.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <tr class="product-row" 
                    data-sconto="${headset.sconto}" 
                    data-disponibile="${headset.disponibilita>0 ? 'true' : 'false'}" 
                    data-microfono="${headset.microfono}"
                    data-led="${headset.led}">
                    <td class="headset-image">
                        <c:set var="headsetId" value="${headset.ID}" scope="request"/>
                        <%
                            FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                            Object headsetId = request.getAttribute("headsetId");
                            String imagePath = fotoDAO.getFoto((Integer) headsetId, "fotoAccessori", "HeadSet", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${headset.marca}_${headset.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'HeadSet', '${headset.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'HeadSet', '${headset.ID}')">
</td>
                    <td class="headset-marca">${headset.marca}</td>
                    <td class="headset-modello">${headset.modello}</td>
                    <td class="headset-categoria">${headset.categoria}</td>
                    <td class="headset-connettivita">${headset.connectionType}</td>
                    <td class="headset-microfono">${headset.microfono ? 'Si' : 'No'}</td>
                    <td class="headset-led">${headset.led ? 'Si' : 'No'}</td>
                    <td class="${prezzoClass}">
                        <c:if test="${headset.sconto>0}">
                            <span class="prezzo-originale">${Math.round(headset.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${headset.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.floor((headset.prezzoScontato)*100)/100}€</span>
                    </td>
                    <td class="headset-actions">
                        <c:set var="button" value="${headset.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                        <c:set var="buttonDisabled" value="${headset.disponibilita>0 ? '':'disabled'}"/>
                        <button class="acquista" onclick="acquista('${headset.ID}')">Aggiungi al carrello</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const totalRows = document.querySelectorAll('.data-table tbody tr').length;
        let visibleRows = totalRows;
        
        function applyFilters() {
            const marcaFilter = document.getElementById('marcaFilter').value;
            const categoriaFilter = document.getElementById('categoriaFilter').value;
            const connettivitaFilter = document.getElementById('connettivitaFilter').value;
            const microfonoFilter = document.getElementById('microfonoFilter').value;
            const ledFilter = document.getElementById('ledFilter').value;
            const minPrice = parseFloat(document.getElementById('minPrice').value) || 0;
            const maxPrice = parseFloat(document.getElementById('maxPrice').value) || Infinity;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;
            
            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;
            
            rows.forEach(row => {
                const marca = row.querySelector('.headset-marca').textContent.trim();
                const categoria = row.querySelector('.headset-categoria').textContent.trim();
                const connettivita = row.querySelector('.headset-connettivita').textContent.trim();
                const microfono = row.querySelector('.headset-microfono').textContent === 'Si';
                const led = row.querySelector('.headset-led').textContent === 'Si';
                const prezzoElement = row.querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const disponibile = row.getAttribute('data-disponibile') === 'true';
                const inSconto = parseFloat(row.getAttribute('data-sconto')) > 0;

                let matchStato = true;
                if (statoFilter === 'disponibile' && !disponibile) matchStato = false;
                if (statoFilter === 'non-disponibile' && disponibile) matchStato = false;

                let matchSconto = true;
                if (scontoFilter === 'in-sconto' && !inSconto) matchSconto = false;
                if (scontoFilter === 'no-sconto' && inSconto) matchSconto = false;

                let matchMicrofono = true;
                if (microfonoFilter === 'true' && !microfono) matchMicrofono = false;
                if (microfonoFilter === 'false' && microfono) matchMicrofono = false;

                let matchLed = true;
                if (ledFilter === 'true' && !led) matchLed = false;
                if (ledFilter === 'false' && led) matchLed = false;

                const isVisible = 
                    (marcaFilter === '' || marca === marcaFilter) &&
                    (categoriaFilter === '' || categoria === categoriaFilter) &&
                    (connettivitaFilter === '' || connettivita === connettivitaFilter) &&
                    matchMicrofono &&
                    matchLed &&
                    matchStato &&
                    matchSconto &&
                    prezzo >= minPrice && prezzo <= maxPrice;
    
                row.style.display = isVisible ? '' : 'none';
                if (isVisible) visibleRows++;
            });
        }

        document.getElementById('resetFilters').addEventListener('click', function() {
            document.getElementById('marcaFilter').value = '';
            document.getElementById('categoriaFilter').value = '';
            document.getElementById('connettivitaFilter').value = '';
            document.getElementById('microfonoFilter').value = '';
            document.getElementById('ledFilter').value = '';
            document.getElementById('minPrice').value = '';
            document.getElementById('maxPrice').value = '';
            document.getElementById('statoFilter').value = '';
            document.getElementById('scontoFilter').value = '';

            applyFilters();
        });

        document.getElementById('marcaFilter').addEventListener('change', applyFilters);
        document.getElementById('categoriaFilter').addEventListener('change', applyFilters);
        document.getElementById('connettivitaFilter').addEventListener('change', applyFilters);
        document.getElementById('microfonoFilter').addEventListener('change', applyFilters);
        document.getElementById('ledFilter').addEventListener('change', applyFilters);
        document.getElementById('minPrice').addEventListener('input', applyFilters);
        document.getElementById('maxPrice').addEventListener('input', applyFilters);
        document.getElementById('statoFilter').addEventListener('change', applyFilters);
        document.getElementById('scontoFilter').addEventListener('change', applyFilters);
    });
    function adjustTableForMobile() {
        const isMobile = window.innerWidth <= 768;

        const columnsToHide = [1, 2, 3, 4, 5, 6]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('headset-table');

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