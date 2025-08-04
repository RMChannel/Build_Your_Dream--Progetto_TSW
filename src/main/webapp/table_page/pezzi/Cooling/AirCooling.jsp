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
            <h3>Prezzo</h3>
            <div class="filter-item price-range">
                <input type="number" id="minPrice" placeholder="Min €" min="0">
                <span>-</span>
                <input type="number" id="maxPrice" placeholder="Max €" min="0">
            </div>
        </div>

        <div class="filter-group">
            <h3>Socket</h3>
            <div class="filter-item">
                <select id="socketFilter">
                    <option value="">Tutti</option>
                    <c:forEach items="${sockets}" var="socket">
                        <option value="${socket}">${socket}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>TDP</h3>
            <div class="filter-item price-range">
                <input type="number" id="minTDP" placeholder="Min W" min="0">
                <span>-</span>
                <input type="number" id="maxTDP" placeholder="Max W" min="0">
            </div>
        </div>

        <div class="filter-group">
            <h3>Dimensione Ventola</h3>
            <div class="filter-item">
                <select id="dimVentolaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${dimVentole}" var="dimVentola">
                        <option value="${dimVentola}">${dimVentola}mm</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>RGB</h3>
            <div class="filter-item">
                <select id="rgbFilter">
                    <option value="">Tutti</option>
                    <option value="si">Si</option>
                    <option value="no">No</option>
                </select>
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
    <div class="table-section" id = "Aircooling-table">
        <h2 style="padding: 20px 20px 0">Elenco AirCooling</h2>
        <div class="filtered-count"></div>
        <table class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Socket</th>
                <th>Dimensione Ventola</th>
                <th>Numero Ventole</th>
                <th>Max RPM</th>
                <th>RGB</th>
                <th>TDP</th>
                <th>Colore</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${piecies}" var="airCooling">
                <c:set var="button" value="${airCooling.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                <c:set var="buttonDisabled" value="${airCooling.disponibilita>0 ? '':'disabled'}"/>
                <c:set var="prezzoClass" value="${airCooling.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <c:set var="rgb" value="${airCooling.rgb ? 'Si':'No'}"/>
                <c:set var="airCoolingId" value="${airCooling.ID}" scope="request"/>
                <%
                    FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                    Object airCoolingId = request.getAttribute("airCoolingId");
                    String imagePath = fotoDAO.getFoto((Integer) airCoolingId, "fotoPezzi", "AirCooling", (String) request.getAttribute("path"));
                %>
                <tr data-sconto="${airCooling.sconto}" data-disponibile="${airCooling.disponibilita>0 ? 'true' : 'false'}" data-rgb="${airCooling.rgb ? 'si' : 'no'}" data-dimventola="${airCooling.dimVentola}">
                    <td class="aircooling-image">
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${airCooling.marca}_${airCooling.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>','AirCooling','${airCooling.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>','AirCooling','${airCooling.ID}')">
                    </td>
                    <td>${airCooling.marca}</td>
                    <td>${airCooling.modello}</td>
                    <td>${airCooling.socket}</td>
                    <td>${airCooling.dimVentola}mm</td>
                    <td>${airCooling.nVentole}</td>
                    <td>${airCooling.maxRPM} RPM</td>
                    <td>${rgb}</td>
                    <td>${airCooling.TDP}W</td>
                    <td>${airCooling.colore}</td>
                    <td class="${prezzoClass}">
                        <c:if test="${airCooling.sconto>0}">
                            <span class="prezzo-originale">${Math.round(airCooling.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${airCooling.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.floor((airCooling.prezzoScontato)*100)/100}€</span>
                    </td>
                    <td>
                        <div><button class="acquista" onclick="acquista('${airCooling.ID}')">Aggiungi al carrello</button></div>
                        <div><button name="aggiungiBuilder" class="acquista" type="button" onclick="addToBuilder('AirCooling', '${airCooling.ID}')">Aggiungi al builder</button> </div>
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
            const minPrice = parseFloat(document.getElementById('minPrice').value) || 0;
            const maxPrice = parseFloat(document.getElementById('maxPrice').value) || Infinity;
            const socketFilter = document.getElementById('socketFilter').value;
            const minTDP = parseFloat(document.getElementById('minTDP').value) || 0;
            const maxTDP = parseFloat(document.getElementById('maxTDP').value) || Infinity;
            const dimVentolaFilter = document.getElementById('dimVentolaFilter').value;
            const rgbFilter = document.getElementById('rgbFilter').value;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;

            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;

            rows.forEach(row => {
                const marca = row.cells[1].textContent.trim();
                const socket = row.cells[3].textContent.trim();
                const dimVentola = row.getAttribute('data-dimventola');
                const tdp = parseFloat(row.cells[8].textContent.replace('W', '').trim());
                const rgb = row.getAttribute('data-rgb');
                const prezzoElement = row.cells[10].querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;

                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                const matchesSocket = socketFilter === '' || socket === socketFilter;
                const matchesTDP = tdp >= minTDP && (maxTDP === Infinity || tdp <= maxTDP);
                const matchesDimVentola = dimVentolaFilter === '' || dimVentola === dimVentolaFilter;
                const matchesRGB = rgbFilter === '' || rgb === rgbFilter;
                const matchesStato = statoFilter === '' ||
                    (statoFilter === 'disponibile' && isDisponibile) ||
                    (statoFilter === 'non-disponibile' && !isDisponibile);
                const matchesSconto = scontoFilter === '' ||
                    (scontoFilter === 'in-sconto' && sconto > 0) ||
                    (scontoFilter === 'no-sconto' && sconto === 0);

                if (matchesMarca && matchesPrezzo && matchesSocket && matchesTDP && matchesDimVentola && matchesRGB && matchesStato && matchesSconto) {
                    row.style.display = '';
                    visibleRows++;
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function resetFilters() {
            document.getElementById('marcaFilter').value = '';
            document.getElementById('minPrice').value = '';
            document.getElementById('maxPrice').value = '';
            document.getElementById('socketFilter').value = '';
            document.getElementById('minTDP').value = '';
            document.getElementById('maxTDP').value = '';
            document.getElementById('dimVentolaFilter').value = '';
            document.getElementById('rgbFilter').value = '';
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
        document.getElementById('minTDP').addEventListener('input', applyFilters);
        document.getElementById('maxTDP').addEventListener('input', applyFilters);

        const selectElements = [
            document.getElementById('marcaFilter'),
            document.getElementById('socketFilter'),
            document.getElementById('dimVentolaFilter'),
            document.getElementById('rgbFilter'),
            document.getElementById('statoFilter'),
            document.getElementById('scontoFilter')
        ];

        selectElements.forEach(select => {
            select.addEventListener('change', applyFilters);
        });

        document.getElementById('resetFilters').addEventListener('click', resetFilters);
    });
    function adjustTableForMobile() {
        const isMobile = window.innerWidth <= 768;

        const columnsToHide = [1, 2, 3, 4, 5, 6, 7, 8, 9, 12]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('Aircooling-table');

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