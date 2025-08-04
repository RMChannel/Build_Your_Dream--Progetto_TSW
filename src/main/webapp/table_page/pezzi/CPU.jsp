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
    <div class="table-section" id = "cpu-table">
        <h2 style="padding: 20px 20px 0">Elenco <%=request.getAttribute("table")%></h2>
        <div class="filtered-count"></div>
        <table class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Famiglia</th>
                <th>Generazione</th>
                <th>N°Core</th>
                <th>N°Threads</th>
                <th>Frequenza Base</th>
                <th>Frequenza Turbo</th>
                <th>TDP</th>
                <th>Litografia</th>
                <th>Socket</th>
                <th>Max Memoria Supportata</th>
                <th>Frequenza Memoria Supportata</th>
                <th>PCIE Supportata</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${piecies}" var="cpu">
                <c:set var="button" value="${cpu.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                <c:set var="buttonDisabled" value="${cpu.disponibilita>0 ? '':'disabled'}"/>
                <c:set var="prezzoClass" value="${cpu.sconto>0 ? 'prezzo-scontato' : ''}"/>
            <tr data-sconto="${cpu.sconto}" data-disponibile="${cpu.disponibilita>0 ? 'true' : 'false'}">
                <td class="cpu-image">
                    <c:set var="cpuId" value="${cpu.ID}" scope="request"/>
                    <%
                        FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                        Object cpuId = request.getAttribute("cpuId");
                        String imagePath = fotoDAO.getFoto((Integer) cpuId, "fotoPezzi", "CPU", (String) request.getAttribute("path"));
                    %>
                    <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${cpu.marca}_${cpu.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'CPU', '${cpu.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'CPU', '${cpu.ID}')">
                </td>
                <td>${cpu.marca}</td>
                <td>${cpu.modello}</td>
                <td>${cpu.famiglia}</td>
                <td>${cpu.generazione}</td>
                <td>${cpu.nCore}</td>
                <td>${cpu.nThreads}</td>
                <td>${cpu.baseFrequence}</td>
                <td>${cpu.turboFrequence}</td>
                <td>${cpu.TDP}W</td>
                <td>${cpu.litografia}</td>
                <td>${cpu.socket}</td>
                <td>${cpu.memSup}</td>
                <td>${cpu.memFrequence}</td>
                <td>${cpu.PCIE}</td>
                <td class="${prezzoClass}">
                    <c:if test="${cpu.sconto>0}">
                        <span class="prezzo-originale">${Math.round(cpu.prezzo*100)/100}€</span>
                        <span class="sconto-badge">-${cpu.sconto}%</span>
                    </c:if>
                    <span class="prezzo-finale">${Math.round(cpu.prezzoScontato*100)/100}€</span>
                </td>
                <td>
                    <div><button class="acquista" onclick="acquista('${cpu.ID}')" value="${button}" ${buttonDisabled}>${button}</button></div>
                    <div> <button name="aggiungiBuilder" class="acquista" type="button" onclick="addToBuilder('CPU', '${cpu.ID}')">Aggiungi al builder</button></div>
                </td>
            </tr>
            </c:forEach>
        </table>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        function applyFilters() {
            const marcaFilter = document.getElementById('marcaFilter').value;
            const minPrice = parseFloat(document.getElementById('minPrice').value) || 0;
            const maxPrice = parseFloat(document.getElementById('maxPrice').value) || Infinity;
            const socketFilter = document.getElementById('socketFilter').value;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;

            const rows = document.querySelectorAll('.data-table tbody tr');

            rows.forEach(row => {
                const marca = row.cells[1].textContent.trim();
                const socket = row.cells[11].textContent.trim();
                const prezzoElement = row.cells[15].querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;

                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                const matchesSocket = socketFilter === '' || socket === socketFilter;
                const matchesStato = statoFilter === '' ||
                    (statoFilter === 'disponibile' && isDisponibile) ||
                    (statoFilter === 'non-disponibile' && !isDisponibile);
                const matchesSconto = scontoFilter === '' ||
                    (scontoFilter === 'in-sconto' && sconto > 0) ||
                    (scontoFilter === 'no-sconto' && sconto === 0);

                if (matchesMarca && matchesPrezzo && matchesSocket && matchesStato && matchesSconto) {
                    row.style.display = '';
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
            document.getElementById('statoFilter').value = '';
            document.getElementById('scontoFilter').value = '';

            const rows = document.querySelectorAll('.data-table tbody tr');
            rows.forEach(row => {
                row.style.display = '';
            });
        }

        document.getElementById('minPrice').addEventListener('input', applyFilters);
        document.getElementById('maxPrice').addEventListener('input', applyFilters);

        const selectElements = [
            document.getElementById('marcaFilter'),
            document.getElementById('socketFilter'),
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

        const columnsToHide = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('cpu-table');

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