<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/user/addCard/addcard.css">

<div class="add-card-container">
    <h2 class="section-title">Aggiungi Nuova Carta</h2>
    
    <div class="card-form-wrapper">
        <form id="addCardForm" action="userPage/addCarta" method="post" class="card-form">
            <div class="card-preview">
                <div class="card-front">
                    <div class="card-chip"></div>
                    <div class="card-number-display" id="cardNumberDisplay">•••• •••• •••• ••••</div>
                    <div class="card-details">
                        <div class="card-holder-display">
                            <span class="card-label">Titolare</span>
                            <span id="cardHolderDisplay">Nome Cognome</span>
                        </div>
                        <div class="card-expiry-display">
                            <span class="card-label">Scadenza</span>
                            <span id="cardExpiryDisplay">MM/AA</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="cardNumber">Numero Carta</label>
                <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19" minlength="19" required pattern="^(?:\d{4} ){3}\d{4}$" title="Inserisci 16 cifre (formato: 1234 5678 9012 3456)">
                <div class="error-message" id="cardNumberError"></div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="expiryMonth">Data di Scadenza</label>
                    <div class="expiry-inputs">
                        <select id="expiryMonth" name="expiryMonth" required>
                            <option value="" disabled selected>Mese</option>
                            <% for(int i = 1; i <= 12; i++) { %>
                                <option value="<%= i %>"><%= i %></option>
                            <% } %>
                        </select>
                        <select id="expiryYear" name="expiryYear" required>
                            <option value="" disabled selected>Anno</option>
                            <% 
                                int currentYear = java.time.Year.now().getValue();
                                for(int i = currentYear; i <= currentYear + 10; i++) { 
                            %>
                                <option value="<%= i %>"><%= i %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="cvv">CVV</label>
                    <input type="text" id="cvv" name="cvv" placeholder="123" maxlength="3" minlength="3" required pattern="^[0-9]{3}$" title="Il CVV deve contenere 3 cifre numeriche">
                    <div class="error-message" id="cvvError"></div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">Nome</label>
                    <input type="text" id="firstName" name="firstName" placeholder="Nome" required pattern="^[A-Za-zÀ-ÿ ']{2,30}$" title="Solo lettere, minimo 2 caratteri">
                </div>
                
                <div class="form-group">
                    <label for="lastName">Cognome</label>
                    <input type="text" id="lastName" name="lastName" placeholder="Cognome" required pattern="^[A-Za-zÀ-ÿ ']{2,30}$" title="Solo lettere, minimo 2 caratteri">
                </div>
            </div>
            
            <div class="form-actions">
                <button type="button" class="cancel-button" onclick="changePage('yourcards')">Annulla</button>
                <button type="submit" class="save-button">Salva Carta</button>
            </div>
        </form>
    </div>
</div>

<script>
    function handleCardNumberInput() {
        let value = this.value.replace(/\s/g, '');

        if (value.length > 0) {
            value = value.match(new RegExp('.{1,4}', 'g')).join(' ');
        }
        
        this.value = value;

        if (value.length > 0) {
            document.getElementById('cardNumberDisplay').textContent = value;
        } else {
            document.getElementById('cardNumberDisplay').textContent = '•••• •••• •••• ••••';
        }

        if (value.replace(/\s/g, '').length > 0 && value.replace(/\s/g, '').length !== 16) {
            document.getElementById('cardNumberError').textContent = 'Il numero della carta deve contenere 16 cifre';
        } else {
            document.getElementById('cardNumberError').textContent = '';
        }
    }

    function handleNameInput() {
        updateCardHolder();
    }

    function updateCardHolder() {
        const firstName = document.getElementById('firstName').value || '';
        const lastName = document.getElementById('lastName').value || '';
        
        if (firstName.trim() || lastName.trim()) {
            document.getElementById('cardHolderDisplay').textContent = (firstName+' '+lastName).trim();
        } else {
            document.getElementById('cardHolderDisplay').textContent = 'Nome Cognome';
        }
    }

    function handleExpiryChange() {
        updateExpiry();
    }

    function updateExpiry() {
        const month = document.getElementById('expiryMonth').value;
        const year = document.getElementById('expiryYear').value;
        
        if (month && year) {
            const shortYear = year.toString().slice(-2);
            const paddedMonth = month.toString().padStart(2, '0');
            document.getElementById('cardExpiryDisplay').textContent = paddedMonth+'/'+shortYear;
        } else {
            document.getElementById('cardExpiryDisplay').textContent = 'MM/AA';
        }
    }

    function handleCvvInput() {
        const value = this.value;

        this.value = value.replace(/[^0-9]/g, '');

        if (value.length > 0 && value.length !== 3) {
            document.getElementById('cvvError').textContent = 'Il CVV deve contenere 3 cifre';
        } else {
            document.getElementById('cvvError').textContent = '';
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const cardNumberInput = document.getElementById('cardNumber');
        cardNumberInput.addEventListener('input', handleCardNumberInput);

        const firstNameInput = document.getElementById('firstName');
        const lastNameInput = document.getElementById('lastName');
        firstNameInput.addEventListener('input', handleNameInput);
        lastNameInput.addEventListener('input', handleNameInput);

        const expiryMonthSelect = document.getElementById('expiryMonth');
        const expiryYearSelect = document.getElementById('expiryYear');
        expiryMonthSelect.addEventListener('change', handleExpiryChange);
        expiryYearSelect.addEventListener('change', handleExpiryChange);

        const cvvInput = document.getElementById('cvv');
        cvvInput.addEventListener('input', handleCvvInput);

        const form = document.getElementById('addCardForm');
    });

    document.getElementById('addCardForm').addEventListener('submit', function(e) {
        event.preventDefault();
        const cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, '');
        const cvv = document.getElementById('cvv').value;
        if (cardNumber.length !== 16) {
            document.getElementById('cardNumberError').textContent = 'Il numero della carta deve contenere 16 cifre';
            return;
        }
        if (cvv.length !== 3) {
            document.getElementById('cvvError').textContent = 'Il CVV deve contenere 3 cifre';
            return;
        }
        const formData=new FormData(this);
        fetch('<%=request.getContextPath()%>/userPage/addCarta',{
            method:'POST',
            body:formData,
        }).then(response=>response.json()).then(data=>{
            if(data.status==='success') {
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "<%=request.getContextPath()%>/userPage";
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "option";
                input.value = "yourcards";
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
            else if(data.code===1) {
                document.getElementById('cardNumberError').textContent = 'La carta risulta già salvata nel database, controlla e riprova';
            }
            else if(data.code===2) {
                document.getElementById('cvvError').textContent = 'Il CVV deve contenere 3 cifre';
            }
            else if(data.code===3) {
                document.getElementById('cardNumberError').textContent = 'Il numero della carta deve contenere 16 cifre';
            }
            else {
                document.getElementById('cardNumberError').textContent = 'Errore non identificato, contattare l\'amministratore';
            }
        });
    })
</script>