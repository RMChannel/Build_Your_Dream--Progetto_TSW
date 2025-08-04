<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Build Your Dream - Pezzi</title>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/categoryStyle.css">
</head>
<body>
<%@ include file="../components/header.jsp" %>

<h1 class="page-title">Build Your Dream PC</h1>
<p class="subtitle">Seleziona i componenti per creare la configurazione perfetta per le tue esigenze</p>

<div class="components-container">
    <div class="component-box" role="button" tabindex="0" onclick="callTable('CPU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('CPU')" style='background-image: url("<%=request.getContextPath()%>/media/Pezzi/CPU.jpg")'>
        <div class="component-name">CPU</div>
    </div>
    <div class="component-box" role="button" tabindex="0" onclick="callTable('GPU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('GPU')" style='background-image: url("<%=request.getContextPath()%>/media/Pezzi/GPU.jpg")'>
        <div class="component-name">GPU</div>
    </div>
    <div class="component-box" role="button" tabindex="0" onclick="callTable('RAM')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('RAM')" style='background-image: url("<%=request.getContextPath()%>/media/Pezzi/RAM.jpeg")'>
        <div class="component-name">RAM</div>
    </div>
    <div class="component-box" role="button" tabindex="0" onclick="callTable('PSU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('PSU')" style='background-image: url("<%=request.getContextPath()%>/media/Pezzi/PSU.jpeg")'>
        <div class="component-name">PSU</div>
    </div>
    <div class="component-box" role="button" tabindex="0" onclick="callTable('Motherboard')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Motherboard')" style='background-image: url("<%=request.getContextPath()%>/media/Pezzi/motherboard.jpg")'>
        <div class="component-name">MotherBoard</div>
    </div>
    <div class="component-box" role="button" tabindex="0" onclick="callTable('HDD/SSD')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('HDD/SSD')" style='background-image: url("<%=request.getContextPath()%>/media/Pezzi/hddssd.jpg")'>
        <div class="component-name">SSD/HDD</div>
    </div>
    <div class="component-box" role="button" tabindex="0" onclick="callTable('Cooling')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Cooling')" style='background-image: url("<%=request.getContextPath()%>/media/Pezzi/Cooling.jpg")'>
        <div class="component-name">Cooling</div>
    </div>
    <div class="component-box" role="button" tabindex="0" onclick="callTable('Case')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Case')" style='background-image: url("<%=request.getContextPath()%>/media/Pezzi/Case.jpeg")'>
        <div class="component-name">Case</div>
    </div>
</div>

<%@ include file="../components/footer.jsp" %>
</body>
<script>
    function callTable(argument) {
        const form = document.createElement('form');
        form.method = 'GET';
        form.action = "table";
        form.target='_self';
        const input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = 'table';
        input1.value = argument;
        const input2 = document.createElement('input');
        input2.type = 'hidden';
        input2.name = 'type';
        input2.value = 'pezzi';
        form.appendChild(input1);
        form.appendChild(input2);
        document.body.appendChild(form);
        form.submit();
    }
</script>
</html>