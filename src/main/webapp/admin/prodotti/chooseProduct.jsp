<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Scegli Categoria Prodotto</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/chooseProduct.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body style="min-height:100vh; background: linear-gradient(120deg, #e3eafc 0%, #b3c6e7 100%);">
    <a href="<%=request.getContextPath()%>/adminPage" class="admin-back-btn" title="Torna indietro">
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" style="vertical-align:middle; margin-right:6px;"><path d="M13.5 17L8 11L13.5 5" stroke="#0074D9" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/></svg>
        Indietro
    </a>
    <div style="display:flex; justify-content:center; align-items:center; min-height:80vh; gap:48px;">
        <button class="choose-vertical-btn" style="background-image:url('<%=request.getContextPath()%>/media/HomePage/accessories.jpeg');" onclick="changePage('accessori')">
            <span>Accessori</span>
        </button>
        <button class="choose-vertical-btn" style="background-image:url('<%=request.getContextPath()%>/media/HomePage/pezzi.jpeg');" onclick="changePage('pezzi')">
            <span>Pezzi</span>
        </button>
        <button class="choose-vertical-btn" style="background-image:url('<%=request.getContextPath()%>/media/HomePage/build.jpeg');" onclick="changePage('prebuilt')">
            <span>Prebuilt</span>
        </button>
    </div>
</body>
<script>
    function changePage(piece) {
        const form = document.createElement('form');
        form.method = 'GET';
        form.action = "<%=request.getContextPath()%>/adminPage/gestioneProdotti";
        form.target='_self';
        const input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = 'piece';
        input1.value = piece;
        form.appendChild(input1);
        document.body.appendChild(form);
        form.submit();
    }
</script>
</html>
