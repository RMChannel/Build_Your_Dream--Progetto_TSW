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
            <h3>Connessione</h3>
            <div class="filter-item">
                <select id="connectionFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${connections}" var="connection">
                        <option value="${connection}">${connection}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Forma</h3>
            <div class="filter-item">
                <select id="formaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${forme}" var="forma">
                        <option value="${forma}">${forma}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>DPI</h3>
            <div class="filter-item">
                <select id="dpiFilter">
                    <option value="">Tutti</option>
                    <option value="1000">< 1000</option>
                    <option value="5000">1000-5000</option>
                    <option value="10000">5000-10000</option>
                    <option value="max">> 10000</option>
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
            <h3>Peso</h3>
            <div class="filter-item">
                <select id="pesoFilter">
                    <option value="">Tutti</option>
                    <option value="leggero">< 80g</option>
                    <option value="medio">80-120g</option>
                    <option value="pesante">> 120g</option>
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
        
        <!-- Filtro per Sconti -->
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

    <!-- Sezione Tabella -->
    <div class="table-section">
        <h2 style="padding: 20px 20px 0">Elenco <%=request.getAttribute("table")%></h2>
        <div class="filtered-count"></div>
        <table id="mouse-table" class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Categoria</th>
                <th>Connessione</th>
                <th>Forma</th>
                <th>Sensore</th>
                <th>DPI</th>
                <th>Peso</th>
                <th>LED</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${mouseList}" var="mouse">
                <c:set var="prezzoClass" value="${mouse.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <tr class="product-row" data-sconto="${mouse.sconto}" data-disponibile="${mouse.disponibilita>0 ? 'true' : 'false'}">
                    <td class="mouse-image">
                        <c:set var="mouseId" value="${mouse.ID}" scope="request"/>
                        <%
                            FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                            Object mouseId = request.getAttribute("mouseId");
                            String imagePath = fotoDAO.getFoto((Integer) mouseId, "fotoAccessori", "Mouse", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${mouse.marca}_${mouse.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Mouse', '${mouse.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Mouse', '${mouse.ID}')">
                    </td>
                <td class="mouse-marca">${mouse.marca}</td>
                <td class="mouse-modello">${mouse.modello}</td>
                <td class="mouse-categoria">${mouse.categoria}</td>
                <td class="mouse-connection">${mouse.connectionType}</td>
                <td class="mouse-forma">${mouse.forma}</td>
                <td class="mouse-sensore">${mouse.sensore}</td>
                <td class="mouse-dpi">${mouse.DPI}</td>
                <td class="mouse-peso">${mouse.peso}g</td>
                <td class="mouse-led">${mouse.led ? 'Si' : 'No'}</td>
                <td class="${prezzoClass}">
                    <c:if test="${mouse.sconto>0}">
                        <span class="prezzo-originale">${Math.round(mouse.prezzo*100)/100}€</span>
                        <span class="sconto-badge">-${mouse.sconto}%</span>
                    </c:if>
                    <span class="prezzo-finale">${Math.floor((mouse.prezzoScontato)*100)/100}€</span>
                </td>
                <td class="mouse-actions">
                    <c:set var="button" value="${mouse.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                    <c:set var="buttonDisabled" value="${mouse.disponibilita>0 ? '':'disabled'}"/>
                    <button class="acquista" onclick="acquista('${mouse.ID}')">Aggiungi al carrello</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const totalRows = document.querySelectorAll('.data-table tbody tr').length;
        let visibleRows = totalRows;
        
        function applyFilters() {
            const marcaFilter = document.getElementById('marcaFilter').value;
            const categoriaFilter = document.getElementById('categoriaFilter').value;
            const connectionFilter = document.getElementById('connectionFilter').value;
            const formaFilter = document.getElementById('formaFilter').value;
            const dpiFilter = document.getElementById('dpiFilter').value;
            const ledFilter = document.getElementById('ledFilter').value;
            const pesoFilter = document.getElementById('pesoFilter').value;
            const minPrice = parseFloat(document.getElementById('minPrice').value) || 0;
            const maxPrice = parseFloat(document.getElementById('maxPrice').value) || Infinity;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;
    
            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;
    
            rows.forEach(row => {
                const marca = row.querySelector('.mouse-marca').textContent.trim();
                const categoria = row.querySelector('.mouse-categoria').textContent.trim();
                const connection = row.querySelector('.mouse-connection').textContent.trim();
                const forma = row.querySelector('.mouse-forma').textContent.trim();
                const dpi = parseInt(row.querySelector('.mouse-dpi').textContent);
                const led = row.querySelector('.mouse-led').textContent === 'Si';
                const peso = parseFloat(row.querySelector('.mouse-peso').textContent);
                const prezzoElement = row.querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;
                
                let isVisible = true;
                
                if (marcaFilter !== '' && marca !== marcaFilter) {
                    isVisible = false;
                }

                if (categoriaFilter !== '' && categoria !== categoriaFilter) {
                    isVisible = false;
                }

                if (connectionFilter !== '' && connection !== connectionFilter) {
                    isVisible = false;
                }

                if (formaFilter !== '' && forma !== formaFilter) {
                    isVisible = false;
                }

                if (dpiFilter !== '') {
                    let dpiMatch = false;
                    if (dpiFilter === '1000' && dpi < 1000) dpiMatch = true;
                    if (dpiFilter === '5000' && dpi >= 1000 && dpi <= 5000) dpiMatch = true;
                    if (dpiFilter === '10000' && dpi > 5000 && dpi <= 10000) dpiMatch = true;
                    if (dpiFilter === 'max' && dpi > 10000) dpiMatch = true;
                    if (!dpiMatch) isVisible = false;
                }

                if (ledFilter !== '') {
                    const ledValue = led ? 'true' : 'false';
                    if (ledValue !== ledFilter) {
                        isVisible = false;
                    }
                }

                if (pesoFilter !== '') {
                    let pesoMatch = false;
                    if (pesoFilter === 'leggero' && peso < 80) pesoMatch = true;
                    if (pesoFilter === 'medio' && peso >= 80 && peso <= 120) pesoMatch = true;
                    if (pesoFilter === 'pesante' && peso > 120) pesoMatch = true;
                    if (!pesoMatch) isVisible = false;
                }

                if (prezzo < minPrice || (maxPrice !== Infinity && prezzo > maxPrice)) {
                    isVisible = false;
                }

                if (statoFilter !== '') {
                    if ((statoFilter === 'disponibile' && !isDisponibile) || 
                        (statoFilter === 'non-disponibile' && isDisponibile)) {
                        isVisible = false;
                    }
                }

                if (scontoFilter !== '') {
                    if ((scontoFilter === 'in-sconto' && sconto === 0) || 
                        (scontoFilter === 'no-sconto' && sconto > 0)) {
                        isVisible = false;
                    }
                }

                if (isVisible) {
                    row.style.display = '';
                    visibleRows++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            updateFilteredCount(visibleRows, totalRows);
        }

        document.getElementById('resetFilters').addEventListener('click', function() {
            document.getElementById('marcaFilter').value = '';
            document.getElementById('categoriaFilter').value = '';
            document.getElementById('connectionFilter').value = '';
            document.getElementById('formaFilter').value = '';
            document.getElementById('dpiFilter').value = '';
            document.getElementById('ledFilter').value = '';
            document.getElementById('pesoFilter').value = '';
            document.getElementById('minPrice').value = '';
            document.getElementById('maxPrice').value = '';
            document.getElementById('statoFilter').value = '';
            document.getElementById('scontoFilter').value = '';

            const rows = document.querySelectorAll('.data-table tbody tr');
                            rows.forEach(row => {
                row.style.display = '';
                            });
                            
                            visibleRows = totalRows;
                            updateFilteredCount(visibleRows, totalRows);
        });

        const selectElements = [
            document.getElementById('marcaFilter'),
            document.getElementById('categoriaFilter'),
            document.getElementById('connectionFilter'),
            document.getElementById('formaFilter'),
            document.getElementById('dpiFilter'),
            document.getElementById('ledFilter'),
            document.getElementById('pesoFilter'),
            document.getElementById('statoFilter'),
            document.getElementById('scontoFilter')
        ];
        
        selectElements.forEach(select => {
            select.addEventListener('change', applyFilters);
        });

        document.getElementById('minPrice').addEventListener('input', applyFilters);
        document.getElementById('maxPrice').addEventListener('input', applyFilters);
    });
    function adjustTableForMobile() {
        const isMobile = window.innerWidth <= 768;

        const columnsToHide = [1, 2, 3, 4, 5, 6,7, 8, 9]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('mouse-table');

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
</div>