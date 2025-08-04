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
            <h3>Potenza</h3>
            <div class="filter-item price-range">
                <input type="number" id="minPotenza" placeholder="Min W" min="0">
                <span>-</span>
                <input type="number" id="maxPotenza" placeholder="Max W" min="0">
            </div>
        </div>

        <div class="filter-group">
            <h3>Certificazione</h3>
            <div class="filter-item">
                <select id="certificazioneFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${certificazioni}" var="certificazione">
                        <option value="${certificazione}">${certificazione}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Modularità</h3>
            <div class="filter-item">
                <select id="modularitaFilter">
                    <option value="">Tutti</option>
                    <option value="si">Si</option>
                    <option value="no">No</option>
                </select>
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

    <!-- Sezione Tabella -->
    <div class="table-section" id = "psu-table">
        <h2 style="padding: 20px 20px 0">Elenco <%=request.getAttribute("table")%></h2>
        <table class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Categoria</th>
                <th>Potenza</th>
                <th>Certificazione</th>
                <th>Modularità</th>
                <th>Peso</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${piecies}" var="psu">
                <c:set var="button" value="${psu.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                <c:set var="buttonDisabled" value="${psu.disponibilita>0 ? '':'disabled'}"/>
                <c:set var="prezzoClass" value="${psu.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <c:set var="modularita" value="${psu.modularita ? 'Si':'No'}"/>
                <tr data-sconto="${psu.sconto}" data-disponibile="${psu.disponibilita>0 ? 'true' : 'false'}" data-potenza="${psu.potenza}" data-modularita="${psu.modularita ? 'si' : 'no'}">
                    <td class="cpu-image">
                        <c:set var="psuId" value="${psu.ID}" scope="request"/>
                        <%
                            FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                            Object psuId = request.getAttribute("psuId");
                            String imagePath = fotoDAO.getFoto((Integer) psuId, "fotoPezzi", "PSU", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${psu.marca}_${psu.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'PSU', '${psu.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'PSU', '${psu.ID}')">
                    </td>
                    <td>${psu.marca}</td>
                    <td>${psu.modello}</td>
                    <td>${psu.categoria}</td>
                    <td>${psu.potenza}W</td>
                    <td>${psu.certificazione}</td>
                    <td>${modularita}</td>
                    <td>${psu.peso/1000}kg</td>
                    <td class="${prezzoClass}">
                        <c:if test="${psu.sconto>0}">
                            <span class="prezzo-originale">${Math.round(psu.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${psu.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.floor((psu.prezzoScontato)*100)/100}€</span>
                    </td>
                    <td>
                        <div><button class="acquista" onclick="acquista('${psu.ID}')">${button}</button></div>
                        <div><button name="aggiungiBuilder" class="acquista" type="button" onclick="addToBuilder('PSU', '${psu.ID}')">Aggiungi al builder</button> </div>
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
            const categoriaFilter = document.getElementById('categoriaFilter').value;
            const minPotenza = parseFloat(document.getElementById('minPotenza').value) || 0;
            const maxPotenza = parseFloat(document.getElementById('maxPotenza').value) || Infinity;
            const certificazioneFilter = document.getElementById('certificazioneFilter').value;
            const modularitaFilter = document.getElementById('modularitaFilter').value;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;

            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;

            rows.forEach(row => {
                const marca = row.cells[1].textContent.trim();
                const categoria = row.cells[3].textContent.trim();
                const potenza = parseFloat(row.cells[4].textContent.replace('W', '').trim());
                const certificazione = row.cells[5].textContent.trim();
                const modularita = row.getAttribute('data-modularita');
                const prezzoElement = row.cells[8].querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;

                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                const matchesCategoria = categoriaFilter === '' || categoria === categoriaFilter;
                const matchesPotenza = potenza >= minPotenza && (maxPotenza === Infinity || potenza <= maxPotenza);
                const matchesCertificazione = certificazioneFilter === '' || certificazione === certificazioneFilter;
                const matchesModularita = modularitaFilter === '' || modularita === modularitaFilter;
                const matchesStato = statoFilter === '' ||
                    (statoFilter === 'disponibile' && isDisponibile) ||
                    (statoFilter === 'non-disponibile' && !isDisponibile);
                const matchesSconto = scontoFilter === '' ||
                    (scontoFilter === 'in-sconto' && sconto > 0) ||
                    (scontoFilter === 'no-sconto' && sconto === 0);

                if (matchesMarca && matchesPrezzo && matchesCategoria && matchesPotenza && 
                    matchesCertificazione && matchesModularita && matchesStato && matchesSconto) {
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
            document.getElementById('categoriaFilter').value = '';
            document.getElementById('minPotenza').value = '';
            document.getElementById('maxPotenza').value = '';
            document.getElementById('certificazioneFilter').value = '';
            document.getElementById('modularitaFilter').value = '';
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
        document.getElementById('minPotenza').addEventListener('input', applyFilters);
        document.getElementById('maxPotenza').addEventListener('input', applyFilters);

        const selectElements = [
            document.getElementById('marcaFilter'),
            document.getElementById('categoriaFilter'),
            document.getElementById('certificazioneFilter'),
            document.getElementById('modularitaFilter'),
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

        const columnsToHide = [1, 2, 3, 4, 5, 6, 7, 10]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('psu-table');

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