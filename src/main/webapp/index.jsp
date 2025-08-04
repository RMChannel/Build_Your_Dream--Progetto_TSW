<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Build Your Dream - Home Page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/home.css">
</head>
<body>
<%@ include file="components/header.jsp" %>
<main class="home-container">
    <section class="hero-section">
        <div class="hero-content">
            <i><h1>Build Your Dream</h1></i>
            <p>Componenti di qualità, configurazioni personalizzate e supporto esperto</p>
            <a href="builder" class="cta-button">Inizia ora</a>
        </div>
    </section>

    <section class="categories-section">
        <h2 class="section-title">Esplora le nostre categorie</h2>

        <div class="categories-container">
            <div class="category-card" style="background-image: url('<%=request.getContextPath()%>/media/HomePage/build.jpeg')">
                <div class="category-overlay"></div>
                <div class="category-content">
                    <h3>Pre-Built</h3>
                    <p>Sistemi completi pronti all'uso, configurati e testati dai nostri esperti</p>
                    <a href="preBuilt" class="category-button">Scopri</a>
                </div>
            </div>

            <div class="category-card" style="background-image: url('<%=request.getContextPath()%>/media/HomePage/pezzi.jpeg')">
                <div class="category-overlay"></div>
                <div class="category-content">
                    <h3>Pezzi</h3>
                    <p>Qui troverai tutte le componentistiche più recenti e performanti sul mercato</p>
                    <a href="pezzi" class="category-button">Cerca</a>
                </div>
            </div>

            <div class="category-card" style="background-image: url('<%=request.getContextPath()%>/media/HomePage/accessories.jpeg')">
                <div class="category-overlay"></div>
                <div class="category-content">
                    <h3>Accessori</h3>
                    <p>Completa il tuo setup con la nostra selezione di periferiche e accessori</p>
                    <a href="accessori" class="category-button">Esplora</a>
                </div>
            </div>
        </div>
    </section>

    <section class="features-section">
        <div class="features-container">
            <div class="feature">
                <div class="feature-icon">
                    <img src="<%=request.getContextPath()%>/media/HomePage/quality.avif" alt="Qualità">
                </div>
                <h3>Qualità Garantita</h3>
                <p>Solo componenti selezionati dai migliori produttori</p>
            </div>

            <div class="feature">
                <div class="feature-icon">
                    <img src="<%=request.getContextPath()%>/media/HomePage/support.jpg" alt="Supporto">
                </div>
                <h3>Supporto Esperto</h3>
                <p>Assistenza tecnica disponibile 7 giorni su 7</p>
            </div>

            <div class="feature">
                <div class="feature-icon">
                    <img src="<%=request.getContextPath()%>/media/HomePage/shipping.png" alt="Spedizione">
                </div>
                <h3>Spedizione Veloce</h3>
                <p>Consegna rapida e sicura in tutta Italia</p>
            </div>

            <div class="feature">
                <div class="feature-icon">
                    <img src="<%=request.getContextPath()%>/media/HomePage/garanzia.png" alt="Garanzia">
                </div>
                <h3>Garanzia Estesa</h3>
                <p>2 anni di garanzia su tutti i prodotti</p>
            </div>
        </div>
    </section>
</main>
<%@ include file="components/footer.jsp" %>
</body>
</html>