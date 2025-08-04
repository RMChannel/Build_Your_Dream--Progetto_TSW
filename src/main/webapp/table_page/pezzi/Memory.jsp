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
            <h3>Capacità</h3>
            <div class="filter-item">
                <select id="capacitaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${capacita}" var="cap">
                        <option value="${cap}">${cap} GB</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Interfaccia</h3>
            <div class="filter-item">
                <select id="interfacciaFilter">
                    <option value="">Tutte</option>
                    <c:forEach items="${interfacce}" var="interfaccia">
                        <option value="${interfaccia}">${interfaccia}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="filter-group">
            <h3>Velocità Lettura</h3>
            <div class="filter-item price-range">
                <input type="number" id="minReadSpeed" placeholder="Min MB/s" min="0">
                <span>-</span>
                <input type="number" id="maxReadSpeed" placeholder="Max MB/s" min="0">
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
    <div class="table-section" id = "memory-table">
        <h2 style="padding: 20px 20px 0">Elenco <%=request.getAttribute("table")%></h2>
        <div class="filtered-count"></div>
        <table class="data-table">
            <thead>
            <tr>
                <th>Immagine</th>
                <th>Marca</th>
                <th>Modello</th>
                <th>Categoria</th>
                <th>Tipologia</th>
                <th>Interfaccia</th>
                <th>Capacità</th>
                <th>Velocità Lettura</th>
                <th>Velocità Scrittura</th>
                <th>Prezzo</th>
                <th>Acquista</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${piecies}" var="memory">
                <c:set var="button" value="${memory.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                <c:set var="buttonDisabled" value="${memory.disponibilita>0 ? '':'disabled'}"/>
                <c:set var="prezzoClass" value="${memory.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <c:set var="memoryId" value="${memory.ID}" scope="request"/>
                <%
                    FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                    Object memoryId = request.getAttribute("memoryId");
                    String imagePath = fotoDAO.getFoto((Integer) memoryId, "fotoPezzi", "Memory", (String) request.getAttribute("path"));
                %>
                <tr data-sconto="${memory.sconto}" data-disponibile="${memory.disponibilita>0 ? 'true' : 'false'}" data-categoria="${memory.categoria}" data-tipologia="${memory.tipologia}" data-interfaccia="${memory.interfaccia}" data-capacita="${memory.capacita}">
                    <td class="memory-image">
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${memory.marca}_${memory.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Memory', '${memory.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Memory', '${memory.ID}')">
                    </td>
                    <td>${memory.marca}</td>
                    <td>${memory.modello}</td>
                    <td>${memory.categoria}</td>
                    <td>${memory.tipologia}</td>
                    <td>${memory.interfaccia}</td>
                    <td>${memory.capacita} GB</td>
                    <td>${memory.readSpeed} MB/s</td>
                    <td>${memory.writeSpeed} MB/s</td>
                    <td class="${prezzoClass}">
                        <c:if test="${memory.sconto>0}">
                            <span class="prezzo-originale">${Math.round(memory.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${memory.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.floor((memory.prezzoScontato)*100)/100}€</span>
                    </td>
                    <td>
                        <div><button class="acquista" onclick="acquista('${memory.ID}')">Aggiungi al carrello</button></div>
                        <div><button name="aggiungiBuilder" class="acquista" type="button" onclick="addToBuilder('HDD/SSD', '${memory.ID}')">Aggiungi al builder</button></div>
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
            const tipologiaFilter = document.getElementById('tipologiaFilter').value;
            const interfacciaFilter = document.getElementById('interfacciaFilter').value;
            const capacitaFilter = document.getElementById('capacitaFilter').value;
            const minReadSpeed = parseFloat(document.getElementById('minReadSpeed').value) || 0;
            const maxReadSpeed = parseFloat(document.getElementById('maxReadSpeed').value) || Infinity;
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;

            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;

            rows.forEach(row => {
                const marca = row.cells[1].textContent.trim();
                const categoria = row.getAttribute('data-categoria');
                const tipologia = row.getAttribute('data-tipologia');
                const interfaccia = row.getAttribute('data-interfaccia');
                const capacita = row.getAttribute('data-capacita');
                const readSpeed = parseFloat(row.cells[7].textContent.replace('MB/s', '').trim());
                const prezzoElement = row.cells[9].querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;

                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                const matchesCategoria = categoriaFilter === '' || categoria === categoriaFilter;
                const matchesTipologia = tipologiaFilter === '' || tipologia === tipologiaFilter;
                const matchesInterfaccia = interfacciaFilter === '' || interfaccia === interfacciaFilter;
                const matchesCapacita = capacitaFilter === '' || capacita === capacitaFilter;
                const matchesReadSpeed = readSpeed >= minReadSpeed && (maxReadSpeed === Infinity || readSpeed <= maxReadSpeed);
                const matchesStato = statoFilter === '' ||
                    (statoFilter === 'disponibile' && isDisponibile) ||
                    (statoFilter === 'non-disponibile' && !isDisponibile);
                const matchesSconto = scontoFilter === '' ||
                    (scontoFilter === 'in-sconto' && sconto > 0) ||
                    (scontoFilter === 'no-sconto' && sconto === 0);

                if (matchesMarca && matchesPrezzo && matchesCategoria && matchesTipologia &&
                    matchesInterfaccia && matchesCapacita && matchesReadSpeed && matchesStato && matchesSconto) {
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
            document.getElementById('tipologiaFilter').value = '';
            document.getElementById('interfacciaFilter').value = '';
            document.getElementById('capacitaFilter').value = '';
            document.getElementById('minReadSpeed').value = '';
            document.getElementById('maxReadSpeed').value = '';
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
        document.getElementById('minReadSpeed').addEventListener('input', applyFilters);
        document.getElementById('maxReadSpeed').addEventListener('input', applyFilters);

        const selectElements = [
            document.getElementById('marcaFilter'),
            document.getElementById('categoriaFilter'),
            document.getElementById('tipologiaFilter'),
            document.getElementById('interfacciaFilter'),
            document.getElementById('capacitaFilter'),
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

        const columnsToHide = [1, 2, 3, 4, 5, 6, 7, 8, 11, 14]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('memory-table');

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