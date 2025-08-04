<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Build Your Dream - Accessori</title>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/categoryStyle.css">
</head>
<body>
<%@ include file="../components/header.jsp" %>

<h1 class="page-title">Build Your Dream SETUP</h1>
<p class="subtitle">Completa la tua postazione con gli accessori giusti: scegli tra monitor, tastiere, mouse, tappetini e cavi per un’esperienza su misura.</p>

<div class="components-container" style="max-width: 1110px;">
    <div class="component-box" role="button" tabindex="0" onclick="callTable('Headset')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Headset')" style='background-image: url("<%=request.getContextPath()%>/media/Accessori/headset.jpeg")'>
        <div class="component-name">Headset</div>
    </div>

    <div class="component-box" role="button" tabindex="0" onclick="callTable('Monitor')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Monitor')" style='background-image: url("<%=request.getContextPath()%>/media/Accessori/monitor.jpeg")'>
        <div class="component-name">Monitor</div>
    </div>

    <div class="component-box" role="button" tabindex="0" onclick="callTable('Mouse')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Mouse')" style='background-image: url("<%=request.getContextPath()%>/media/Accessori/mouse.jpeg")'>
        <div class="component-name">Mouse</div>
    </div>

    <div class="component-box" role="button" tabindex="0" onclick="callTable('StreamDeck')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('StreamDeck')" style='background-image: url("<%=request.getContextPath()%>/media/Accessori/streamdeck.jpeg")'>
        <div class="component-name">Stream Deck</div>
    </div>

    <div class="component-box" role="button" tabindex="0" onclick="callTable('Tappetini')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Tappetini')" style='background-image: url("<%=request.getContextPath()%>/media/Accessori/tappetini.jpeg")'>
        <div class="component-name">Tappetino</div>
    </div>

    <div class="component-box" role="button" tabindex="0" onclick="callTable('Tastiere')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Tastiere')" style='background-image: url("<%=request.getContextPath()%>/media/Accessori/tastiera.jpeg")'>
        <div class="component-name">Tastiere</div>
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
        input2.value = 'accessori';
        form.appendChild(input1);
        form.appendChild(input2);
        document.body.appendChild(form);
        form.submit();
    }
</script>
</html>