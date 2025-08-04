<%@ page import="Foto.FotoDAO" %>
<%FotoDAO fotoDAO=new FotoDAO();%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Build Your Dream - Builder</title>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/builder/builder.css">
</head>
<%@ include file="/components/header.jsp"%>
<body>
<div class="builder-table-container">
    <h1>PC Builder</h1>
    <table class="builder-list data-table">
        <thead>
        <tr>
            <th>Categoria</th>
            <th>Foto</th>
            <th>Marca</th>
            <th>Modello</th>
            <th>Prezzo</th>
            <th>Disponibilità</th>
            <th>Azioni</th>
        </tr>
        </thead>
        <tbody>
        <!-- CPU -->
        <tr>
            <td>CPU</td>
            <c:choose>
                <c:when test="${empty builder.cpu}">
                    <td colspan="5" style="text-align:center;">Nessuna CPU selezionata</td>
                    <td><button class="add-btn" onclick="changePage('CPU')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td class="cpu-image">
                        <c:set var="cpuId" value="${builder.cpu.ID}" scope="request"/>
                        <%
                            Object cpuId = request.getAttribute("cpuId");
                            String imagePath = fotoDAO.getFoto((Integer) cpuId, "fotoPezzi", "CPU", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${cpu.marca}_${cpu.modello}" width="80">
                    </td>
                    <td>${builder.cpu.marca}</td>
                    <td>${builder.cpu.modello}</td>
                    <td>
                        <c:if test="${builder.cpu.sconto>0}">
                            <span class="prezzo-originale"><fmt:formatNumber value="${builder.cpu.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                            <span class="sconto-badge">-${builder.cpu.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale"><fmt:formatNumber value="${builder.cpu.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${builder.cpu.disponibilita > 0}">
                                <span class="disponibile">Disponibile</span>
                            </c:when>
                            <c:otherwise>
                                <span class="non-disponibile">Non disponibile</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><button class="remove-btn" onclick="removePezzo('CPU', '${builder.cpu.ID}')">Rimuovi</button></td>
                </c:otherwise>
            </c:choose>
        </tr>
        <!-- GPU -->
        <tr>
            <td>GPU</td>
            <c:choose>
                <c:when test="${empty builder.gpu}">
                    <td colspan="5" style="text-align:center;">Nessuna GPU selezionata</td>
                    <td><button class="add-btn" onclick="changePage('GPU')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td class="cpu-image"><c:set var="gpuId" value="${builder.gpu.ID}" scope="request"/>
                        <%
                            Object gpuId = request.getAttribute("gpuId");
                            String imagePath = fotoDAO.getFoto((Integer) gpuId, "fotoPezzi", "GPU", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${builder.gpu.marca}_${builder.gpu.modello}" width="80"></td>
                    <td>${builder.gpu.marca}</td>
                    <td>${builder.gpu.modello}</td>
                    <td>
                        <c:if test="${builder.gpu.sconto>0}">
                            <span class="prezzo-originale"><fmt:formatNumber value="${builder.gpu.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                            <span class="sconto-badge">-${builder.gpu.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale"><fmt:formatNumber value="${builder.gpu.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${builder.gpu.disponibilita > 0}">
                                <span class="disponibile">Disponibile</span>
                            </c:when>
                            <c:otherwise>
                                <span class="non-disponibile">Non disponibile</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><button class="remove-btn" onclick="removePezzo('GPU', '${builder.gpu.ID}')">Rimuovi</button></td>
                </c:otherwise>
            </c:choose>
        </tr>
        <!-- PSU -->
        <tr>
            <td>PSU</td>
            <c:choose>
                <c:when test="${empty builder.psu}">
                    <td colspan="5" style="text-align:center;">Nessuna PSU selezionata</td>
                    <td><button class="add-btn" onclick="changePage('PSU')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td class="cpu-image"><c:set var="psuId" value="${builder.psu.ID}" scope="request"/>
                        <%
                            Object psuId = request.getAttribute("psuId");
                            String imagePath = fotoDAO.getFoto((Integer) psuId, "fotoPezzi", "PSU", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${builder.psu.marca}_${builder.psu.modello}" width="80"></td>
                    <td>${builder.psu.marca}</td>
                    <td>${builder.psu.modello}</td>
                    <td>
                        <c:if test="${builder.psu.sconto>0}">
                            <span class="prezzo-originale"><fmt:formatNumber value="${builder.psu.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                            <span class="sconto-badge">-${builder.psu.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale"><fmt:formatNumber value="${builder.psu.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${builder.psu.disponibilita > 0}">
                                <span class="disponibile">Disponibile</span>
                            </c:when>
                            <c:otherwise>
                                <span class="non-disponibile">Non disponibile</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><button class="remove-btn" onclick="removePezzo('PSU', '${builder.psu.ID}')">Rimuovi</button></td>
                </c:otherwise>
            </c:choose>
        </tr>
        <!-- Motherboard -->
        <tr>
            <td>Motherboard</td>
            <c:choose>
                <c:when test="${empty builder.motherboard}">
                    <td colspan="5" style="text-align:center;">Nessuna Motherboard selezionata</td>
                    <td><button class="add-btn" onclick="changePage('Motherboard')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td class="cpu-image"><c:set var="motherboardId" value="${builder.motherboard.ID}" scope="request"/>
                        <%
                            Object motherboardId = request.getAttribute("motherboardId");
                            String imagePath = fotoDAO.getFoto((Integer) motherboardId, "fotoPezzi", "Motherboard", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${builder.motherboard.marca}_${builder.motherboard.modello}" width="80"></td>
                    <td>${builder.motherboard.marca}</td>
                    <td>${builder.motherboard.modello}</td>
                    <td>
                        <c:if test="${builder.motherboard.sconto>0}">
                            <span class="prezzo-originale"><fmt:formatNumber value="${builder.motherboard.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                            <span class="sconto-badge">-${builder.motherboard.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale"><fmt:formatNumber value="${builder.motherboard.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${builder.motherboard.disponibilita > 0}">
                                <span class="disponibile">Disponibile</span>
                            </c:when>
                            <c:otherwise>
                                <span class="non-disponibile">Non disponibile</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><button class="remove-btn" onclick="removePezzo('Motherboard', '${builder.motherboard.ID}')">Rimuovi</button></td>
                </c:otherwise>
            </c:choose>
        </tr>
        <!-- Case -->
        <tr>
            <td>Case</td>
            <c:choose>
                <c:when test="${empty builder.case2}">
                    <td colspan="5" style="text-align:center;">Nessun Case selezionato</td>
                    <td><button class="add-btn" onclick="changePage('Case')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td class="cpu-image"><c:set var="caseId" value="${builder.case2.ID}" scope="request"/>
                        <%
                            Object caseId = request.getAttribute("caseId");
                            String imagePath = fotoDAO.getFoto((Integer) caseId, "fotoPezzi", "Case", (String) request.getAttribute("path"));
                        %>
                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${builder.case2.marca}_${builder.case2.modello}" width="80"></td>
                    <td>${builder.case2.marca}</td>
                    <td>${builder.case2.modello}</td>
                    <td>
                        <c:if test="${builder.case2.sconto>0}">
                            <span class="prezzo-originale"><fmt:formatNumber value="${builder.case2.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                            <span class="sconto-badge">-${builder.case2.sconto}%</span>
                        </c:if>
                        <span class="prezzo-finale"><fmt:formatNumber value="${builder.case2.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${builder.case2.disponibilita > 0}">
                                <span class="disponibile">Disponibile</span>
                            </c:when>
                            <c:otherwise>
                                <span class="non-disponibile">Non disponibile</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><button class="remove-btn" onclick="removePezzo('Case', '${builder.case2.ID}')">Rimuovi</button></td>
                </c:otherwise>
            </c:choose>
        </tr>
        <!-- Memory (multi) -->
        <tr>
            <td>Memory (HDD/SSD)</td>
            <c:choose>
                <c:when test="${empty builder.memories}">
                    <td colspan="5" style="text-align:center;">Nessuna memoria selezionata</td>
                    <td><button class="add-btn" onclick="changePage('HDD/SSD')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td colspan="6">
                        <table style="width:100%; background:transparent;">
                            <c:forEach var="mem" items="${builder.memories}">
                                <tr>
                                    <td class="cpu-image"><c:set var="memeId" value="${mem.ID}" scope="request"/>
                                        <%
                                            Object memeId = request.getAttribute("memeId");
                                            String imagePath = fotoDAO.getFoto((Integer) memeId, "fotoPezzi", "Memory", (String) request.getAttribute("path"));
                                        %>
                                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${mem.marca}_${mem.modello}" width="80"></td>
                                    <td>${mem.marca}</td>
                                    <td>${mem.modello}</td>
                                    <td>
                                        <c:if test="${mem.sconto>0}">
                                            <span class="prezzo-originale"><fmt:formatNumber value="${mem.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                                            <span class="sconto-badge">-${mem.sconto}%</span>
                                        </c:if>
                                        <span class="prezzo-finale"><fmt:formatNumber value="${mem.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${mem.disponibilita > 0}">
                                                <span class="disponibile">Disponibile</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="non-disponibile">Non disponibile</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><button class="remove-btn" onclick="removePezzo('HDD/SSD', '${mem.ID}')">Rimuovi</button> <button class="add-btn" onclick="changePage('HDD/SSD')">Aggiungi</button></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </c:otherwise>
            </c:choose>
        </tr>
        <!-- Liquid Cooling (multi) -->
        <tr>
            <td>Liquid Cooling</td>
            <c:choose>
                <c:when test="${empty builder.liquidCoolings}">
                    <td colspan="5" style="text-align:center;">Nessun liquidCooling selezionato</td>
                    <td><button class="add-btn" onclick="changePage('liquidCooling')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td colspan="6">
                        <table style="width:100%; background:transparent;">
                            <c:forEach var="liq" items="${builder.liquidCoolings}">
                                <tr>
                                    <td class="cpu-image"><c:set var="liquidId" value="${liq.ID}" scope="request"/>
                                        <%
                                            Object liquidId = request.getAttribute("liquidId");
                                            String imagePath = fotoDAO.getFoto((Integer) liquidId, "fotoPezzi", "LiquidCooling", (String) request.getAttribute("path"));
                                        %>
                                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${liq.marca}_${liq.modello}" width="80"></td>
                                    <td>${liq.marca}</td>
                                    <td>${liq.modello}</td>
                                    <td>
                                        <c:if test="${liq.sconto>0}">
                                            <span class="prezzo-originale"><fmt:formatNumber value="${liq.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                                            <span class="sconto-badge">-${liq.sconto}%</span>
                                        </c:if>
                                        <span class="prezzo-finale"><fmt:formatNumber value="${liq.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${liq.disponibilita > 0}">
                                                <span class="disponibile">Disponibile</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="non-disponibile">Non disponibile</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><button class="remove-btn" onclick="removePezzo('LiquidCooling', '${liq.ID}')">Rimuovi</button> <button class="add-btn" onclick="changePage('liquidCooling')">Aggiungi</button></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </c:otherwise>
            </c:choose>
        </tr>
        <!-- Air Cooling (multi) -->
        <tr>
            <td>Air Cooling</td>
            <c:choose>
                <c:when test="${empty builder.airCoolings}">
                    <td colspan="5" style="text-align:center;">Nessun airCooling selezionato</td>
                    <td><button class="add-btn" onclick="changePage('airCooling')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td colspan="6">
                        <table style="width:100%; background:transparent;">
                            <c:forEach var="air" items="${builder.airCoolings}">
                                <tr>
                                    <td class="cpu-image"><c:set var="airId" value="${air.ID}" scope="request"/>
                                        <%
                                            Object airId = request.getAttribute("airId");
                                            String imagePath = fotoDAO.getFoto((Integer) airId, "fotoPezzi", "AirCooling", (String) request.getAttribute("path"));
                                        %>
                                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${air.marca}_${air.modello}" width="80"></td>
                                    <td>${air.marca}</td>
                                    <td>${air.modello}</td>
                                    <td>
                                        <c:if test="${air.sconto>0}">
                                            <span class="prezzo-originale"><fmt:formatNumber value="${air.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                                            <span class="sconto-badge">-${air.sconto}%</span>
                                        </c:if>
                                        <span class="prezzo-finale"><fmt:formatNumber value="${air.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${air.disponibilita > 0}">
                                                <span class="disponibile">Disponibile</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="non-disponibile">Non disponibile</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><button class="remove-btn" onclick="removePezzo('AirCooling', '${air.ID}')">Rimuovi</button> <button class="add-btn" onclick="changePage('airCooling')">Aggiungi</button></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </c:otherwise>
            </c:choose>
        </tr>
        <!-- RAM (multi) -->
        <tr>
            <td>RAM</td>
            <c:choose>
                <c:when test="${empty builder.rams}">
                    <td colspan="5" style="text-align:center;">Nessuna RAM selezionata</td>
                    <td><button class="add-btn" onclick="changePage('RAM')">Aggiungi</button></td>
                </c:when>
                <c:otherwise>
                    <td colspan="6">
                        <table style="width:100%; background:transparent;">
                            <c:forEach var="ram" items="${builder.rams}">
                                <tr>
                                    <td class="cpu-image"><c:set var="ramId" value="${ram.ID}" scope="request"/>
                                        <%
                                            Object ramId = request.getAttribute("ramId");
                                            String imagePath = fotoDAO.getFoto((Integer) ramId, "fotoPezzi", "RAM", (String) request.getAttribute("path"));
                                        %>
                                        <img src="<%=request.getContextPath()%>/<%=imagePath%>" alt="${ram.marca}_${ram.modello}" width="80"></td>
                                    <td>${ram.marca}</td>
                                    <td>${ram.modello}</td>
                                    <td>
                                        <c:if test="${ram.sconto>0}">
                                            <span class="prezzo-originale"><fmt:formatNumber value="${ram.prezzo}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                                            <span class="sconto-badge">-${ram.sconto}%</span>
                                        </c:if>
                                        <span class="prezzo-finale"><fmt:formatNumber value="${ram.prezzoScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ram.disponibilita > 0}">
                                                <span class="disponibile">Disponibile</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="non-disponibile">Non disponibile</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><button class="remove-btn" onclick="removePezzo('RAM', '${ram.ID}')">Rimuovi</button> <button class="add-btn" onclick="changePage('RAM')">Aggiungi</button></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </c:otherwise>
            </c:choose>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <div style="margin-top: 30px; text-align: center;">
                <c:choose>
                    <c:when test="${empty compatibilita}">
                        <span style="color: #1dbf1d; font-weight: bold; font-size: 1.1em;">La build è compatibile con tutti i componenti suoi all'interno</span>
                    </c:when>
                    <c:otherwise>
                <span style="color: #e53935; font-weight: bold; font-size: 1.1em; white-space: pre-line;">
                    <c:forEach var="msg" items="${compatibilita}">
                        ${msg}<br/>
                    </c:forEach>
                </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </tr>
        <tr>
            <td colspan="4" style="text-align:right;font-weight:bold;">Totale:</td>
            <td colspan="2">
            <span class="prezzo-finale" style="font-size:1.2em;">
                <c:if test="${totaleOriginale > totaleScontato}">
                    <span class="prezzo-originale"><fmt:formatNumber value="${totaleOriginale}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
                    <span class="sconto-badge">- <fmt:formatNumber value="${(100-(totaleScontato/totaleOriginale)*100)}" type="number" maxFractionDigits="0"/>%</span>
                </c:if>
                <span class="prezzo-finale" style="font-size:1.3em;"><fmt:formatNumber value="${totaleScontato}" type="number" minFractionDigits="2" maxFractionDigits="2"/>€</span>
            </span>
            </td>
        </tr>
        </tfoot>
    </table>
    <div style="text-align: center; margin-top: 20px;">
        <button class="remove-btn" onclick="removeAll()">Rimuovi tutti i componenti</button>
        <button class="add-btn" onclick="addBuildToCarrello()">Aggiungi build al carrello</button>
    </div>
    <div style="clear:both;"></div>
    <div style="margin: 40px 0 0 0; text-align: center; display: flex;">
        <input id="buildNameInput" type="text" placeholder="Nome build.." style="padding: 10px; font-size: 1.1em; width: 250px; border-radius: 6px; border: 1px solid #ccc;" value="${buildName != null ? buildName : ''}">
        <button id="saveBuildBtn" class="add-btn" style="margin-left: 10px;">Salva build</button>
        <div id="saveBuildMsg" style="margin-top: 10px; font-weight: bold;"></div>
    </div>
</div>
</body>
<script>
    function changePage(table) {
        const form = document.createElement('form');
        form.method = 'GET';
        form.action = "<%=request.getContextPath()%>/table";
        form.target='_self';
        const input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = 'type';
        input1.value = 'pezzi';
        const input2 = document.createElement('input');
        input2.type = 'hidden';
        input2.name = 'table';
        const input3 = document.createElement('input');
        input3.type = 'hidden';
        input3.name = 'coolingType';
        if(table==="liquidCooling" || table==="airCooling") {
            input2.value = "Cooling";
            if(table==="liquidCooling") {
                input3.value = "liquid";
            }
            else {
                input3.value = "air";
            }
            form.append(input3);
        }
        else {
            input2.value = table;
        }
        form.appendChild(input1);
        form.appendChild(input2);
        document.body.appendChild(form);
        form.submit();
    }

    function removePezzo(type, id) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = "<%=request.getContextPath()%>/removeFromBuild";
        form.target='_self';
        const input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = 'type';
        input1.value = type;
        const input2 = document.createElement('input');
        input2.type = 'hidden';
        input2.name = 'id';
        input2.value = id;
        form.appendChild(input1);
        form.appendChild(input2);
        document.body.appendChild(form);
        form.submit();
    }

    function removeAll() {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = "<%=request.getContextPath()%>/removeAllFromBuild";
        form.target='_self';
        document.body.appendChild(form);
        form.submit();
    }

    function addBuildToCarrello() {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = "<%=request.getContextPath()%>/buildToCarrello";
        form.target = '_self';
        document.body.appendChild(form);
        form.submit();
    }

    document.getElementById('saveBuildBtn').addEventListener('click', function() {
        const buildName = document.getElementById('buildNameInput').value.trim();
        const msgDiv = document.getElementById('saveBuildMsg');
        msgDiv.textContent = '';
        msgDiv.style.color = '';
        if (!buildName) {
            msgDiv.textContent = 'Inserisci un nome per la build.';
            msgDiv.style.color = '#e53935';
            return;
        }
        fetch('<%=request.getContextPath()%>/saveBuild', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'nome=' + encodeURIComponent(buildName)
        })
            .then(response => response.json())
            .then(data => {
                if (data.error === 1) {
                    msgDiv.style.color = '#e53935';
                } else {
                    msgDiv.style.color = '#1dbf1d';
                }
                msgDiv.textContent = data.message;
            })
            .catch(() => {
                msgDiv.textContent = 'Errore di comunicazione con il server.';
                msgDiv.style.color = '#e53935';
            });
    });
</script>
<%@ include file="/components/footer.jsp"%>
</html>