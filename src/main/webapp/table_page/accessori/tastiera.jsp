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
            <h3>Layout</h3>
            <div class="filter-item">
                <select id="layoutFilter">
                    <option value="">Tutti</option>
                    <c:forEach items="${layouts}" var="layout">
                        <option value="${layout}">${layout}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Tipo Tastiera</h3>
            <div class="filter-item">
                <select id="compattoFilter">
                    <option value="">Tutte</option>
                    <option value="true">Compatta</option>
                    <option value="false">Standard</option>
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
            <h3>Connettività</h3>
            <div class="filter-item">
                <select id="connettivitaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${connettivita}" var="conn">
                        <option value="${conn}">${conn}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Dimensioni</h3>
            <div class="filter-item">
                <select id="dimensioniFilter">
                    <option value="">Tutte</option>
                    <option value="piccola">Piccola (< 35cm)</option>
                    <option value="media">Media (35-45cm)</option>
                    <option value="grande">Grande (> 45cm)</option>
                </select>
            </div>
        </div>
        
        <div class="filter-group">
            <h3>Peso</h3>
            <div class="filter-item">
                <select id="pesoFilter">
                    <option value="">Tutti</option>
                    <option value="leggera">Leggera (< 0.8kg)</option>
                    <option value="media">Media (0.8-1.5kg)</option>
                    <option value="pesante">Pesante (> 1.5kg)</option>
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
        <table id="tastiera-table" class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Categoria</th>
                <th>Layout</th>
                <th>Tipo</th>
                <th>Connettività</th>
                <th>LED</th>
                <th>Dimensioni</th>
                <th>Peso</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tastiere}" var="tastiera">
                <c:set var="prezzoClass" value="${tastiera.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <tr class="product-row" 
                    data-sconto="${tastiera.sconto}" 
                    data-disponibile="${tastiera.disponibilita>0 ? 'true' : 'false'}" 
                    data-compatta="${tastiera.compatta}"
                    data-led="${tastiera.led}">
                    <td class="tastiera-image">
                        <c:set var="tastieraId" value="${tastiera.ID}" scope="request"/>
                        <%
                            FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                            Object tastieraId = request.getAttribute("tastieraId");
                            String imagePath = fotoDAO.getFoto((Integer) tastieraId, "fotoAccessori", "Tastiere", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${tastiera.marca}_${tastiera.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Tastiera', '${tastiera.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Tastiera', '${tastiera.ID}')">
                    </td>
                    <td class="tastiera-marca">${tastiera.marca}</td>
                    <td class="tastiera-modello">${tastiera.modello}</td>
                    <td class="tastiera-categoria">${tastiera.categoria}</td>
                    <td class="tastiera-layout">${tastiera.layout}</td>
                    <td class="tastiera-tipo">${tastiera.compatta ? 'Compatta' : 'Standard'}</td>
                    <td class="tastiera-connettivita">${tastiera.connettivita}</td>
                    <td class="tastiera-led">${tastiera.led ? 'Si' : 'No'}</td>
                    <td class="tastiera-dimensioni">${tastiera.larghezza}x${tastiera.lunghezza}cm</td>
                    <td class="tastiera-peso">${tastiera.peso}g</td>
                    <td class="${prezzoClass}">
                        <c:if test="${tastiera.sconto>0}">
                            <span class="prezzo-originale">${Math.round(tastiera.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${tastiera.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.floor((tastiera.prezzoScontato)*100)/100}€</span>
                    </td>
                    <td class="tastiera-actions">
                        <c:set var="button" value="${tastiera.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                        <c:set var="buttonDisabled" value="${tastiera.disponibilita>0 ? '':'disabled'}"/>
                        <button class="acquista" onclick="acquista('${tastiera.ID}')">Aggiungi al carrello</button>
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
            const layoutFilter = document.getElementById('layoutFilter').value;
            const compattoFilter = document.getElementById('compattoFilter').value;
            const ledFilter = document.getElementById('ledFilter').value;
            const connettivitaFilter = document.getElementById('connettivitaFilter').value;
            const dimensioniFilter = document.getElementById('dimensioniFilter').value;
            const pesoFilter = document.getElementById('pesoFilter').value;
            const minPrice = parseFloat(document.getElementById('minPrice').value) || 0;
            const maxPrice = parseFloat(document.getElementById('maxPrice').value) || Infinity;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;
    
            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;
    
            rows.forEach(row => {
                const marca = row.querySelector('.tastiera-marca').textContent.trim();
                const categoria = row.querySelector('.tastiera-categoria').textContent.trim();
                const layout = row.querySelector('.tastiera-layout').textContent.trim();
                const compatta = row.getAttribute('data-compatta') === 'true';
                const led = row.getAttribute('data-led') === 'true';
                const connettivita = row.querySelector('.tastiera-connettivita').textContent.trim();
                const dimensioni = row.querySelector('.tastiera-dimensioni').textContent.trim();
                const larghezza = parseFloat(dimensioni.split('x')[0]);
                const peso = parseFloat(row.querySelector('.tastiera-peso').textContent.replace('kg', '').trim());
                const prezzoElement = row.querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;
    
                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesCategoria = categoriaFilter === '' || categoria === categoriaFilter;
                const matchesLayout = layoutFilter === '' || layout === layoutFilter;
                const matchesCompatto = compattoFilter === '' || 
                                      (compattoFilter === 'true' && compatta) || 
                                      (compattoFilter === 'false' && !compatta);
                const matchesLed = ledFilter === '' || 
                                  (ledFilter === 'true' && led) || 
                                  (ledFilter === 'false' && !led);
                const matchesConnettivita = connettivitaFilter === '' || connettivita === connettivitaFilter;
                
                const matchesDimensioni = dimensioniFilter === '' || 
                                        (dimensioniFilter === 'piccola' && larghezza < 35) ||
                                        (dimensioniFilter === 'media' && larghezza >= 35 && larghezza <= 45) ||
                                        (dimensioniFilter === 'grande' && larghezza > 45);
                
                const matchesPeso = pesoFilter === '' || 
                                   (pesoFilter === 'leggera' && peso < 800) ||
                                   (pesoFilter === 'media' && peso >= 800 && peso <= 1500) ||
                                   (pesoFilter === 'pesante' && peso > 1500);
                
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                
                const matchesStato = statoFilter === '' ||
                                    (statoFilter === 'disponibile' && isDisponibile) ||
                                    (statoFilter === 'non-disponibile' && !isDisponibile);
                
                const matchesSconto = scontoFilter === '' ||
                                     (scontoFilter === 'in-sconto' && sconto > 0) ||
                                     (scontoFilter === 'no-sconto' && sconto === 0);
    
                if (matchesMarca && matchesCategoria && matchesLayout && matchesCompatto && 
                    matchesLed && matchesConnettivita && matchesDimensioni && matchesPeso && 
                    matchesPrezzo && matchesStato && matchesSconto) {
                    row.style.display = '';
                    visibleRows++;
                } else {
                    row.style.display = 'none';
                }
            });
        }
    
        function resetFilters() {
            document.getElementById('marcaFilter').value = '';
            document.getElementById('categoriaFilter').value = '';
            document.getElementById('layoutFilter').value = '';
            document.getElementById('compattoFilter').value = '';
            document.getElementById('ledFilter').value = '';
            document.getElementById('connettivitaFilter').value = '';
            document.getElementById('dimensioniFilter').value = '';
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
        }
        document.getElementById('marcaFilter').addEventListener('change', applyFilters);
        document.getElementById('categoriaFilter').addEventListener('change', applyFilters);
        document.getElementById('layoutFilter').addEventListener('change', applyFilters);
        document.getElementById('compattoFilter').addEventListener('change', applyFilters);
        document.getElementById('ledFilter').addEventListener('change', applyFilters);
        document.getElementById('connettivitaFilter').addEventListener('change', applyFilters);
        document.getElementById('dimensioniFilter').addEventListener('change', applyFilters);
        document.getElementById('pesoFilter').addEventListener('change', applyFilters);
        document.getElementById('minPrice').addEventListener('input', applyFilters);
        document.getElementById('maxPrice').addEventListener('input', applyFilters);
        document.getElementById('statoFilter').addEventListener('change', applyFilters);
        document.getElementById('scontoFilter').addEventListener('change', applyFilters);
        document.getElementById('resetFilters').addEventListener('click', resetFilters);
    });
    function adjustTableForMobile() {
        const isMobile = window.innerWidth <= 768;

        const columnsToHide = [1, 2, 3, 4, 5, 6,7, 8, 9]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('tastiera-table');

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
