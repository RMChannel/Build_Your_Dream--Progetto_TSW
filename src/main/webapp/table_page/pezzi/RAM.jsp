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
            <h3>Capacità</h3>
            <div class="filter-item">
                <select id="capacitaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${capacities}" var="capacity">
                        <option value="${capacity}">${capacity} GB</option>
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
            <h3>Tipologia</h3>
            <div class="filter-item">
                <select id="tipologiaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${tipologie}" var="tipologia">
                        <option value="${tipologia}">${tipologia}</option>
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
                        <option value="${frequenza}">${frequenza} MHz</option>
                    </c:forEach>
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
    <div class="table-section" id = "ram-table">
        <h2 style="padding: 20px 20px 0">Elenco <%=request.getAttribute("table")%></h2>
        <table class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Categoria</th>
                <th>Capacità</th>
                <th>Frequenza</th>
                <th>Tipologia</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${piecies}" var="ram">
                <c:set var="button" value="${ram.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                <c:set var="buttonDisabled" value="${ram.disponibilita>0 ? '':'disabled'}"/>
                <c:set var="prezzoClass" value="${ram.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <tr data-sconto="${ram.sconto}" data-disponibile="${ram.disponibilita>0 ? 'true' : 'false'}">
                    <td class="ram-image">
                        <c:set var="ramId" value="${ram.ID}" scope="request"/>
                        <%
                            FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                            Object ramId = request.getAttribute("ramId");
                            String imagePath = fotoDAO.getFoto((Integer) ramId, "fotoPezzi", "RAM", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${ram.marca}_${ram.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'RAM', '${ram.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'RAM', '${ram.ID}')">
                    </td>
                    <td>${ram.marca}</td>
                    <td>${ram.modello}</td>
                    <td>${ram.categoria}</td>
                    <td>${ram.capacita} GB</td>
                    <td>${ram.frequenza} MHz</td>
                    <td>${ram.tipologia}</td>
                    <td class="${prezzoClass}">
                        <c:if test="${ram.sconto>0}">
                            <span class="prezzo-originale">${Math.round(ram.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${ram.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.floor((ram.prezzoScontato)*100)/100}€</span>
                    </td>
                    <td>
                        <div><button class="acquista" onclick="acquista('${ram.ID}')">${button}</button></div>
                        <div> <button name="aggiungiBuilder" class="acquista" type="button" onclick="addToBuilder('RAM', '${ram.ID}')">Aggiungi al builder</button></div>
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
            const capacitaFilter = document.getElementById('capacitaFilter').value;
            const categoriaFilter = document.getElementById('categoriaFilter').value;
            const tipologiaFilter = document.getElementById('tipologiaFilter').value;
            const frequenzaFilter = document.getElementById('frequenzaFilter').value;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;

            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;

            rows.forEach(row => {
                const marca = row.cells[1].textContent.trim();
                const categoria = row.cells[3].textContent.trim();
                const capacita = row.cells[4].textContent.trim();
                const capacitaValue = parseInt(capacita.split(' ')[0]);
                const frequenza = row.cells[5].textContent.trim();
                const frequenzaValue = parseInt(frequenza.split(' ')[0]);
                const tipologia = row.cells[6].textContent.trim();
                const prezzoElement = row.cells[7].querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;

                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                const matchesCapacita = capacitaFilter === '' || capacitaValue === parseInt(capacitaFilter);
                const matchesCategoria = categoriaFilter === '' || categoria === categoriaFilter;
                const matchesTipologia = tipologiaFilter === '' || tipologia === tipologiaFilter;
                const matchesFrequenza = frequenzaFilter === '' || frequenzaValue === parseInt(frequenzaFilter);
                const matchesStato = statoFilter === '' ||
                    (statoFilter === 'disponibile' && isDisponibile) ||
                    (statoFilter === 'non-disponibile' && !isDisponibile);
                const matchesSconto = scontoFilter === '' ||
                    (scontoFilter === 'in-sconto' && sconto > 0) ||
                    (scontoFilter === 'no-sconto' && sconto === 0);

                if (matchesMarca && matchesPrezzo && matchesCapacita && matchesCategoria &&
                    matchesTipologia && matchesFrequenza && matchesStato && matchesSconto) {
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
            document.getElementById('capacitaFilter').value = '';
            document.getElementById('categoriaFilter').value = '';
            document.getElementById('tipologiaFilter').value = '';
            document.getElementById('frequenzaFilter').value = '';
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

        const selectElements = [
            document.getElementById('marcaFilter'),
            document.getElementById('capacitaFilter'),
            document.getElementById('categoriaFilter'),
            document.getElementById('tipologiaFilter'),
            document.getElementById('frequenzaFilter'),
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

        const columnsToHide = [1, 2, 3, 4, 5, 6, 9]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('ram-table');

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