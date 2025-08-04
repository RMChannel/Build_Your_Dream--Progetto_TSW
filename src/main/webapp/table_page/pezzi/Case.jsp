<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Foto.FotoDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/tableStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/style.css">
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

    <div class="table-section" id="case-table">
        <h2 style="padding: 20px 20px 0">Elenco <%=request.getAttribute("table")%></h2>
        <div class="filtered-count"></div>
        <table class="data-table">
            <thead>
            <tr>
                    <th>Immagine</th>
                    <th>Marca</th>
                    <th>Modello</th>
                    <th>Categoria</th>
                    <th>Altezza (mm)</th>
                    <th>Larghezza (mm)</th>
                    <th>Profondità (mm)</th>
                    <th>Peso (kg)</th>
                    <th>Dotazione</th>
                    <th>Prezzo</th>
                    <th>Acquista</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${piecies}" var="item">
                    <c:set var="button" value="${item.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                    <c:set var="buttonDisabled" value="${item.disponibilita>0 ? '':'disabled'}"/>
                    <c:set var="prezzoClass" value="${item.sconto>0 ? 'prezzo-scontato' : ''}"/>
                    <tr data-sconto="${item.sconto}" data-disponibile="${item.disponibilita>0 ? 'true' : 'false'}"
                        data-altezza="${item.altezza}" data-larghezza="${item.larghezza}" data-profondita="${item.profondita}">
                        <td class="case-image">
                            <c:set var="caseId" value="${item.ID}" scope="request"/>
                            <%
                                FotoDAO fotoDAO=(FotoDAO) request.getAttribute("fotoDAO");
                                Object caseId = request.getAttribute("caseId");
                                String imagePath = fotoDAO.getFoto((Integer) caseId, "fotoPezzi", "Case", (String) request.getAttribute("path"));
                            %>
                            <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${item.marca}_${item.modello}" width="80" style="cursor:pointer;" role="button" tabindex="0" onclick="openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Case', '${item.ID}')" onkeydown="if(event.key === 'Enter' || event.key === ' ') openImagePopup('<%=request.getContextPath()%>/<%=imagePath%>', 'Case', '${item.ID}')">
                        </td>
                    <td>${item.marca}</td>
                    <td>${item.modello}</td>
                    <td>${item.categoria}</td>
                    <td>${item.altezza}</td>
                    <td>${item.larghezza}</td>
                    <td>${item.profondita}</td>
                    <td>${item.peso}</td>
                    <td>${item.dotazione}</td>
                    <td class="${prezzoClass}">
                        <c:if test="${item.sconto>0}">
                            <span class="prezzo-originale">${Math.round(item.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${item.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.round(item.prezzoScontato*100)/100}€</span>
                    </td>
                    <td>
                        <div><button class="acquista ${buttonDisabled}" name="acquista" type="button" value="${button}" ${buttonDisabled} onclick="acquista('${item.ID}')">${button}</button></div>

                        <div><button name="aggiungiBuilder" class="acquista" type="button" onclick="addToBuilder('Case', '${item.ID}')">Aggiungi al builder</button> </div>
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
            const statoFilter = document.getElementById('statoFilter').value;
            const scontoFilter = document.getElementById('scontoFilter').value;

            const rows = document.querySelectorAll('.data-table tbody tr');
            visibleRows = 0;

            rows.forEach(row => {
                const marca = row.cells[1].textContent.trim();
                const categoria = row.cells[3].textContent.trim();
                const prezzoElement = row.cells[9].querySelector('.prezzo-finale');
                const prezzo = parseFloat(prezzoElement.textContent.replace('€', '').trim());
                const isDisponibile = row.getAttribute('data-disponibile') === 'true';
                const sconto = parseInt(row.getAttribute('data-sconto')) || 0;

                const matchesMarca = marcaFilter === '' || marca === marcaFilter;
                const matchesPrezzo = prezzo >= minPrice && (maxPrice === Infinity || prezzo <= maxPrice);
                const matchesCategoria = categoriaFilter === '' || categoria === categoriaFilter;
                const matchesStato = statoFilter === '' ||
                    (statoFilter === 'disponibile' && isDisponibile) ||
                    (statoFilter === 'non-disponibile' && !isDisponibile);
                const matchesSconto = scontoFilter === '' ||
                    (scontoFilter === 'in-sconto' && sconto > 0) ||
                    (scontoFilter === 'no-sconto' && sconto === 0);

                if (matchesMarca && matchesPrezzo && matchesCategoria && matchesStato && matchesSconto) {
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
            document.getElementById('categoriaFilter'),
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

        const columnsToHide = [1, 2, 3, 4, 5, 6, 7, 8, 11]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('case-table');

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