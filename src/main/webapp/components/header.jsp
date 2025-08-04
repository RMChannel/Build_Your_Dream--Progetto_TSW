<%@ page import="Model.Users.User" %>
<%@ page import="Model.Carrello.Carrello" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/headerStyle.css">
</head>
<body>
<%
    User user= (User) session.getAttribute("user");
    if(user!=null && user.isAdmin()) {
%><%@ include file="adminHeader.jsp"%><%
    }
    Carrello carrello=(Carrello) session.getAttribute("carrello");
    int countCarrello=0;
    if(carrello!=null) {
        countCarrello=carrello.getCount();
    }
%>

<div class="navbar">
    <div class="top-bar">
        <!-- Mobile Nav -->
        <div class="nav-right-mobile" id="navRightMobile">
            <% if(user==null) { %>
            <div class="nav-link-mobile" id="loginRegisterBtnMobile" role="button" tabindex="0" aria-label="Login Registrati">
                Login<br>Registrati
            </div>
            <% } else { %>
            <a href="<%=request.getContextPath()%>/userPage" class="nav-link-mobile">Benvenuto/a<br><%=user.getUsername()%></a>
            <% } %>
        </div>
        <div class="logo-container">
            <a href="<%=request.getContextPath()%>/"><img class="logo" src="<%=request.getContextPath()%>/media/favicon.png" alt="HomePage"></a>
        </div>
        <!-- Desktop Nav -->
        <div class="nav-right" id="navRightDesktop">
            <% if(user==null) { %>
            <a href="javascript:void(0)" class="nav-link" id="loginRegisterBtn">Login/Registrati</a>
            <% } else { %>
            <a href="<%=request.getContextPath()%>/userPage" class="nav-link">Benvenuto/a <%=user.getUsername()%></a>
            <% } %>
            <a href="carrello" class="nav-link cart-container">
                <div class="cart-icon">
                    <img class="cart-icon" id="cart-icon" src="<%=request.getContextPath()%>/media/cart.png" alt="Carrello">
                    <span class="cart-count" id="cartCount"><%=countCarrello%></span>
                </div>
            </a>
        </div>
        <div class="nav-right-carrello" id="navRightMobileCarrello">
            <a href="carrello" class="nav-link-mobile">
                <img class="cart-icon" src="<%=request.getContextPath()%>/media/cart.png">
                <span class="cart-count" id="cartCountMobile"><%=countCarrello%></span>
            </a>
        </div>
    </div>

    <div class="nav-menu">
        <a href="accessori" class="nav-link">Accessori</a>
        <a href="pezzi" class="nav-link">Pezzi</a>
        <a href="preBuilt" class="nav-link">Pre-built</a>
        <a href="builder" class="nav-link">Builder</a>
    </div>
</div>

<div class="popup-overlay" id="loginRegisterPopup" aria-hidden="true">
    <div class="popup-container" role="dialog" aria-modal="true" aria-label="Login e Registrazione">
        <button type="button" class="close-btn" id="closePopupBtn" aria-label="Chiudi popup">
            <span aria-hidden="true">X</span>
            <span style="position:absolute;left:-9999px;" id="closePopupBtnLabel">Chiudi popup</span>
        </button>

        <!-- Login Section -->
        <div class="popup-section">
            <h2 class="popup-title" id="popupTitleLogin">Login</h2>
            <form action="login" id="login" method="post" aria-labelledby="popupTitleLogin">
                <label for="usernameLogin" class="sr-only">Username</label>
                <input type="text" class="form-input" id="usernameLogin" name="username" placeholder="Username" required>
                <label for="passwordLogin" class="sr-only">Password</label>
                <input type="password" class="form-input" id="passwordLogin" name="password" placeholder="Password" required>
                <h3 style="color: red; display: none" id="errorLogin" aria-live="assertive" aria-labelledby="errorLoginLabel"></h3>
                <span id="errorLoginLabel" class="sr-only">Errore Login</span>
                <button type="submit" class="form-button" aria-labelledby="btnLoginLabel">Login</button>
                <span id="btnLoginLabel" class="sr-only">Invia Login</span>
            </form>
        </div>

        <!-- Divider -->
        <div class="popup-divider"></div>

        <!-- Register Section -->
        <div class="popup-section">
            <h2 class="popup-title" id="popupTitleRegister">Registrati</h2>
            <form action="register" method="post" id="register" aria-labelledby="popupTitleRegister">
                <label for="username" class="sr-only">Username</label>
                <input type="text" class="form-input" id="username" name="username" placeholder="Username" required>
                <div class="form-row">
                    <label for="name" class="sr-only">Nome</label>
                    <input type="text" class="form-input" id="name" name="name" placeholder="Nome" required>
                    <label for="lastname" class="sr-only">Cognome</label>
                    <input type="text" class="form-input" id="lastname" name="lastname" placeholder="Cognome" required>
                </div>
                <!-- Label visibile per data di nascita -->
                <label for="dateOfBirth" style="display:block;font-weight:600;">Data di nascita (Giorno, Mese, Anno)</label>
                <input type="date" class="form-input" name="dateOfBirth" id="dateOfBirth" placeholder="Data di nascita" required>
                <label for="email" class="sr-only">Email</label>
                <input type="email" class="form-input" id="email" name="email" placeholder="Email" required>
                <label for="phone" class="sr-only">Numero di telefono</label>
                <input type="tel" class="form-input" id="phone" name="phone" placeholder="Numero di telefono" required>
                <div class="form-row">
                    <div style="width: 100%;">
                        <label for="password" class="sr-only">Password</label>
                        <input type="password" class="form-input" minlength="8" name="password" id="password" placeholder="Password" required>
                    </div>
                    <label for="confirmPassword" class="sr-only">Conferma Password</label>
                    <input type="password" class="form-input" name="confirmPassword" id="confirmPassword" placeholder="Conferma Password" required>
                </div>
                <p class="password-hint" id="textUnderPassword" aria-live="polite" aria-labelledby="passwordHintLabel">La password dev'essere almeno di 8 caratteri</p>
                <span id="passwordHintLabel" class="sr-only">Suggerimento Password</span>
                <button type="submit" class="form-button" aria-labelledby="btnRegisterLabel">Registrati</button>
                <span id="btnRegisterLabel" class="sr-only">Invia Registrazione</span>
            </form>
        </div>
    </div>
</div>

<script>
    function setPopupAriaHidden(hidden) {
        document.getElementById('loginRegisterPopup').setAttribute('aria-hidden', hidden ? 'true' : 'false');
    }

    function showLoginForm() {
        const popup = document.getElementById('loginRegisterPopup');
        popup.style.display = 'flex';
        document.body.style.overflow = 'hidden';
        setPopupAriaHidden(false);
        const firstInput = popup.querySelector('#usernameLogin') || popup.querySelector('#username');
        if (firstInput) firstInput.focus();
    }

    function hideLoginForm() {
        const popup = document.getElementById('loginRegisterPopup');
        popup.style.display = 'none';
        document.body.style.overflow = 'auto';
        setPopupAriaHidden(true);
    }

    <% Integer errorRegister = (Integer) request.getAttribute("errorRegister");
    if (errorRegister != null) {
    %>
    document.addEventListener('DOMContentLoaded', function() {
        showLoginForm();
        const textUnderPassword = document.getElementById('textUnderPassword');
        textUnderPassword.style.color = 'red';
        <% if (errorRegister == 1) { %>
        textUnderPassword.innerHTML = 'Tutti i campi sono obbligatori';
        <% } else if (errorRegister == 2) { %>
        textUnderPassword.innerHTML = 'La data di nascita è impostata nel futuro, controlla e riprova';
        <% } else if (errorRegister == 3) { %>
        textUnderPassword.innerHTML = 'Le password non corrispondono';
        <% } else if (errorRegister == 4) { %>
        textUnderPassword.innerHTML = 'Username già registrato';
        <% } else if (errorRegister == 5) { %>
        textUnderPassword.innerHTML = 'Email già registrata';
        <% } else if (errorRegister == 6) { %>
        textUnderPassword.innerHTML = 'Numero di telefono non valido. Usa +39 1234567890 o 1234567890';
        <% } else if (errorRegister == 7) { %>
        textUnderPassword.innerHTML = 'L\'email inserita non è valida';
        <% } %>
    });
    <% } %>

    // Focus trap solo quando il popup è visibile
    document.getElementById('loginRegisterPopup').addEventListener('keydown', function(event) {
        if (this.style.display !== 'flex') return;
        if (event.key === 'Tab') {
            const focusable = this.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="0"])');
            const first = focusable[0];
            const last = focusable[focusable.length - 1];
            if (event.shiftKey) {
                if (document.activeElement === first) {
                    last.focus();
                    event.preventDefault();
                }
            } else {
                if (document.activeElement === last) {
                    first.focus();
                    event.preventDefault();
                }
            }
        }
    });

    document.getElementById("register").addEventListener('submit', function(event) {
        event.preventDefault();
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const textUnderPassword = document.getElementById('textUnderPassword');
        const dateOfBirth = document.getElementById('dateOfBirth');
        const date = new Date(dateOfBirth.value);
        const today = new Date();
        today.setHours(0,0,0,0);
        const phoneInput = this.querySelector('input[name="phone"]');
        const phoneValue = phoneInput.value.trim();
        const phonePattern = /^(\+\d+\s*)?\d{10}$/;
        phoneInput.style.borderColor = '';
        let phoneError = document.getElementById('phoneErrorMsg');
        if (!phoneError) {
            phoneError = document.createElement('p');
            phoneError.id = 'phoneErrorMsg';
            phoneError.style.color = 'red';
            phoneInput.parentNode.insertBefore(phoneError, phoneInput.nextSibling);
        }
        phoneError.textContent = '';
        if (!phonePattern.test(phoneValue)) {
            phoneError.textContent = 'Numero di telefono non valido. Usa +39 1234567890 o 1234567890';
            phoneInput.style.borderColor = 'red';
            return;
        }
        if(password.value!==confirmPassword.value) {
            textUnderPassword.style.color = 'red';
            textUnderPassword.innerHTML = 'Le password non corrispondono';
            confirmPassword.value = '';
        }
        else if(date>today) {
            textUnderPassword.style.color = 'red';
            textUnderPassword.innerHTML = 'La data di nascita è impostata nel futuro, controlla e riprova';
        }
        else if(!document.getElementById('email').value.match(/^(?=.{1,64}@)[A-Za-z0-9_-]+(\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,})$/)) {
            textUnderPassword.style.color = 'red';
            textUnderPassword.innerHTML = 'L\'email inserita non è valida';
        }
        else {
            this.submit();
        }
    });

    document.getElementById("login").addEventListener('submit', function() {
        event.preventDefault();
        const formData=new FormData(this);
        fetch('<%=request.getContextPath()%>/login',{ // invia la richiesta di login e riceve risposta in formato json
            method:'POST',
            body:formData,
        }).then(response=>response.json()).then(data=>{ //se la richiesta è andata a buon fine
            if(data.status==='success') {
                document.getElementById('loginRegisterPopup').style.display = 'none'; // fa scomparire il popup
                document.body.style.overflow = 'auto';
                document.getElementById('loginRegisterBtn').innerHTML = 'Benvenuto/a '+formData.get('username'); //Inserisce il nome utente e fa scomparire il tasto precedente fa comparire il "benvenuto, nomeUtente"
                document.getElementById('loginRegisterBtn').href='userPage';
                document.getElementById('loginRegisterBtn').removeEventListener('click',showLoginForm);
                if(data.admin===1 || <%=request.getServletPath().contains("carrello")%> || <%=request.getServletPath().contains("builder")%>) { //Nel caso in cui l'utente sia admin, oppure, ci troviamo nella pagina carrello o builder allora la pagina viene ricaricata
                    location.reload();
                }
                document.getElementById('cartCount').innerHTML = data.cartCount;
            }
            else if(data.code===1) {
                document.getElementById('errorLogin').style.display = 'block';
                document.getElementById('errorLogin').innerHTML = 'Password errata';
            }
            else if(data.code===2) {
                document.getElementById('errorLogin').style.display = 'block';
                document.getElementById('errorLogin').innerHTML = 'Utente non trovato';
            }
        })
    })

    document.addEventListener('DOMContentLoaded', function() { //Funzione che viene avviata al caricamento della pagina
        const popup = document.getElementById('loginRegisterPopup');
        const loginRegisterBtn = document.getElementById('loginRegisterBtn');
        const loginRegisterBtnMobile = document.getElementById('loginRegisterBtnMobile');
        const closePopupBtn = document.getElementById('closePopupBtn');

        if (loginRegisterBtn) loginRegisterBtn.addEventListener('click', showLoginForm); //serve per far funzionare il tasto Enter come avvio popup
        if (loginRegisterBtnMobile) {
            loginRegisterBtnMobile.addEventListener('click', showLoginForm);
            loginRegisterBtnMobile.addEventListener('keydown', function(e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    showLoginForm();
                }
            });
        }

        if (closePopupBtn) closePopupBtn.addEventListener('click', hideLoginForm);

        // Modifica: chiusura popup con ESC
        document.addEventListener('keydown', function(event) { // serve per chiudere i popup con il tasto Esc
            if (popup.style.display === 'flex' && event.key === 'Escape') {
                hideLoginForm();
            }
        });
        popup.addEventListener('click', function(event) {
            if (event.target === popup) {
                hideLoginForm();
            }
        });
        setPopupAriaHidden(true);
    });

    function toggleNavVisibility() { //Funzione per funzionalità responsive
        const isMobile = window.innerWidth <= 768;
        document.getElementById("navRightDesktop").style.display = isMobile ? "none" : "flex";
        document.getElementById("navRightMobile").style.display = isMobile ? "flex" : "none";
        document.getElementById("navRightMobileCarrello").style.display = isMobile ? "flex" : "none";
        if(window.innerWidth <= 300) {
            alert("Sorry, your phone is shit, buy an iphone today!, biaaaaaaaatch");
        }
    }

    toggleNavVisibility();
    window.addEventListener("resize", toggleNavVisibility);
</script>
</body>
</html>