<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/components/header.jsp" %>
<%FotoDAO fotoDAO=new FotoDAO();%>
<head>
    <title>Build Your Dream - PreBuilt</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/table_page/style.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/table_page/tableStyle.css">
</head>
<body>
<div class="nav-bar">
    <div class="nav-logo">PreBuilt</div>
</div>
<div class="data-container">
    <form class="filter-section" id="filterForm" method="get" action="prebuilt">
        <div class="filter-group">
            <h3>Prezzo</h3>
            <div class="filter-item price-range">
                <input type="number" id="minPrice" placeholder="Min €" min="0">
                <span>-</span>
                <input type="number" id="maxPrice" placeholder="Max €" min="0">
            </div>
        </div>
        <div class="filter-group">
            <h3>Marca</h3>
            <div class="filter-item">
                <select name="marca">
                    <option value="">Tutte</option>
                    <c:forEach items="${marche}" var="marca">
                        <option value="${marca}">${marca}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="filter-group">
            <h3>Processore</h3>
            <div class="filter-item">
                <select name="cpu">
                    <option value="">Tutti</option>
                    <c:forEach items="${cpus}" var="cpu">
                        <option value="${cpu}">${cpu}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="filter-group">
            <h3>GPU</h3>
            <div class="filter-item">
                <select name="gpu">
                    <option value="">Tutte</option>
                    <c:forEach items="${gpus}" var="gpu">
                        <option value="${gpu}">${gpu}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="filter-group">
            <h3>RAM</h3>
            <div class="filter-item">
                <select name="ram">
                    <option value="">Tutte</option>
                    <c:forEach items="${rams}" var="ram">
                        <option value="${ram}">${ram}GB</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="filter-group">
            <h3>Storage</h3>
            <div class="filter-item">
                <select name="storage">
                    <option value="">Tutti</option>
                    <c:forEach items="${disks}" var="disk">
                        <option value="${disk}">${disk}GB</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <button type="button" class="btn btn-secondary" onclick="resetFilters()">Reimposta filtri</button>
    </form>
    <div class="table-section" id="prebuilt-table">
        <table class="data-table">
            <thead>
            <tr>
                <th>Foto</th>
                <th>Nome</th>
                <th>Marca</th>
                <th>CPU</th>
                <th>GPU</th>
                <th>RAM</th>
                <th>Storage</th>
                <th>Prezzo</th>
                <th>Azioni</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${preBuilts}" var="preBuilt">
                <c:set var="button" value="${preBuilt.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
                <c:set var="buttonDisabled" value="${preBuilt.disponibilita>0 ? '':'disabled'}"/>
                <c:set var="prezzoClass" value="${preBuilt.sconto>0 ? 'prezzo-scontato' : ''}"/>
                <tr>
                    <c:set var="pID" value="${preBuilt.ID}" scope="request"/>
                    <td class="case-image"><img src="<%=request.getContextPath()%>/<%=fotoDAO.getFirstFotoOfPrebuilt((int) request.getAttribute("pID"),(String)request.getAttribute("path"))%>" alt="Foto PreBuilt" style="width:60px;height:60px;object-fit:cover;" role="button" tabindex="0" onclick="openPrebuilt(${preBuilt.ID})" onkeydown="if(event.key === 'Enter' || event.key === ' ') openPrebuilt(${preBuilt.ID})">
                    </td>
                    <td>${preBuilt.marca}</td>
                    <td>${preBuilt.modello}</td>
                    <td>${preBuilt.CPU}</td>
                    <td>${preBuilt.GPU}</td>
                    <td>${preBuilt.RAM}GB</td>
                    <td>${preBuilt.memory}GB</td>
                    <td class="${prezzoClass}">
                        <c:if test="${preBuilt.sconto>0}">
                            <span class="prezzo-originale">${Math.round(preBuilt.prezzo*100)/100}€</span>
                            <span class="sconto-badge">-${preBuilt.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale">${Math.round(preBuilt.prezzoScontato*100)/100}€</span>
                    </td>
                    <td><button class="acquista" ${buttonDisabled} onclick="acquista(${preBuilt.ID})">${button}</button></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    function applyFilters() {
        const minPrezzo = parseFloat(document.getElementById('minPrice').value) || 0;
        const maxPrezzo = parseFloat(document.getElementById('maxPrice').value) || Infinity;
        const marca = document.querySelector('select[name="marca"]').value;
        const cpu = document.querySelector('select[name="cpu"]').value;
        const gpu = document.querySelector('select[name="gpu"]').value;
        const ram = document.querySelector('select[name="ram"]').value;
        const storage = document.querySelector('select[name="storage"]').value;

        const rows = document.querySelectorAll('.data-table tbody tr');
        rows.forEach(row => {
            const tds = row.querySelectorAll('td');
            if (tds.length < 8) return;
            const rowMarca = tds[1].textContent.trim();
            const rowCPU = tds[3].textContent.trim();
            const rowGPU = tds[4].textContent.trim();
            const rowRAM = tds[5].textContent.replace('GB','').trim();
            const rowStorage = tds[6].textContent.replace('GB','').trim();
            const prezzoText = tds[7].querySelector('.prezzo-finale')?.textContent.replace('€','').replace(',', '.').trim() || "0";
            const prezzo = parseFloat(prezzoText) || 0;

            let show = true;
            if (marca && rowMarca !== marca) show = false;
            if (cpu && rowCPU !== cpu) show = false;
            if (gpu && rowGPU !== gpu) show = false;
            if (ram && rowRAM !== ram) show = false;
            if (storage && rowStorage !== storage) show = false;
            if (prezzo < minPrezzo || prezzo > maxPrezzo) show = false;

            row.style.display = show ? '' : 'none';
        });
    }

    function resetFilters() {
        document.getElementById('filterForm').reset();
        applyFilters();
    }

    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('filterForm');
        form.querySelectorAll('input, select').forEach(el => {
            el.addEventListener('input', applyFilters);
            el.addEventListener('change', applyFilters);
        });
        applyFilters();
    });

    function openPrebuilt(id) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = "preBuilt";
        form.target='_self';
        const input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = 'ID';
        input1.value = id;
        form.appendChild(input1);
        document.body.appendChild(form);
        form.submit();
    }

    function acquista(id) {
        const data = new URLSearchParams();
        data.append('id', id);
        data.append('type', 'preBuilt');

        fetch('<%= request.getContextPath() %>/addToCarrello', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data
        })
            .then(response => {
                if (!response.ok) throw new Error("Errore nella richiesta");
                return response.text(); // o .json() se il server restituisce JSON
            })
            .then(result => {
                document.getElementById('cartCount').innerHTML = parseInt(document.getElementById('cartCount').innerHTML) + 1;
                document.getElementById('cartCountMobile').innerHTML = parseInt(document.getElementById('cartCountMobile').innerHTML) + 1;
            })
            .catch(error => {
                console.error("Errore:", error);
            });
    }
    function adjustTableForMobile() {
        const isMobile = window.innerWidth <= 768;

        const columnsToHide = [1, 2, 3, 4, 5, 6]; // Indici delle colonne da nascondere (partendo da 0)
        const table = document.getElementById('prebuilt-table');

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
<%@ include file="/components/footer.jsp" %>
</body>
</html>
