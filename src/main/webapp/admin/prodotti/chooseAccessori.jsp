<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Scegli Accessorio</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/categoryStyle.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body style="min-height:100vh; background: linear-gradient(120deg, #e3eafc 0%, #b3c6e7 100%);">
    <a href="<%=request.getContextPath()%>/adminPage/gestioneProdotti" class="admin-back-btn" title="Torna indietro">
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" style="vertical-align:middle; margin-right:6px;"><path d="M13.5 17L8 11L13.5 5" stroke="#0074D9" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/></svg>
        Indietro
    </a>
    <h1 class="page-title" style="margin-top: 40px;">Scegli la categoria dell'accessorio</h1>
    <div class="components-container" style="max-width: 1110px; margin-top: 30px;">
        <div class="component-box" role="button" tabindex="0" onclick="callTable('Headset')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('Headset'); }" style="background-image: url('<%=request.getContextPath()%>/media/Accessori/headset.jpeg')">
            <div class="component-name">Headset</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('Monitor')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('Monitor'); }" style="background-image: url('<%=request.getContextPath()%>/media/Accessori/monitor.jpeg')">
            <div class="component-name">Monitor</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('Mouse')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('Mouse'); }" style="background-image: url('<%=request.getContextPath()%>/media/Accessori/mouse.jpeg')">
            <div class="component-name">Mouse</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('StreamDeck')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('StreamDeck'); }" style="background-image: url('<%=request.getContextPath()%>/media/Accessori/streamdeck.jpeg')">
            <div class="component-name">Stream Deck</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('Tappetini')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('Tappetini'); }" style="background-image: url('<%=request.getContextPath()%>/media/Accessori/tappetini.jpeg')">
            <div class="component-name">Tappetino</div>
        </div>
        <div class="component-box" role="button" tabindex="0" onclick="callTable('Tastiere')" onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); callTable('Tastiere'); }" style="background-image: url('<%=request.getContextPath()%>/media/Accessori/tastiera.jpeg')">
            <div class="component-name">Tastiere</div>
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
