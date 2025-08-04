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
            <h3>Dimensione</h3>
            <div class="filter-item price-range">
                <input type="number" id="minDimensione" placeholder="Min inch" min="0">
                <span>-</span>
                <input type="number" id="maxDimensione" placeholder="Max inch" min="0">
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Risoluzione</h3>
            <div class="filter-item">
                <select id="risoluzioneFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${risoluzioni}" var="risoluzione">
                        <option value="${risoluzione}">${risoluzione}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Aspect Ratio</h3>
            <div class="filter-item">
                <select id="aspectRatioFilter">
                    <option value="">Tutti</option>
                    <c:forEach items="${aspectRatios}" var="aspectRatio">
                        <option value="${aspectRatio}">${aspectRatio}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Tipo Pannello</h3>
            <div class="filter-item">
                <select id="tipoFilter">
                    <option value="">Tutti</option>
                    <c:forEach items="${tipi}" var="tipo">
                        <option value="${tipo}">${tipo}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Frequenza</h3>
            <div class="filter-item">
                <select id="frequenzaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${frequenze}" var="frequenza">
                        <option value="${frequenza}">${frequenza}Hz</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>HDR</h3>
            <div class="filter-item">
                <select id="hdrFilter">
                    <option value="">Tutti</option>
                    <option value="true">Sì</option>
                    <option value="false">No</option>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Casse integrate</h3>
            <div class="filter-item">
                <select id="casseFilter">
                    <option value="">Tutti</option>
                    <option value="true">Sì</option>
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
        <table id="monitor-table" class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Dimensione</th>
                <th>Risoluzione</th>
                <th>Aspect Ratio</th>
                <th>Tipo Pannello</th>
                <th>Response Time</th>
                <th>Frequenza</th>
                <th>HDR</th>
                <th>Casse</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${monitors}" var="monitor">
                <c:set var="prezzoClass" value="${monitor.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <tr class="product-row" 
                    data-sconto="${monitor.sconto}" 
                    data-disponibile="${monitor.disponibilita>0 ? 'true' : 'false'}" 
                    data-hdr="${monitor.hdr}"
                    data-casse="${monitor.casse}">
                    <td class="monitor-image">
                        <c:set var="monitorId" value="${monitor.ID}" scope="request"/>
                        <%
                            FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                            Object monitorId = request.getAttribute("monitorId");
                            String imagePath = fotoDAO.getFoto((Integer) monitorId, "fotoAccessori", "Monitor", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${monitor.marca}_${monitor.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Monitor', '${monitor.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Monitor', '${monitor.ID}')">
                    </td>
                    <td class="monitor-marca">${monitor.marca}</td>
                    <td class="monitor-modello">${monitor.modello}</td>
                    <td class="monitor-dimensione">${monitor.dimensione}"</td>
                    <td class="monitor-risoluzione">${monitor.risoluzione}</td>
                    <td class="monitor-aspectratio">${monitor.aspectRatio}</td>
                    <td class="monitor-tipo">${monitor.tipo}</td>
                    <td class="monitor-responsetime">${monitor.responseTime}ms</td>
                    <td class="monitor-frequenza">${monitor.frequenza}Hz</td>
                    <td class="monitor-hdr">${monitor.hdr ? 'Sì' : 'No'}</td>
                    <td class="monitor-casse">${monitor.casse ? 'Sì' : 'No'}</td>
                    <td class="${prezzoClass}">
                        <c:if test="${monitor.sconto>0}">
                            <span class="prezzo-originale">${Math.round(monitor.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${monitor.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.floor((monitor.prezzoScontato)*100)/100}€</span>
                    </td>
                    <td class="monitor-actions">
                        <c:set var="button" value="${monitor.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                        <c:set var="buttonDisabled" value="${monitor.disponibilita>0 ? '':'disabled'}"/>
                        <button class="acquista" onclick="acquista('${monitor.ID}')">Aggiungi al carrello</button>
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
            const minDimensione = parseFloat(document.getElementById('minDimensione').value) || 0;
            const maxDimensione = parseFloat(document.getElementById('maxDimensione').value) || Infinity;
            const risoluzioneFilter = document.getElementById('risoluzioneFilter').value;
            const aspectRatioFilter = document.getElementById('aspectRatioFilter').value;
            const tipoFilter = document.getElementById('tipoFilter').value;
            const frequenzaFilter = document.getElementById('frequenzaFilter').value;
            const hdrFilter = document.getElementById('hdrFilter').value;
            const casseFilter = document.getElementById('casseFilter').value;
            const minPrice = parseFloat(document.getElementById('minPrice').value) || 0;
            const maxPrice = parseFloat(document.getElementById('maxPrice').value) || Infinity;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;
    
            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;
    
            rows.forEach(row => {
                const marca = row.querySelector('.monitor-marca').textContent.trim();
                const dimensione = parseInt(row.querySelector('.monitor-dimensione').textContent);
                const risoluzione = row.querySelector('.monitor-risoluzione').textContent.trim();
                const aspectRatio = row.querySelector('.monitor-aspectratio').textContent.trim();
                const tipo = row.querySelector('.monitor-tipo').textContent.trim();
                const frequenza = parseInt(row.querySelector('.monitor-frequenza').textContent);
                const hdr = row.querySelector('.monitor-hdr').textContent === 'Sì';
                const casse = row.querySelector('.monitor-casse').textContent === 'Sì';
                const prezzoElement = row.querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;
    
                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesDimensione = dimensione >= minDimensione && (maxDimensione === Infinity || dimensione <= maxDimensione);
                
                const matchesRisoluzione = risoluzioneFilter === '' || risoluzione === risoluzioneFilter;
                const matchesAspectRatio = aspectRatioFilter === '' || aspectRatio === aspectRatioFilter;
                const matchesTipo = tipoFilter === '' || tipo === tipoFilter;
                const matchesFrequenza = frequenzaFilter === '' || frequenza === parseInt(frequenzaFilter);
                
                const matchesHDR = hdrFilter === '' || (hdrFilter === 'true' && hdr) || (hdrFilter === 'false' && !hdr);
                const matchesCasse = casseFilter === '' || (casseFilter === 'true' && casse) || (casseFilter === 'false' && !casse);
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                const matchesStato = statoFilter === '' ||
                    (statoFilter === 'disponibile' && isDisponibile) ||
                    (statoFilter === 'non-disponibile' && !isDisponibile);
                const matchesSconto = scontoFilter === '' ||
                    (scontoFilter === 'in-sconto' && sconto > 0) ||
                    (scontoFilter === 'no-sconto' && sconto === 0);
    
                if (matchesMarca && matchesDimensione && matchesRisoluzione && matchesAspectRatio && matchesTipo && 
                    matchesFrequenza && matchesHDR && matchesCasse && matchesPrezzo && matchesStato && matchesSconto) {
                    row.style.display = '';
                    visibleRows++;
                } else {
                    row.style.display = 'none';
                }
            });
        }
    
        function resetFilters() {
            document.getElementById('marcaFilter').value = '';
            document.getElementById('minDimensione').value = '';
            document.getElementById('maxDimensione').value = '';
            document.getElementById('risoluzioneFilter').value = '';
            document.getElementById('aspectRatioFilter').value = '';
            document.getElementById('tipoFilter').value = '';
            document.getElementById('frequenzaFilter').value = '';
            document.getElementById('hdrFilter').value = '';
            document.getElementById('casseFilter').value = '';
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
    
        document.getElementById('minPrice').addEventListener('input', applyFilters);
        document.getElementById('maxPrice').addEventListener('input', applyFilters);
        document.getElementById('minDimensione').addEventListener('input', applyFilters);
        document.getElementById('maxDimensione').addEventListener('input', applyFilters);
    
        const selectElements = [
            document.getElementById('marcaFilter'),
            document.getElementById('risoluzioneFilter'),
            document.getElementById('aspectRatioFilter'),
            document.getElementById('tipoFilter'),
            document.getElementById('frequenzaFilter'),
            document.getElementById('hdrFilter'),
            document.getElementById('casseFilter'),
            document.getElementById('statoFilter'),
            document.getElementById('scontoFilter')
        ];
    
        selectElements.forEach(select => {
            select.addEventListener('change', applyFilters);
        });
    
        document.getElementById('resetFilters').addEventListener('click', resetFilters);
    });
    
    function openImagePopup(imageSrc, title) {
        const popup = document.createElement('div');
        popup.className = 'image-popup';
        popup.innerHTML = `
            <div class="popup-content">
                <span class="close-popup">&times;</span>
                <h3>${title}</h3>
                <img src="${imageSrc}" alt="${title}">
            </div>
        `;
        document.body.appendChild(popup);
        
        popup.querySelector('.close-popup').addEventListener('click', () => {
            document.body.removeChild(popup);
        });
        
        popup.addEventListener('click', (e) => {
            if (e.target === popup) {
                document.body.removeChild(popup);
            }
        });
    }
    function adjustTableForMobile() {
        const isMobile = window.innerWidth <= 768;

        const columnsToHide = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('monitor-table');

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