<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Build Your Dream - Contattaci</title>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/contactUs/contactUs.css">
</head>
<body>
<%@ include file="/components/header.jsp"%>
<h1 class="page-title">Contattaci</h1>
<div class="child">
    <div class="contact-form-container">
        <h2 class="form-title">Scrivici</h2>
        <form class="contact-form" action="" method="post" id="form">
            <div class="form-group">
                <input type="text" id="name" name="name" required class="form-input" aria-labelledby="name-label">
                <label for="name" class="form-label" id="name-label">Nome</label>
            </div>

            <div class="form-group">
                <input type="email" id="email" name="email" required class="form-input" aria-labelledby="email-label">
                <label for="email" class="form-label" id="email-label">Email</label>
            </div>

            <div class="form-group">
                <textarea id="message" name="message" required class="form-textarea" aria-labelledby="message-label"></textarea>
                <label for="message" class="form-label" id="message-label">Il tuo messaggio</label>
            </div>
            <button type="submit" class="form-submit">Invia messaggio</button>
            <h3 id="messageText" style="display: none"></h3>
        </form>
    </div>
</div>
<div class="parent">
    <div class="child">
        <div class="parent2">
            <div class="child2">
                <h2>Indirizzo:</h2>
                <h4>Via Giovanni Paolo II, 132, 84084 Fisciano SA</h4><br>
                <div class="map-title-container">
                    <h3 class="map-title"> Edificio F2 </h3>
                </div>
                <div class="map-container"><iframe width="100%" height="300" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?width=100%25&amp;height=300&amp;hl=en&amp;q=Via%20Giovanni%20Paolo%20II,%20132,%2084084%20Fisciano%20SA+(Edificio%20F2)&amp;t=&amp;z=17&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"></iframe></div>
            </div>
            <div class="child2">
                <h2>Social:</h2>
                <div class="social-links">
                    <a href="https://www.instagram.com/cito.roberto.82/" class="instagram-link">
                        <div class="social-card">
                            <img src="<%=request.getContextPath()%>/media/instagram.png" alt="instagram" class="social-icon">
                            <span class="username">@cito.roberto82</span>
                        </div>
                    </a>
                    <a href="https://www.instagram.com/leqso_chikviladze/" class="instagram-link">
                        <div class="social-card">
                            <img src="<%=request.getContextPath()%>/media/instagram.png" alt="instagram" class="social-icon">
                            <span class="username">@leqso_chikviladze</span>
                        </div>
                    </a>
                </div>
            </div>
            <div class="child2">
                <h2>Telefono:</h2>
                <div class="contact-links">
                    <a href="tel:+393471304385" class="contact-link">
                        <div class="contact-card phone-card">
                            <img src="<%=request.getContextPath()%>/media/phone-icon.png" alt="telefono" class="contact-icon">
                            <span class="contact-info">+39 347 130 4385</span>
                        </div>
                    </a>
                    <a href="tel:+393285630871" class="contact-link">
                        <div class="contact-card phone-card">
                            <img src="<%=request.getContextPath()%>/media/phone-icon.png" alt="telefono" class="contact-icon">
                            <span class="contact-info">+39 328 563 0871</span>
                        </div>
                    </a>
                </div>
            </div>
            <div class="child2">
                <h2>Email:</h2>
                <div class="contact-links">
                    <a href="mailto:r.cito@studenti.unisa.it" class="contact-link">
                        <div class="contact-card email-card">
                            <img src="<%=request.getContextPath()%>/media/email-icon.png" alt="email" class="contact-icon">
                            <span class="contact-info">r.cito@studenti.unisa.it</span>
                        </div>
                    </a>
                    <a href="mailto:a.chikviladze.unisa.it" class="contact-link">
                        <div class="contact-card email-card">
                            <img src="<%=request.getContextPath()%>/media/email-icon.png" alt="email" class="contact-icon">
                            <span class="contact-info">a.chikviladze.unisa.it</span>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

</div>
<%@ include file="/components/footer.jsp"%>
</body>
<script>
    function testSubmit(event) { // Aggiunto 'event' come parametro
        event.preventDefault(); // Chiamato 'event.preventDefault()'
        const messageText = document.getElementById("messageText"); // Cambiato nome variabile per chiarezza
        const form = document.getElementById("form"); // Riferimento al form
        const formData = new FormData(form); // Passato il form a FormData

        fetch('<%=request.getContextPath()%>/contatti',{
            method:'POST',
            body:formData,
        }).then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
            .then(data => {
                console.log(data);
                if(data.status === 'success') {
                    messageText.innerHTML = "Il messaggio è stato inviato con successo";
                    messageText.style.color = 'green'; // Stile per successo
                }
                else if(data.code === 0) {
                    messageText.innerHTML = "Uno dei parametri è vuoto";
                    messageText.style.color = 'red';
                }
                else if (data.code === 2) {
                    messageText.innerHTML = "L'email non è valida";
                    messageText.style.color = 'red';
                }
                else { // Gestisce tutti gli altri casi come errore
                    messageText.innerHTML = "Qualcosa è andato storto, riprova";
                    messageText.style.color = 'red';
                }
            })
            .catch(error => {
                console.error('Fetch Error:', error);
                messageText.innerHTML = "Errore di comunicazione con il server. Riprova.";
                messageText.style.color = 'red';
            });

        messageText.style.display = "block";
    }
    document.getElementById("form").addEventListener("submit", testSubmit);
</script>
</html>
