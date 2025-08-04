<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/footerStyle.css">
</head>
<body>
<footer class="footer">
    <div class="footer-content">
        <div class="footer-quote">
            <p class="quote-text">"Ottimizzato per prestazioni reali: ogni configurazione è il risultato di precisione ingegneristica e compatibilità certificata."</p>
        </div>
        <div class="footer-newsletter">
            <h3>Iscriviti alla newsletter</h3>
            <div class="newsletter-form">
                <form onsubmit="newsletter(); return false;">
                <input type="email" id="email" class="newsletter-input" placeholder="La tua email" aria-label="Email" >
                <button class="newsletter-button" type="submit">Iscriviti</button>
                </form>
            </div>
            <div id="confirmNewsletter" style="display: none"><br></div>
        </div>
        <div class="footer-links">
            <a href="contatti" class="footer-link">Contattaci</a>
            <a href="informativa-sulla-privacy" class="footer-link">Informativa Privacy</a>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Made by Cito Roberto & Chikviladze Aleksandre Tutti i diritti riservati.</p>
        </div>
    </div>
</footer>
</body>
<script>
    function newsletter() {
        const params = new URLSearchParams();
        const email=document.getElementById('email').value;
        const response=document.getElementById('confirmNewsletter');
        if(!isEmail(email)) {
            response.style.display='block';
            response.innerHTML='<h3>Email non valida</h3>';
            return;
        }
        params.append('email', email);
        fetch('<%=request.getContextPath()%>/newsletter', {
            method: 'POST',
            body: params,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        }).catch(error => {
            response.style.display='block';
            response.innerHTML='<h3>Qualcosa è andato storto</h3>';
        }).then(response2=>{
            response.style.display='block';
            response.innerHTML='<h3>Email registrata con successo</h3>';
        });
    }

    function isEmail(str) {
        return true;
    }
</script>
</html>