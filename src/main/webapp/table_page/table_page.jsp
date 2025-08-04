<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Foto.FotoDAO" %>
<%
    FotoDAO fotoDAO = new FotoDAO();
    request.setAttribute("fotoDAO",fotoDAO);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Build Your Dream - Elenco <%=request.getAttribute("table")%></title>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/table_page/style.css">
</head>
  <body>
  <%@ include file="/components/header.jsp"%>
  <%
  String type=(String) request.getAttribute("type");
  if(type.equals("pezzi")) {
      %>
  <div class="nav-bar">
      <div class="nav-components"> <!-- la barra di tutti gli oggetti della categoria-->
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('CPU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('CPU')">CPU
          </div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('GPU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('GPU')">GPU
          </div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('RAM')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('RAM')">RAM
          </div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('PSU')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('PSU')">PSU
          </div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('Motherboard')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Motherboard')">MotherBoard
          </div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('HDD/SSD')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('HDD/SSD')">HDD/SSD
          </div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('Cooling')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Cooling')">Cooling
          </div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('Case')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Case')">Case
          </div>
      </div>
  </div>
    <%
  }
  else {
    %>
  <div class="nav-bar">
      <div class="nav-components">
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('Headset')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Headset')">Headset</div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('Monitor')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Monitor')">Monitor</div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('Mouse')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Mouse')">Mouse</div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('StreamDeck')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('StreamDeck')">StreamDeck</div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('Tappetini')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Tappetini')">Tappetini</div>
          <div class="nav-item" role="button" tabindex="0" onclick="callTable('Tastiere')" onkeydown="if(event.key === 'Enter' || event.key === ' ') callTable('Tastiere')">Tastiere</div>
      </div>
  </div>
  <%
  }
  String table= (String) request.getAttribute("table");
  switch (table) {
      case "CPU":
          %><jsp:include page="/table_page/pezzi/CPU.jsp"/><%
          break;
      case "GPU":
          %><jsp:include page="/table_page/pezzi/GPU.jsp"/><%
          break;
      case "RAM":
          %><jsp:include page="/table_page/pezzi/RAM.jsp"/><%
          break;
      case "PSU":
          %><jsp:include page="/table_page/pezzi/PSU.jsp"/><%
          break;
      case "Motherboard":
          %><jsp:include page="/table_page/pezzi/Motherboard.jsp"/><%
          break;
      case "HDD/SSD":
          %><jsp:include page="/table_page/pezzi/Memory.jsp"/><%
          break;
      case "Cooling":
          %><jsp:include page="/table_page/pezzi/Cooling.jsp"/><%
          break;
      case "Case":
          %><jsp:include page="/table_page/pezzi/Case.jsp"/><%
          break;
      case "Headset":
          %><jsp:include page="/table_page/accessori/headset.jsp"/><%
          break;
      case "Monitor":
          %><jsp:include page="/table_page/accessori/monitor.jsp"/><%
          break;
      case "Mouse":
          %><jsp:include page="/table_page/accessori/mouse.jsp"/><%
          break;
      case "StreamDeck":
          %><jsp:include page="/table_page/accessori/streamdeck.jsp"/><%
          break;
      case "Tappetini":
          %><jsp:include page="/table_page/accessori/tappetino.jsp"/><%
          break;
      case "Tastiere":
          %><jsp:include page="/table_page/accessori/tastiera.jsp"/><%
          break;
  }
  %>
  <%@ include file="/components/footer.jsp"%>
  </body>
<script>
    function callTable(argument) { // quando voglio vedere un altro tipo di oggetto ricarica la pagina
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
        input2.value = '<%=request.getAttribute("type")%>';
        form.appendChild(input1);
        form.appendChild(input2);
        document.body.appendChild(form);
        form.submit();
    }



    function openImagePopup(imagePath, type, id) {
        // Se mobile, reindirizza. Se desktop, mostra pop-up con immagine.
        const isMobile = window.matchMedia("(max-width: 768px)").matches || 'ontouchstart' in window;
        if (isMobile) {
            // Su mobile reindirizza alla pagina prodotto
            window.location.href = '<%=request.getContextPath()%>/product?type=' + encodeURIComponent(type) + '&id=' + encodeURIComponent(id);
        } else {
            // Mostra pop-up con immagine
            let imagePopup = document.getElementById('imagePopup');
            if (!imagePopup) {
                imagePopup = document.createElement('div');
                imagePopup.id = 'imagePopup';
                imagePopup.className = 'image-popup';
                imagePopup.style.display = 'flex';
                imagePopup.style.position = 'fixed';
                imagePopup.style.top = '0';
                imagePopup.style.left = '0';
                imagePopup.style.width = '100vw';
                imagePopup.style.height = '100vh';
                imagePopup.style.background = 'rgba(0,0,0,0.8)';
                imagePopup.style.justifyContent = 'center';
                imagePopup.style.alignItems = 'center';
                imagePopup.style.zIndex = '9999';
                imagePopup.innerHTML = '<span class="close-popup" style="position:absolute;top:20px;right:40px;font-size:40px;color:white;cursor:pointer">&times;</span><img id="popupImg" src="" style="max-width:80vw;max-height:80vh;border-radius:10px;box-shadow:0 0 20px #000">';
                document.body.appendChild(imagePopup);
                imagePopup.querySelector('.close-popup').addEventListener('click', function() {
                    imagePopup.style.display = 'none';
                });
                imagePopup.addEventListener('click', function(event) {
                    if (event.target === imagePopup) {
                        imagePopup.style.display = 'none';
                    }
                });
                document.addEventListener('keydown', function(event) {
                    if (event.key === 'Escape' && imagePopup.style.display === 'flex') {
                        imagePopup.style.display = 'none';
                    }
                });
            } else {
                imagePopup.style.display = 'flex';
            }
            document.getElementById('popupImg').src = imagePath;
        }
    }

    function acquista(id) {
        const data = new URLSearchParams();
        data.append('id', id);
        data.append('type', '<%= request.getAttribute("type") %>');
        data.append('table', '<%= request.getAttribute("table") %>');
        data.append('coolingType','<%=request.getAttribute("coolingType")%>')

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

    <%  if(type.equals("pezzi")) {
        %>
    function addToBuilder(type, id) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = "<%=request.getContextPath()%>/addToBuilder";
        form.target='_self';
        const input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = 'type';
        input1.value = type;
        const input2 = document.createElement('input');
        input2.type = 'hidden';
        input2.name = 'ID';
        input2.value = id;
        form.appendChild(input1);
        form.appendChild(input2);
        document.body.appendChild(form);
        form.submit();
    }
    <%
    }%>

</script>
</html>
