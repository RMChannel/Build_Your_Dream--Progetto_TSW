<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Scegli Pezzo</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/categoryStyle.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,600,700|Poppins:400,600,700&display=swap" rel="stylesheet">
    <style>
        body, .page-title, .component-name, .admin-back-btn {
            font-family: 'Poppins', 'Montserrat', 'Segoe UI', 'Roboto', Tahoma, Geneva, Verdana, sans-serif !important;
        }
    </style>
</head>
<body style="min-height:100vh; background: linear-gradient(120deg, #e3eafc 0%, #b3c6e7 100%);">
    <a href="<%=request.getContextPath()%>/adminPage/gestioneProdotti" class="admin-back-btn" title="Torna indietro">
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" style="vertical-align:middle; margin-right:6px;"><path d="M13.5 17L8 11L13.5 5" stroke="#0074D9" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/></svg>
        Indietro
    </a>
    <h1 class="page-title" style="margin-top: 40px;">Scegli la categoria del pezzo</h1>
    <div class="components-container" style="max-width: 1110px; margin-top: 30px;">
        <div class="component-box" role="button" tabindex="0" onclick="callTable('CPU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('CPU'); }" style="background-image: url('<%=request.getContextPath()%>/media/Pezzi/CPU.jpg')">
            <div class="component-name">CPU</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('GPU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('GPU'); }" style="background-image: url('<%=request.getContextPath()%>/media/Pezzi/GPU.jpg')">
            <div class="component-name">GPU</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('RAM')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('RAM'); }" style="background-image: url('<%=request.getContextPath()%>/media/Pezzi/RAM.jpeg')">
            <div class="component-name">RAM</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('PSU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('PSU'); }" style="background-image: url('<%=request.getContextPath()%>/media/Pezzi/PSU.jpeg')">
            <div class="component-name">PSU</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('Motherboard')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('Motherboard'); }" style="background-image: url('<%=request.getContextPath()%>/media/Pezzi/motherboard.jpg')">
            <div class="component-name">MotherBoard</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('HDD/SSD')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('HDD/SSD'); }" style="background-image: url('<%=request.getContextPath()%>/media/Pezzi/hddssd.jpg')">
            <div class="component-name">HDD/SSD</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('Cooling')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('Cooling'); }" style="background-image: url('<%=request.getContextPath()%>/media/Pezzi/Cooling.jpg')">
            <div class="component-name">Cooling</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('Case')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('Case'); }" style="background-image: url('<%=request.getContextPath()%>/media/Pezzi/Case.jpeg')">
            <div class="component-name">Case</div>
        </div>
    </div>
    <script>
        function callTable(argument) {
            const form = document.createElement('form');
            form.method = 'GET';
            form.action = "<%=request.getContextPath()%>/adminPage/gestioneProdotti";
            form.target='_self';
            const input1 = document.createElement('input');
            input1.type = 'hidden';
            input1.name = 'piece';
            input1.value = '<%=request.getAttribute("piece")%>';
            const input2 = document.createElement('input');
            input2.type = 'hidden';
            input2.name = 'type';
            input2.value = argument;
            form.appendChild(input1);
            form.appendChild(input2);
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>
