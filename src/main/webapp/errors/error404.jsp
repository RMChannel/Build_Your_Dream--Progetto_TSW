<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Pagina Non Trovata</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/errors/style.css">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
<div class="container">
    <p class="status-code">404</p>
    <h1>Pagina Non Trovata</h1>
    <div class="emoji">🕵️‍♂️</div>
    <p class="message">
        Ops! Sembra che ti sei perso nel cyberspazio.
        <br>La pagina che stai cercando è svanita nel nulla!
    </p>
    <p>
        Potrebbe essere stata spostata, rinominata o forse è in vacanza.
        <br>Prova a controllare l'indirizzo o torna alla pagina principale.
    </p>
    <div class="buttons">
        <button class="btn" onclick="window.history.back()">Torna Indietro</button>
        <button class="btn" onclick="window.location.href='./'">Vai alla Home</button>
    </div>
    <div class="fun-fact">
        <strong>Lo sapevi?</strong> L'errore 404 è uno dei più famosi di Internet. È come andare in un
        indirizzo e scoprire che la casa che cercavi non esiste. Il nome "404" deriva dai primi giorni del web,
        quando i server CERN restituivano questo codice per le pagine non trovate.
    </div>
</div>
</body>
</html>