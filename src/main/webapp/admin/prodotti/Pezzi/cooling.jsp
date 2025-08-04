<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Cooling - Admin</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/productStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/prodotti/accessibilityStyles.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
    <body>
        <div class="admin-back-btns" style="display: flex; gap: 24px; margin: 18px 0 0 18px; position: static;">
            <a href="<%=request.getContextPath()%>/adminPage" class="admin-back-btn btn-admin-area">&larr; Torna all'area admin</a>
            <a href="<%=request.getContextPath()%>/adminPage/gestioneProdotti?piece=pezzi" class="admin-back-btn btn-accessori">&larr; Torna indietro</a>
        </div>
        <div class="cooling-menu" style="display:flex; gap:20px; margin:30px 0 20px 0; justify-content:center;">
            <a onclick="selectCoolingType('airCooling')" class="admin-back-btn airCooling" tabindex="0" role="button">Air Cooling</a>
            <a onclick="selectCoolingType('liquidCooling')" class="admin-back-btn liquidCooling" tabindex="0" role="button">Liquid Cooling</a>
        </div>
        <%
        String cooling= (String) request.getAttribute("cooling");
        if(cooling==null || cooling.isEmpty()) {
            cooling="airCooling";
        }
        if(cooling.equals("airCooling")) {
            %>
        <div id="aircooling">
            <jsp:include page="aircooling.jsp" />
        </div>
        <%
        }
        else {
            %>
        <div id="liquidcooling">
            <jsp:include page="liquidcooling.jsp" />
        </div>
        <%
        }
        %>
    </body>
<script>
    function selectCoolingType(type) {
        const form = document.createElement('form');
        form.method = 'GET';
        form.action = "gestioneProdotti";
        form.target = '_self';

        const pezziInput = document.createElement('input');
        pezziInput.type = 'hidden';
        pezziInput.name = 'piece';
        pezziInput.value = 'pezzi';

        const typeInput = document.createElement('input');
        typeInput.type = 'hidden';
        typeInput.name = 'type';
        typeInput.value = 'Cooling';

        const coolingTypeInput = document.createElement('input');
        coolingTypeInput.type = 'hidden';
        coolingTypeInput.name = 'cooling';
        coolingTypeInput.value = type;

        form.appendChild(pezziInput);
        form.appendChild(typeInput);
        form.appendChild(coolingTypeInput);
        document.body.appendChild(form);
        form.submit();
    }
</script>
</html>
