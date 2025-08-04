<%@ page import="java.util.HashMap" %>
<%@ page import="Foto.FotoDAO" %>
<%@ page import="Model.Users.Carte.Carta" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Conferma Ordine</title>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/headerStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/components/footerStyle.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/orders/order.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/carrello/carrello.css">
    <% FotoDAO fotoDAO = new FotoDAO(); %>
    <style>
        /* Rendi la tabella scrollabile orizzontalmente su schermi piccoli */
        .order-table-responsive {
            overflow-x: auto;
            width: 100%;
        }
        .order-table.cart-list.data-table {
            min-width: 400px;
        }
    </style>
</head>
<body>
<%@ include file="/components/header.jsp"%>
<div class="order-container">
    <div class="order-title">Riepilogo Ordine</div>
    <div class="order-section">
        <h3>Prodotti nel carrello</h3>
        <c:choose>
            <c:when test="${carrello.isEmpty()}">
                <div class="empty-cart">Il carrello è vuoto.</div>
            </c:when>
            <c:otherwise>
                <div class="order-table-responsive">
                <table class="order-table cart-list data-table" id="orderTable">
                    <thead>
                    <tr>
                        <th>Foto</th>
                        <th>Tipo Prodotto</th>
                        <th>Marca</th>
                        <th>Modello</th>
                        <th>Prezzo</th>
                        <th>Quantità</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% HashMap<String,String> classes = carrello.getClasses(); %>
                    <c:forEach var="item" items="${carrello.objects}">
                        <tr>
                            <c:set var="prodotto" value="${item.object}"/>
                            <c:set var="key" value="${prodotto.ID}${prodotto.TYPE}" scope="request"/>
                            <c:set var="pID" value="${prodotto.ID}" scope="request"/>
                            <c:set var="pType" value="${prodotto.TYPE}" scope="request"/>
                            <%
                                Object pID = request.getAttribute("pID");
                                String categoria = "";
                                String imagePath = "";
                                if(request.getAttribute("pType").equals("Prebuilt")) {
                                    imagePath = fotoDAO.getFirstFotoOfPrebuilt((int) request.getAttribute("pID"),(String) request.getAttribute("path"));
                                } else {
                                    if(request.getAttribute("pType").equals("Pezzo")) categoria = "fotoPezzi";
                                    else categoria = "fotoAccessori";
                                    String prodotto = "";
                                    if(classes.get(request.getAttribute("key")) != null) prodotto = classes.get(request.getAttribute("key"));
                                    if(prodotto.equals("Tappetino")) prodotto = "Tappetini";
                                    else if(prodotto.equals("Tastiera")) prodotto = "Tastiere";
                                    imagePath = fotoDAO.getFoto((Integer) pID, categoria, prodotto, (String) request.getAttribute("path"));
                                }
                            %>
                            <td class="cpu-image"><img class="cart-img" src='<%=request.getContextPath()%>/<%=imagePath%>' alt="Foto prodotto"/></td>
                            <td><%=classes.get(request.getAttribute("key"))%></td>
                            <td>${prodotto.marca}</td>
                            <td>${prodotto.modello}</td>
                            <td class="prezzo-cell ${prodotto.sconto > 0 ? 'prezzo-scontato' : ''}">
                                <c:if test="${prodotto.sconto > 0}">
                                    <span class="prezzo-originale">${Math.round(prodotto.prezzo * 100) / 100}€</span>
                                    <span class="sconto-badge">-${prodotto.sconto}%</span>
                                </c:if>
                                <span class="prezzo-finale">${Math.round((prodotto.prezzo * (1 - prodotto.sconto / 100)) * 100) / 100}€</span>
                            </td>
                            <td>${item.quantity}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </div>
                <div class="cart-summary-section">
                    <div class="cart-total">Totale ordine: <span class="cart-total-value">${Math.round(carrello.getTotale()*100)/100}€</span></div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="order-section">
        <h3>Dati di spedizione</h3>
        <form class="order-form" action="confermaOrdine" method="post">
            <div class="form-row">
                <div>
                    <label for="nome">Nome</label>
                    <input type="text" id="nome" name="nome" required>
                </div>
                <div>
                    <label for="cognome">Cognome</label>
                    <input type="text" id="cognome" name="cognome" required>
                </div>
            </div>
            <div class="form-row">
                <div>
                    <label for="telefono">Telefono</label>
                    <input type="text" id="telefono" name="telefono" required>
                </div>
                <div>
                    <label for="via">Via</label>
                    <input type="text" id="via" name="via" required>
                </div>
            </div>
            <div class="form-row">
                <div>
                    <label for="civico">Civico</label>
                    <input type="number" id="civico" name="civico" required>
                </div>
                <div>
                    <label for="cap">CAP</label>
                    <input type="text" id="cap" name="cap" required>
                </div>
                <div>
                    <label for="citta">Città</label>
                    <input type="text" id="citta" name="citta" required>
                </div>
            </div>
            <div class="order-section">
                <h3>Pagamento</h3>
                <div class="saved-cards">
                    <label for="cartaSalvata">Seleziona una carta salvata</label>
                    <c:choose>
                        <c:when test="${empty carte}">
                            <div class="no-cards">Nessuna tessera</div>
                        </c:when>
                        <c:otherwise>
                            <select id="cartaSalvata" name="cartaSalvata">
                                <option value="empty">-- Seleziona --</option>
                                <c:forEach var="carta" items="${carte}">
                                    <option value="${carta.numeroCarta}">**** **** **** ${carta.numeroCarta.substring(carta.numeroCarta.length() - 4)} - ${carta.nome} ${carta.cognome}</option>
                                </c:forEach>
                            </select>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="margin: 15px 0; text-align:center;">oppure</div>
                <div class="add-card-form">
                    <label for="nuovaCarta">Inserisci una nuova carta</label>
                    <input type="text" id="nuovaCarta" name="nuovaCarta" placeholder="Numero carta (16 cifre)" maxlength="16" autocomplete="cc-number" inputmode="numeric">
                    <div class="form-row">
                        <div>
                            <label for="scadenza">Scadenza</label>
                            <input type="text" id="scadenza" name="scadenza" placeholder="MM/AA" maxlength="5" minlength="5" autocomplete="cc-exp" inputmode="numeric">
                        </div>
                        <div>
                            <label for="cvv">CVV</label>
                            <input type="text" id="cvv" name="cvv" maxlength="3" minlength="3" placeholder="CVV" autocomplete="cc-csc" inputmode="numeric">
                        </div>
                    </div>
                    <div class="form-row">
                        <div>
                            <label for="titolare">Titolare</label>
                            <input type="text" id="titolare" name="titolare" placeholder="Nome Cognome" minlength="2" autocomplete="cc-name">
                        </div>
                    </div>
                    <div class="form-row">
                        <div style="display: flex; align-items: center; margin-top: 10px;">
                            <input type="checkbox" id="salvaCarta" name="salvaCarta" value="true" style="margin-right: 6px; width: auto; margin-bottom: 0;">
                            <label for="salvaCarta" style="margin: 0;">Salva la carta</label>
                        </div>
                    </div>
                </div>
            </div>
            <div style="text-align:center; margin-top: 25px;">
                <button type="submit" id="confermaOrdineBtn">Conferma Ordine</button>
            </div>
        </form>
        <script>
        // Intercetta submit e invia via fetch
        var temp=0;
        document.addEventListener("DOMContentLoaded", function () {
            var form = document.querySelector(".order-form");
            var btn = document.getElementById("confermaOrdineBtn");
            form.addEventListener("submit", function (e) {
                e.preventDefault();
                btn.disabled = true;
                removeError();
                var formData = new FormData(form);
                fetch("confermaOrdine", {
                    method: "POST",
                    body: formData
                })
                .then(function (res) {
                    return res.json();
                })
                .then(function (data) {
                    if (data.status === "success") {
                        var form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '<%=request.getContextPath()%>/confirmOrder';
                        var input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'id';
                        input.value = data.id;
                        form.appendChild(input);
                        document.body.appendChild(form);
                        form.submit();
                    } else if (data.errors) {
                        // Mostra tutti gli errori
                        var allErrors = Object.values(data.errors).join("<br>");
                        showError(allErrors);
                    } else {
                        showError("Errore sconosciuto.");
                    }
                    btn.disabled = false;
                })
                .catch(function (err) {
                    showError("Errore di rete o server.");
                    btn.disabled = false;
                });
            });
            //Gestione formattazione scadenza
            var scadenza = document.getElementById("scadenza");
            if (scadenza) {
                scadenza.addEventListener("input", function (e) {
                    let val = scadenza.value.replace(/\D/g, ""); // Solo numeri
                    if (val.length > 2) {
                        val = val.substring(0, 2) + "/" + val.substring(2, 4);
                    }
                    scadenza.value = val.substring(0, 5); // Max 5 caratteri
                });
            }
        });
        </script>
    </div>
</div>
<script>
    function removeError() {
        let err = document.getElementById("order-form-error");
        if (err) err.remove();
    }

    function showError(msg) {
        var btn = document.getElementById("confermaOrdineBtn");
        let err = document.getElementById("order-form-error");
        if (!err) {
            err = document.createElement("div");
            err.id = "order-form-error";
            err.style.color = "red";
            err.style.textAlign = "center";
            err.style.marginTop = "10px";
            btn.parentNode.insertBefore(err, btn);
        }
        err.innerHTML = msg;
    }

    // Funzione per rendere la tabella responsive riducendo la dimensione del testo
    function resizeOrderTableFont() {
        var table = document.getElementById("orderTable");
        if (!table) return;
        var container = table.parentElement;
        var tableWidth = table.offsetWidth;
        var containerWidth = container.offsetWidth;
        // Se la tabella è più larga del container, riduci la dimensione del testo
        if (tableWidth > containerWidth || containerWidth < 500) {
            table.style.fontSize = "12px";
        } else {
            table.style.fontSize = "16px";
        }
    }

    window.addEventListener("resize", resizeOrderTableFont);
    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("cart-icon").src = "<%=request.getContextPath()%>/media/cartSelected.png";

        var select = document.getElementById("cartaSalvata");
        var btn = document.getElementById("confermaOrdineBtn");
        var nuovaCarta = document.getElementById("nuovaCarta");
        var scadenza = document.getElementById("scadenza");
        var cvv = document.getElementById("cvv");
        var titolare = document.getElementById("titolare");

        function checkForm() {
            // Se non ci sono carte salvate (select non esiste), controlla solo i campi della nuova carta
            // Funzione di validazione numero carta (16 cifre)
            function isValidCardNumber(num) {
                return /^\d{16}$/.test(num);
            }
            // Funzione di validazione telefono (minimo 7 cifre, solo numeri)
            function isValidPhone(num) {
                // Accetta solo numeri, minimo 7 cifre, massimo 10 (cellulari) o 11 (fissi), inizia con 0 o 3
                if (!/^\d{7,11}$/.test(num)) return false;
                // Deve iniziare con 0 (fisso) o 3 (cellulare)
                if (!(num.startsWith('0') || num.startsWith('3'))) return false;
                // Se inizia con 3 (cellulare), deve essere lungo 10 cifre
                if (num.startsWith('3') && num.length !== 10) return false;
                // Se inizia con 0 (fisso), deve essere lungo 9-11 cifre
                if (num.startsWith('0') && (num.length < 9 || num.length > 11)) return false;
                return true;
            }
            // Funzione di validazione CAP (5 cifre)
            function isValidCap(cap) {
                return /^\d{5}$/.test(cap);
            }
            // Funzione di validazione civico (almeno 1 carattere)
            function isValidCivico(civ) {
                return civ.trim().length > 0;
            }
            // Funzione di validazione nome/cognome/città/via (almeno 2 caratteri)
            function isValidText(txt) {
                return txt.trim().length >= 2;
            }

            // Recupero campi utente
            var nome = document.getElementById("nome");
            var cognome = document.getElementById("cognome");
            var telefono = document.getElementById("telefono");
            var via = document.getElementById("via");
            var civico = document.getElementById("civico");
            var cap = document.getElementById("cap");
            var citta = document.getElementById("citta");

            // Controllo parametri utente
            if (!isValidText(nome.value) || !isValidText(cognome.value) || !isValidPhone(telefono.value) || !isValidText(via.value) || !isValidCivico(civico.value) || !isValidCap(cap.value) || !isValidText(citta.value)) {
                btn.disabled = true;
                if (!isValidText(nome.value) || !isValidText(cognome.value)) {
                    showError("Nome e cognome devono avere almeno 2 caratteri.");
                } else if (!isValidPhone(telefono.value)) {
                    if (!/^\d+$/.test(telefono.value)) {
                        showError("Il telefono deve contenere solo numeri.");
                    } else if (!(telefono.value.startsWith('0') || telefono.value.startsWith('3'))) {
                        showError("Il telefono deve iniziare con 0 (fisso) o 3 (cellulare).");
                    } else if (telefono.value.startsWith('3') && telefono.value.length !== 10) {
                        showError("Il numero di cellulare deve essere di 10 cifre.");
                    } else if (telefono.value.startsWith('0') && (telefono.value.length < 9 || telefono.value.length > 11)) {
                        showError("Il numero fisso deve essere tra 9 e 11 cifre.");
                    } else {
                        showError("Il telefono non è valido.");
                    }
                } else if (!isValidText(via.value)) {
                    showError("La via deve avere almeno 2 caratteri.");
                } else if (!isValidCivico(civico.value)) {
                    showError("Il civico non può essere vuoto.");
                } else if (!isValidCap(cap.value)) {
                    showError("Il CAP deve essere di 5 cifre.");
                } else if (!isValidText(citta.value)) {
                    showError("La città deve avere almeno 2 caratteri.");
                }
                return;
            }

            if (!select) {
                if (
                    isValidCardNumber(nuovaCarta.value.trim()) &&
                    scadenza.value.trim() &&
                    cvv.value.trim() &&
                    titolare.value.trim()
                ) {
                    btn.disabled = false;
                    removeError();
                } else {
                    btn.disabled = true;
                    if (nuovaCarta.value.trim() && !isValidCardNumber(nuovaCarta.value.trim())) {
                        showError("Il numero della carta deve essere di 16 cifre.");
                    } else {
                        showError("Compila tutti i campi della carta per procedere.");
                    }
                }
                return;
            }
            // Se una carta salvata è selezionata, abilita il bottone
            if (select.value!=='empty') {
                btn.disabled = false;
                removeError();
            } else {
                if (
                    isValidCardNumber(nuovaCarta.value.trim()) &&
                    scadenza.value.trim() &&
                    cvv.value.trim() &&
                    titolare.value.trim()
                ) {
                    btn.disabled = false;
                    removeError();
                } else {
                    btn.disabled = true;
                    if (nuovaCarta.value.trim() && !isValidCardNumber(nuovaCarta.value.trim())) {
                        showError("Il numero della carta deve essere di 16 cifre.");
                    } else {
                        showError("Compila tutti i campi della carta per procedere.");
                    }
                }
            }
        }

        if (select) {
            select.addEventListener("change", checkForm);
        }
        [nuovaCarta, scadenza, cvv, titolare,
         document.getElementById("nome"),
         document.getElementById("cognome"),
         document.getElementById("telefono"),
         document.getElementById("via"),
         document.getElementById("civico"),
         document.getElementById("cap"),
         document.getElementById("citta")
        ].forEach(function (el) {
            if (el) el.addEventListener("input", checkForm);
        });
        resizeOrderTableFont();
    });
</script>
<%@ include file="/components/footer.jsp"%>
</body>
</html>
