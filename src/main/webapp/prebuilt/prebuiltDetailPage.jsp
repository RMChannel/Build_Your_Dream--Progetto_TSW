<%@ page import="Foto.FotoDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%FotoDAO fotoDAO=new FotoDAO();%>
<html>
  <head>
    <title>Build Your Dream - Dettagli ${prebuilt.marca}</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/prebuilt/prebuiltDetailPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/headerStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/footerStyle.css">
  </head>
  <body>
    <%@ include file="/components/header.jsp" %>
    <div class="prebuilt-detail-container">
        <div class="prebuilt-gallery">
            <c:set var="pID" value="${prebuilt.ID}" scope="request"/>
            <img id="galleryPhoto" class="gallery-photo" src="<%=request.getContextPath()%>/<%=fotoDAO.getFirstFotoOfPrebuilt((int) request.getAttribute("pID"),(String)request.getAttribute("path"))%>" alt="Foto Prebuilt" />
            <div>
              <button class="gallery-btn prev" onclick="changePhoto(-1)">&#10094;</button>
              <button class="gallery-btn next" onclick="changePhoto(1)">&#10095;</button>
            </div>
        </div>
        <div class="prebuilt-info">
            <div class="prebuilt-brand-model">
                <span class="prebuilt-brand">${prebuilt.marca}</span>
                <span class="prebuilt-model">${prebuilt.modello}</span>
            </div>
            <div class="prebuilt-description">
                ${prebuilt.descrizione}
            </div>
            <div class="prebuilt-prezzo-section ${prebuilt.sconto>0 ? 'prezzo-scontato' : ''}">
                <c:if test="${prebuilt.sconto>0}">
                    <span class="prezzo-originale">${Math.round(prebuilt.prezzo*100)/100}€</span>
                    <span class="sconto-badge">-${prebuilt.sconto}%</span>
                </c:if>
                <span class="prezzo-finale">${Math.round(prebuilt.prezzoScontato*100)/100}€</span>
            </div>
            <c:set var="button" value="${prebuilt.disponibilita>0 ? 'Aggiungi al carrello':'SOLD OUT'}"/>
            <c:set var="buttonDisabled" value="${prebuilt.disponibilita>0 ? '':'disabled'}"/>
            <input type="hidden" name="idPrebuilt" value="${prebuilt.ID}" />
            <button type="submit" class="add-to-cart-btn ${buttonDisabled}" <c:if test="${prebuilt.disponibilita==0}">disabled</c:if> onclick="acquista(${prebuilt.ID})">${button}</button>
        </div>
    </div>
    <%@ include file="/components/footer.jsp" %>
  </body>
<script>
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
            })
            .catch(error => {
                console.error("Errore:", error);
            });
    }

    // Array di immagini della galleria (sostituisci i nomi con quelli reali)
    const photos = [
        <c:forEach items="${fotos}" var="foto" varStatus="status">
            '<%=request.getContextPath()%>/${foto}'<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    let currentPhoto = 0;
    function changePhoto(direction) {
        currentPhoto += direction;
        if (currentPhoto < 0) currentPhoto = photos.length - 1;
        if (currentPhoto >= photos.length) currentPhoto = 0;
        document.getElementById('galleryPhoto').src = photos[currentPhoto];
    }
</script>
<style>
.prebuilt-gallery {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    margin-bottom: 20px;
}
.gallery-photo {
    width: 400px;
    height: 400px;
    object-fit: cover;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}
.gallery-btn {
    background: none;
    border: none;
    font-size: 2rem;
    cursor: pointer;
    color: #333;
    padding: 0 10px;
    transition: color 0.2s;
}
.gallery-btn:hover {
    color: #007bff;
}
</style>
</html>