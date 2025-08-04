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
            <h3>Dimensioni</h3>
            <div class="filter-item">
                <select id="dimensioniFilter">
                    <option value="">Tutte</option>
                    <option value="piccolo">Piccolo (< 30cm larghezza)</option>
                    <option value="medio">Medio (30-45cm larghezza)</option>
                    <option value="grande">Grande (> 45cm larghezza)</option>
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
        
        <!-- Filtro per Stato -->
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
        <table id="tappetino-table" class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>LED</th>
                <th>Dimensioni</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tappetini}" var="tappetino">
                <c:set var="prezzoClass" value="${tappetino.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <tr class="product-row" 
                    data-sconto="${tappetino.sconto}" 
                    data-disponibile="${tappetino.disponibilita>0 ? 'true' : 'false'}" 
                    data-led="${tappetino.led}">
                    <td class="tappetino-image">
                        <c:set var="tappetinoId" value="${tappetino.ID}" scope="request"/>
                        <%
                            FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                            Object tappetinoId = request.getAttribute("tappetinoId");
                            String imagePath = fotoDAO.getFoto((Integer) tappetinoId, "fotoAccessori", "Tappetini", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${tappetino.marca}_${tappetino.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Tappetino', '${tappetino.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Tappetino', '${tappetino.ID}')">
                    </td>
                    <td class="tappetino-marca">${tappetino.marca}</td>
                    <td class="tappetino-modello">${tappetino.modello}</td>
                    <td class="tappetino-led">${tappetino.led ? 'Si' : 'No'}</td>
                    <td class="tappetino-dimensioni">${tappetino.larghezza}x${tappetino.lunghezza}cm</td>
                    <td class="${prezzoClass}">
                        <c:if test="${tappetino.sconto>0}">
                            <span class="prezzo-originale">${Math.round(tappetino.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${tappetino.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.floor((tappetino.prezzoScontato)*100)/100}€</span>
                    </td>
                    <td class="tappetino-actions">
                        <c:set var="button" value="${tappetino.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                        <c:set var="buttonDisabled" value="${tappetino.disponibilita>0 ? '':'disabled'}"/>
                        <button class="acquista" onclick="acquista('${tappetino.ID}')">Aggiungi al carrello</button>
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
            const ledFilter = document.getElementById('ledFilter').value;
            const dimensioniFilter = document.getElementById('dimensioniFilter').value;
            const minPrice = parseFloat(document.getElementById('minPrice').value) || 0;
            const maxPrice = parseFloat(document.getElementById('maxPrice').value) || Infinity;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;
    
            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;
    
            rows.forEach(row => {
                const marca = row.querySelector('.tappetino-marca').textContent.trim();
                const led = row.getAttribute('data-led') === 'true';
                const dimensioniEl = row.querySelector('.tappetino-dimensioni').textContent.trim();
                const larghezza = parseFloat(dimensioniEl.split('x')[0]);
                const prezzoElement = row.querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;
    
                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesLed = ledFilter === '' || 
                                  (ledFilter === 'true' && led) || 
                                  (ledFilter === 'false' && !led);
                
                const matchesDimensioni = dimensioniFilter === '' || 
                                        (dimensioniFilter === 'piccolo' && larghezza < 30) ||
                                        (dimensioniFilter === 'medio' && larghezza >= 30 && larghezza <= 45) ||
                                        (dimensioniFilter === 'grande' && larghezza > 45);
                
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                
                const matchesStato = statoFilter === '' ||
                                    (statoFilter === 'disponibile' && isDisponibile) ||
                                    (statoFilter === 'non-disponibile' && !isDisponibile);
                
                const matchesSconto = scontoFilter === '' ||
                                     (scontoFilter === 'in-sconto' && sconto > 0) ||
                                     (scontoFilter === 'no-sconto' && sconto === 0);
    
                if (matchesMarca && matchesLed && matchesDimensioni && matchesPrezzo && matchesStato && matchesSconto) {
                    row.style.display = '';
                    visibleRows++;
                } else {
                    row.style.display = 'none';
                }
            });
        }
    
        function resetFilters() {
            document.getElementById('marcaFilter').value = '';
            document.getElementById('ledFilter').value = '';
            document.getElementById('dimensioniFilter').value = '';
            document.getElementById('minPrice').value = '';
            document.getElementById('maxPrice').value = '';
            document.getElementById('statoFilter').value = '';
            document.getElementById('scontoFilter').value = '';
    
            const rows = document.querySelectorAll('.data-table tbody tr');
            rows.forEach(row => {
                row.style.display = '';
            });
    
            visibleRows = totalRows;
        }
        
        document.getElementById('marcaFilter').addEventListener('change', applyFilters);
        document.getElementById('ledFilter').addEventListener('change', applyFilters);
        document.getElementById('dimensioniFilter').addEventListener('change', applyFilters);
        document.getElementById('minPrice').addEventListener('input', applyFilters);
        document.getElementById('maxPrice').addEventListener('input', applyFilters);
        document.getElementById('statoFilter').addEventListener('change', applyFilters);
        document.getElementById('scontoFilter').addEventListener('change', applyFilters);
        document.getElementById('resetFilters').addEventListener('click', resetFilters);
    });
    function adjustTableForMobile() {
        const isMobile = window.innerWidth <= 768;

        const columnsToHide = [1, 2, 3, 4]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('tappetino-table');

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
