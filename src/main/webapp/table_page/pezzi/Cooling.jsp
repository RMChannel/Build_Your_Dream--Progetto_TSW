<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/table_page/tableStyle.css">

<div class="nav-bar">
    <div class="nav-components">
        <div class="nav-item" role="button" tabindex="0" onclick="selectCoolingType('liquid')" onkeydown="if(event.key === 'Enter' || event.key === ' ') selectCoolingType('liquid')">Liquid Cooling
        </div>
        <div class="nav-item" role="button" tabindex="0" onclick="selectCoolingType('air')" onkeydown="if(event.key === 'Enter' || event.key === ' ') selectCoolingType('air')">Air Cooling
        </div>
    </div>
</div>

<%
    String coolingType = request.getParameter("coolingType");
    if (coolingType == null) {
        coolingType = "liquid";
    }
    if (coolingType.equals("liquid")) {
        %><jsp:include page="/table_page/pezzi/Cooling/LiquidCooling.jsp"/><%
    } else if (coolingType.equals("air")) {
        %><jsp:include page="/table_page/pezzi/Cooling/AirCooling.jsp"/><%
    }
    request.setAttribute("coolingType",coolingType);
%>

<script>
    function selectCoolingType(type) {
        const form = document.createElement('form');
        form.method = 'GET';
        form.action = "table";
        form.target = '_self';

        const tableInput = document.createElement('input');
        tableInput.type = 'hidden';
        tableInput.name = 'table';
        tableInput.value = 'Cooling';

        const typeInput = document.createElement('input');
        typeInput.type = 'hidden';
        typeInput.name = 'type';
        typeInput.value = 'pezzi';

        const coolingTypeInput = document.createElement('input');
        coolingTypeInput.type = 'hidden';
        coolingTypeInput.name = 'coolingType';
        coolingTypeInput.value = type;

        form.appendChild(tableInput);
        form.appendChild(typeInput);
        form.appendChild(coolingTypeInput);
        document.body.appendChild(form);
        form.submit();
    }

</script>