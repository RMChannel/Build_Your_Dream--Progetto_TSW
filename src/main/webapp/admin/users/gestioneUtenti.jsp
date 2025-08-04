<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Utenti</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/adminPage.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/users/gestioneUtenti.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
    <a href="<%=request.getContextPath()%>/adminPage" class="admin-back-btn" title="Torna alla pagina amministrazione" aria-label="Torna alla pagina amministrazione">
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none" style="vertical-align:middle; margin-right:6px;" aria-hidden="true"><path d="M13.5 17L8 11L13.5 5" stroke="#0074D9" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/></svg>
        Indietro
    </a>
    <div class="gestione-utenti-table-container">
        <h1 class="gestione-utenti-title">Gestione Utenti</h1>
        <button class="add-utente-btn" onclick="openAddUtenteModal()" aria-label="Aggiungi nuovo utente">+ Aggiungi Utente</button>
        <div id="errorUpdate" role="alert" aria-live="polite" style="display:none; color:#ff4136; font-weight:600; text-align:center; margin-bottom:12px;"></div>
        <div style="overflow-x:auto;" role="region" aria-label="Tabella gestione utenti">
            <table class="gestione-utenti-table" id="gestioneUtentiTable" aria-label="Elenco utenti registrati">
                <thead>
                    <tr>
                        <th scope="col" abbr="Numero">#</th>
                        <th scope="col">Username</th>
                        <th scope="col">Nome</th>
                        <th scope="col">Cognome</th>
                        <th scope="col">Email</th>
                        <th scope="col">Numero di telefono</th>
                        <th scope="col">Data di nascita</th>
                        <th scope="col">Admin</th>
                        <th scope="col">Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="utente" items="${utenti}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                <label for="username-${status.index}" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Username</label>
                                <input type="text" id="username-${status.index}" name="username" value="${utente.username}" required 
                                       aria-label="Username per utente ${utente.username}"
                                       title="Username">
                            </td>
                            <td>
                                <label for="nome-${status.index}" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Nome</label>
                                <input type="text" id="nome-${status.index}" name="nome" value="${utente.nome}" required 
                                       aria-label="Nome per utente ${utente.username}"
                                       title="Nome">
                            </td>
                            <td>
                                <label for="cognome-${status.index}" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Cognome</label>
                                <input type="text" id="cognome-${status.index}" name="cognome" value="${utente.cognome}" required 
                                       aria-label="Cognome per utente ${utente.username}"
                                       title="Cognome">
                            </td>
                            <td>
                                <label for="email-${status.index}" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Email</label>
                                <input type="email" id="email-${status.index}" name="email" value="${utente.email}" required 
                                       aria-label="Email per utente ${utente.username}"
                                       title="Email">
                            </td>
                            <td>
                                <label for="phoneNumber-${status.index}" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Numero di telefono</label>
                                <input type="tel" id="phoneNumber-${status.index}" name="phoneNumber" value="${utente.nTelefono}" required 
                                       aria-label="Numero di telefono per utente ${utente.username}"
                                       title="Numero di telefono">
                            </td>
                            <td>
                                <label for="datadinascita-${status.index}" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Data di nascita (GG/MM/AAAA)</label>
                                <input type="date" id="datadinascita-${status.index}" name="datadinascita" value="${utente.dataDiNascita}" required 
                                       aria-label="Data di nascita per utente ${utente.username}" 
                                       aria-describedby="date-help-${status.index}"
                                       title="Data di nascita nel formato GG/MM/AAAA">
                                <span id="date-help-${status.index}" style="position: absolute; left: -10000px;">Usa il formato giorno/mese/anno. Premi Invio o Spazio per aprire il calendario</span>
                            </td>
                            <td style="text-align:center;">
                                <label for="isAdmin-${status.index}" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Amministratore</label>
                                <input type="checkbox" id="isAdmin-${status.index}" name="isAdmin" ${utente.isAdmin() ? 'checked' : ''} 
                                       aria-label="Utente amministratore per ${utente.username}"
                                       title="Privilegi amministratore">
                            </td>
                            <td style="white-space:nowrap;">
                                <button type="button" onclick="updateUser(this, '${utente.username}')" 
                                        aria-label="Aggiorna dati utente ${utente.username}"
                                        title="Aggiorna">Aggiorna</button>
                                <button type="button" class="delete-btn" onclick="removeUser(this)" 
                                        aria-label="Elimina utente ${utente.username}"
                                        title="Elimina">Elimina</button>
                                <button type="button" class="change-password-btn" 
                                        aria-label="Cambia password per utente ${utente.username}"
                                        title="Cambia password">Cambia password</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div id="changePasswordModal" class="change-password-modal" role="dialog" aria-modal="true" aria-labelledby="changePasswordTitle">
        <div class="change-password-modal-content">
            <button class="close-modal-btn" onclick="closeChangePasswordModal()" aria-label="Chiudi finestra">&times;</button>
            <h2 id="changePasswordTitle">Cambia password</h2>
            <label for="newPasswordInput" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Nuova password</label>
            <input type="password" id="newPasswordInput" placeholder="Nuova password" aria-required="true" aria-describedby="changePasswordError" title="Nuova password">
            <div id="changePasswordError" role="alert" aria-live="polite"></div>
            <button id="confirmChangePasswordBtn">Cambia password</button>
        </div>
    </div>
    <div id="addUtenteModal" class="popup-overlay" role="dialog" aria-modal="true" aria-labelledby="addUtenteTitle">
        <div class="popup-container" style="max-width:500px; width:100%; flex-direction:column;">
            <button class="close-btn" onclick="closeAddUtenteModal()" aria-label="Chiudi finestra">X</button>
            <div class="popup-section">
                <h2 class="popup-title" id="addUtenteTitle">Aggiungi nuovo utente</h2>
                <form id="addUtenteForm" aria-label="Form aggiungi nuovo utente">
                    <label for="addUsername" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Username</label>
                    <input type="text" class="form-input" id="addUsername" name="username" placeholder="Username" required aria-required="true" title="Username">
                    <div class="form-row">
                        <div style="flex: 1;">
                            <label for="addNome" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Nome</label>
                            <input type="text" class="form-input" id="addNome" name="nome" placeholder="Nome" required aria-required="true" title="Nome">
                        </div>
                        <div style="flex: 1;">
                            <label for="addCognome" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Cognome</label>
                            <input type="text" class="form-input" id="addCognome" name="cognome" placeholder="Cognome" required aria-required="true" title="Cognome">
                        </div>
                    </div>
                    <label for="addDataNascita" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Data di nascita (GG/MM/AAAA)</label>
                    <input type="date" class="form-input" id="addDataNascita" name="dataDiNascita" 
                           required aria-required="true" 
                           aria-label="Data di nascita" 
                           aria-describedby="addDateHelp"
                           title="Data di nascita nel formato GG/MM/AAAA">
                    <span id="addDateHelp" style="position: absolute; left: -10000px;">Formato data: giorno/mese/anno. Usa le frecce per navigare tra giorno, mese e anno</span>
                    <label for="addEmail" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Email</label>
                    <input type="email" class="form-input" id="addEmail" name="email" placeholder="Email" required aria-required="true" title="Email">
                    <label for="addTelefono" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Numero di telefono</label>
                    <input type="tel" class="form-input" id="addTelefono" name="nTelefono" placeholder="Numero di telefono" required aria-required="true" title="Numero di telefono">
                    <label for="addPassword" style="position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;">Password (minimo 8 caratteri)</label>
                    <input type="password" class="form-input" id="addPassword" name="password" placeholder="Password" minlength="8" required aria-required="true" aria-describedby="passwordHelp" title="Password">
                    <span id="passwordHelp" style="position: absolute; left: -10000px;">La password deve essere di almeno 8 caratteri</span>
                    <div style="margin:8px 0 10px 0; display:flex; align-items:center; gap:8px;">
                        <input type="checkbox" id="isAdminAdd" name="isAdmin" style="width:18px; height:18px;" aria-label="Imposta come amministratore">
                        <label for="isAdminAdd" style="font-size:1em; color:#001f3f; font-weight:500; cursor:pointer;">Admin</label>
                    </div>
                    <div style="margin:8px 0 0 0; color:#ff4136; font-weight:600; display:none;" id="addUtenteError" role="alert" aria-live="polite"></div>
                    <button type="submit" class="form-button" style="width:100%; margin-top:10px;">Aggiungi utente</button>
                </form>
            </div>
        </div>
    </div>
    <script>
        function updateUser(btn, originalUsername) {
            const row = btn.closest('tr');
            const username = row.querySelector('input[name="username"]').value;
            const nome = row.querySelector('input[name="nome"]').value;
            const cognome = row.querySelector('input[name="cognome"]').value;
            const email = row.querySelector('input[name="email"]').value;
            const telefono = row.querySelector('input[name="phoneNumber"]').value;
            const datadinascita = row.querySelector('input[name="datadinascita"]').value;
            const isAdmin = row.querySelector('input[name="isAdmin"]').checked ? 'true' : 'false';
            const data = new URLSearchParams();
            data.append('username', username);
            data.append('originalUsername', originalUsername);
            data.append('nome', nome);
            data.append('cognome', cognome);
            data.append('email', email);
            data.append('nTelefono', telefono);
            data.append('dataDiNascita', datadinascita);
            data.append('isAdmin', isAdmin);

            fetch('<%=request.getContextPath()%>/updateUserAdmin', {
                method: 'POST',
                body: data,
            }).then(response => response.json()).then(data => {
                if(data.status==='success') {
                    location.reload();
                }
                else if(data.code===1) {
                    document.getElementById('errorUpdate').style.display = 'block';
                    document.getElementById('errorUpdate').innerHTML = 'Uno dei parametri è vuoto, controlla e riprova';
                }
                else if(data.code===2) {
                    document.getElementById('errorUpdate').style.display = 'block';
                    document.getElementById('errorUpdate').innerHTML = 'La data di nascita è antecedente a quella attuale';
                }
                else if(data.code===3) {
                    document.getElementById('errorUpdate').style.display='block';
                    document.getElementById('errorUpdate').innerHTML='Il numero di telefono inserito non è in un formato corretto, dev\'essere o +39 1234567890 o 1234567890';
                }
            })
        }

        function removeUser(btn) {
            if(confirm('Sei sicuro di voler eliminare questo utente?')) {
                const row = btn.closest('tr');
                const username = row.querySelector('input[name="username"]').value;
                const data = new URLSearchParams();
                data.append('username', username);
                fetch('<%=request.getContextPath()%>/deleteUser', {
                    method: 'POST',
                    body: data,
                }).then(response => response.json()).then(data => {
                    if(data.status==='success') {
                        location.reload();
                    } else {
                        document.getElementById('errorUpdate').style.display = 'block';
                        document.getElementById('errorUpdate').innerHTML = 'C\'è stato qualche problema nella richiesta, controlla e riprova';
                    }
                });
            }
        }

        document.querySelectorAll('.change-password-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const row = btn.closest('tr');
                const username = row.querySelector('input[name="username"]').value;
                openChangePasswordModal(username);
            });
        });

        let currentChangePasswordUsername = null;
        let lastFocusedElement = null;
        
        function openChangePasswordModal(username) {
            currentChangePasswordUsername = username;
            lastFocusedElement = document.activeElement;
            document.getElementById('changePasswordModal').style.display = 'flex';
            document.getElementById('changePasswordTitle').innerText = 'Cambia password per l\'utente ' + username;
            document.getElementById('newPasswordInput').value = '';
            document.getElementById('changePasswordError').style.display = 'none';
            // Focus sul campo password
            setTimeout(() => {
                document.getElementById('newPasswordInput').focus();
            }, 100);
        }
        
        function closeChangePasswordModal() {
            document.getElementById('changePasswordModal').style.display = 'none';
            // Ripristina il focus sull'elemento precedente
            if (lastFocusedElement) {
                lastFocusedElement.focus();
            }
        }
        document.getElementById('confirmChangePasswordBtn').onclick = function() {
            const newPassword = document.getElementById('newPasswordInput').value;
            if(!newPassword) {
                document.getElementById('changePasswordError').style.display = 'block';
                document.getElementById('changePasswordError').innerText = 'La password non può essere vuota';
                return;
            }
            else if(newPassword.length<8) {
                document.getElementById('changePasswordError').style.display = 'block';
                document.getElementById('changePasswordError').innerText = 'La password dev\'essere minimo di 8 caratteri';
                return;
            }
            const data = new URLSearchParams();
            data.append('username', currentChangePasswordUsername);
            data.append('newPassword', newPassword);
            fetch('<%=request.getContextPath()%>/changeUserPassword', {
                method: 'POST',
                body: data,
            }).then(response => response.json()).then(data => {
                if(data.status==='success') {
                    closeChangePasswordModal();
                } else {
                    document.getElementById('changePasswordError').style.display = 'block';
                    document.getElementById('changePasswordError').innerText = 'Errore durante il cambio password';
                }
            });
        }

        function openAddUtenteModal() {
            document.getElementById('addUtenteModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
            // Focus sul primo campo del form
            setTimeout(() => {
                document.getElementById('addUsername').focus();
            }, 100);
        }
        
        function closeAddUtenteModal() {
            document.getElementById('addUtenteModal').style.display = 'none';
            document.body.style.overflow = 'auto';
            // Ripristina il focus sul pulsante aggiungi
            document.querySelector('.add-utente-btn').focus();
        }
        document.getElementById('addUtenteForm').onsubmit = function(e) {
            e.preventDefault();
            const form = e.target;
            const username = form.username.value.trim();
            const nome = form.nome.value.trim();
            const cognome = form.cognome.value.trim();
            const dataDiNascita = form.dataDiNascita.value;
            const email = form.email.value.trim();
            const nTelefono = form.nTelefono.value.trim();
            const password = form.password.value;
            const isAdmin = (form.isAdmin.checked ? 'true' : 'false');
            const errorDiv = document.getElementById('addUtenteError');
            errorDiv.style.display = 'none';
            errorDiv.innerText = '';
            if(!username || !nome || !cognome || !dataDiNascita || !email || !nTelefono || !password) {
                errorDiv.style.display = 'block';
                errorDiv.innerText = 'Tutti i campi sono obbligatori';
                return;
            }
            const date = new Date(dataDiNascita);
            const today = new Date();
            today.setHours(0,0,0,0);
            if(date > today) {
                errorDiv.style.display = 'block';
                errorDiv.innerText = 'La data di nascita è impostata nel futuro, controlla e riprova';
                return;
            }
            if(password.length < 8) {
                errorDiv.style.display = 'block';
                errorDiv.innerText = 'La password deve essere almeno di 8 caratteri';
                return;
            }
            const phonePattern = /^(\+\d+\s*)?\d{10}$/;
            if(!phonePattern.test(nTelefono)) {
                errorDiv.style.display = 'block';
                errorDiv.innerText = 'Numero di telefono non valido. Usa +39 1234567890 o 1234567890';
                return;
            }
            const data = new URLSearchParams();
            data.append('isAdmin', isAdmin);
            Array.from(form.elements).forEach(el => {
                if(el.name && el.name!=='isAmdin') data.append(el.name, el.value);
            });
            fetch('<%=request.getContextPath()%>/newUser', {
                method: 'POST',
                body: data,
            }).then(response => response.json()).then(data => {
                if(data.status==='success') {
                    closeAddUtenteModal();
                    location.reload();
                } else {
                    errorDiv.style.display = 'block';
                    errorDiv.innerText = data.message || 'Errore durante l\'aggiunta';
                }
            });
        };

        // Funzione per rendere la tabella responsive riducendo la dimensione del testo
        function resizeTableFont() {
            const table = document.getElementById('gestioneUtentiTable');
            if (!table) return;
            const container = table.parentElement;
            if (container.scrollWidth > 400) {
                table.style.fontSize = '0.85em';
            } else {
                table.style.fontSize = '';
            }
        }
        window.addEventListener('resize', resizeTableFont);
        window.addEventListener('DOMContentLoaded', resizeTableFont);
        
        // Gestione navigazione tastiera per i modal
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                if (document.getElementById('changePasswordModal').style.display === 'flex') {
                    closeChangePasswordModal();
                }
                if (document.getElementById('addUtenteModal').style.display === 'block') {
                    closeAddUtenteModal();
                }
            }
        });
        
        // Trap focus nei modal
        function trapFocus(element) {
            const focusableElements = element.querySelectorAll(
                'a[href], button, textarea, input[type="text"], input[type="radio"], input[type="checkbox"], input[type="password"], input[type="email"], input[type="tel"], input[type="date"], select'
            );
            const firstFocusableElement = focusableElements[0];
            const lastFocusableElement = focusableElements[focusableElements.length - 1];
            
            element.addEventListener('keydown', function(e) {
                if (e.key === 'Tab') {
                    if (e.shiftKey) { // Shift + Tab
                        if (document.activeElement === firstFocusableElement) {
                            lastFocusableElement.focus();
                            e.preventDefault();
                        }
                    } else { // Tab
                        if (document.activeElement === lastFocusableElement) {
                            firstFocusableElement.focus();
                            e.preventDefault();
                        }
                    }
                }
            });
        }
        
        // Applica trap focus ai modal
        trapFocus(document.getElementById('changePasswordModal'));
        trapFocus(document.getElementById('addUtenteModal'));
        
        // Migliora l'accessibilità dei campi date
        function enhanceDateInputs() {
            const dateInputs = document.querySelectorAll('input[type="date"]');
            dateInputs.forEach(input => {
                // Aggiungi supporto per navigazione da tastiera
                input.addEventListener('keydown', function(e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        // Permetti l'apertura del date picker con Enter o Spazio
                        e.preventDefault();
                        try {
                            input.showPicker();
                        } catch(error) {
                            // Fallback per browser che non supportano showPicker
                            input.focus();
                            input.click();
                        }
                    }
                });
                
                // Aggiungi feedback per screen reader quando il valore cambia
                input.addEventListener('change', function() {
                    if (this.value) {
                        const date = new Date(this.value);
                        const formattedDate = date.toLocaleDateString('it-IT', {
                            day: 'numeric',
                            month: 'long',
                            year: 'numeric'
                        });
                        // Crea un annuncio per screen reader
                        const announcement = document.createElement('div');
                        announcement.setAttribute('role', 'status');
                        announcement.setAttribute('aria-live', 'polite');
                        announcement.className = 'sr-only';
                        announcement.textContent = `Data selezionata: ${formattedDate}`;
                        document.body.appendChild(announcement);
                        setTimeout(() => announcement.remove(), 1000);
                    }
                });
            });
        }
        
        // Inizializza miglioramenti accessibilità
        window.addEventListener('DOMContentLoaded', function() {
            enhanceDateInputs();
            initializeDateSelects();
            
            // Assicura che tutti gli input siano accessibili da tastiera
            const allInputs = document.querySelectorAll('input, button, select, textarea');
            allInputs.forEach(element => {
                if (!element.hasAttribute('tabindex')) {
                    element.setAttribute('tabindex', '0');
                }
            });
        });
        
        // Inizializza i select delle date
        function initializeDateSelects() {
            // Per ogni riga della tabella
            document.querySelectorAll('.date-input-group').forEach((group, index) => {
                const hiddenInput = group.querySelector('input[type="hidden"]');
                const daySelect = group.querySelector(`select[id^="giorno-"]`);
                const monthSelect = group.querySelector(`select[id^="mese-"]`);
                const yearSelect = group.querySelector(`select[id^="anno-"]`);
                
                // Se c'è un valore esistente, popolalo nei select
                if (hiddenInput && hiddenInput.value) {
                    const parts = hiddenInput.value.split('-');
                    if (parts.length === 3) {
                        yearSelect.value = parts[0];
                        monthSelect.value = parts[1];
                        daySelect.value = parts[2];
                    }
                }
                
                // Aggiungi listener per aggiornare il campo nascosto
                [daySelect, monthSelect, yearSelect].forEach(select => {
                    select.addEventListener('change', () => {
                        updateHiddenDate(daySelect, monthSelect, yearSelect, hiddenInput);
                    });
                });
            });
        }
        
        // Aggiorna il campo nascosto con la data completa
        function updateHiddenDate(daySelect, monthSelect, yearSelect, hiddenInput) {
            if (daySelect.value && monthSelect.value && yearSelect.value) {
                hiddenInput.value = `${yearSelect.value}-${monthSelect.value}-${daySelect.value}`;
            } else {
                hiddenInput.value = '';
            }
        }
    </script>
</body>
</html>
