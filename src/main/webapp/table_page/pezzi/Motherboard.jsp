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
            <h3>Tipo RAM</h3>
            <div class="filter-item">
                <select id="tipoRamFilter">
                    <option value="">Tutti</option>
                    <c:forEach items="${tipiRam}" var="tipoRam">
                        <option value="${tipoRam}">${tipoRam}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>PCIe</h3>
            <div class="filter-item">
                <select id="pcieFilter">
                    <option value="">Tutti</option>
                    <c:forEach items="${pcies}" var="pcie">
                        <option value="${pcie}">${pcie}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>WiFi</h3>
            <div class="filter-item">
                <select id="wifiFilter">
                    <option value="">Tutti</option>
                    <option value="true">Con WiFi</option>
                    <option value="false">Senza WiFi</option>
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
    <div class="table-section", id="mobo-table">
        <h2 style="padding: 20px 20px 0">Elenco <%=request.getAttribute("table")%></h2>
        <table class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Socket</th>
                <th>Categoria</th>
                <th>Tipo RAM</th>
                <th>Slot RAM</th>
                <th>Capacità RAM Max</th>
                <th>Connettori SATA</th>
                <th>Slot M.2</th>
                <th>WiFi</th>
                <th>PCIe</th>
                <th>Slot PCIe</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${piecies}" var="motherboard">
                <c:set var="button" value="${motherboard.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                <c:set var="buttonDisabled" value="${motherboard.disponibilita>0 ? '':'disabled'}"/>
                <c:set var="prezzoClass" value="${motherboard.sconto>0 ? 'prezzo-scontato' : ''}"/>
            <tr data-sconto="${motherboard.sconto}" data-disponibile="${motherboard.disponibilita>0 ? 'true' : 'false'}" data-wifi="${motherboard.wifi}">
                <td class="motherboard-image">
                    <c:set var="motherboardId" value="${motherboard.ID}" scope="request"/>
                    <%
                        FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                        Object motherboardId = request.getAttribute("motherboardId");
                        String imagePath = fotoDAO.getFoto((Integer) motherboardId, "fotoPezzi", "Motherboard", (String) request.getAttribute("path"));
                    %>
                    <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${motherboard.marca}_${motherboard.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Motherboard', '${motherboard.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Motherboard', '${motherboard.ID}')">
                </td>
                <td>${motherboard.marca}</td>
                <td>${motherboard.modello}</td>
                <td>${motherboard.socket}</td>
                <td>${motherboard.categoria}</td>
                <td>${motherboard.tipo_ram}</td>
                <td>${motherboard.nSlot}</td>
                <td>${motherboard.capacitaRAM} GB</td>
                <td>${motherboard.nSata}</td>
                <td>${motherboard.nM2}</td>
                <td>${motherboard.wifi ? 'Sì' : 'No'}</td>
                <td>${motherboard.pcie}</td>
                <td>${motherboard.nPcie}</td>
                <td class="${prezzoClass}">
                    <c:if test="${motherboard.sconto>0}">
                        <span class="prezzo-originale">${Math.round(motherboard.prezzo*100)/100}€</span>
                        <span class="sconto-badge">-${motherboard.sconto}%</span>
                    </c:if>
                    <span class="prezzo-finale">${Math.round(motherboard.prezzoScontato*100)/100}€</span>
                </td>
                <td>
                    <div><button class="acquista" onclick="acquista('${motherboard.ID}')">Aggiungi al carrello</button></div>
                    <div><button name="aggiungiBuilder" class="acquista" type="button" onclick="addToBuilder('Motherboard', '${motherboard.ID}')">Aggiungi al builder</button></div>
                </td>
            </tr>
            </c:forEach>
            </tbody>
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
            const categoriaFilter = document.getElementById('categoriaFilter').value;
            const tipoRamFilter = document.getElementById('tipoRamFilter').value;
            const pcieFilter = document.getElementById('pcieFilter').value;
            const wifiFilter = document.getElementById('wifiFilter').value;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;

            const rows = document.querySelectorAll('.data-table tbody tr');

            rows.forEach(row => {
                const marca = row.cells[1].textContent.trim();
                const socket = row.cells[3].textContent.trim();
                const categoria = row.cells[4].textContent.trim();
                const tipoRam = row.cells[5].textContent.trim();
                const pcie = row.cells[11].textContent.trim();
                const prezzoElement = row.cells[13].querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;
                const hasWifi = row.getAttribute('data-wifi') === 'true';

                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                const matchesSocket = socketFilter === '' || socket === socketFilter;
                const matchesCategoria = categoriaFilter === '' || categoria === categoriaFilter;
                const matchesTipoRam = tipoRamFilter === '' || tipoRam === tipoRamFilter;
                const matchesPcie = pcieFilter === '' || pcie === pcieFilter;
                const matchesWifi = wifiFilter === '' || 
                                    (wifiFilter === 'true' && hasWifi) || 
                                    (wifiFilter === 'false' && !hasWifi);
                const matchesStato = statoFilter === '' ||
                    (statoFilter === 'disponibile' && isDisponibile) ||
                    (statoFilter === 'non-disponibile' && !isDisponibile);
                const matchesSconto = scontoFilter === '' ||
                    (scontoFilter === 'in-sconto' && sconto > 0) ||
                    (scontoFilter === 'no-sconto' && sconto === 0);

                if (matchesMarca && matchesPrezzo && matchesSocket && matchesCategoria && 
                    matchesTipoRam && matchesPcie && matchesWifi && matchesStato && matchesSconto) {
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
            document.getElementById('categoriaFilter').value = '';
            document.getElementById('tipoRamFilter').value = '';
            document.getElementById('pcieFilter').value = '';
            document.getElementById('wifiFilter').value = '';
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
            document.getElementById('categoriaFilter'),
            document.getElementById('tipoRamFilter'),
            document.getElementById('pcieFilter'),
            document.getElementById('wifiFilter'),
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

        const columnsToHide = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 15]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('mobo-table');

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