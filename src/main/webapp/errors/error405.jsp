<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>405 - Metodo Non Consentito</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/errors/style.css">
  <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
</head>
<body>
<div class="container">
  <p class="status-code">405</p>
  <h1>Metodo Non Consentito</h1>
  <div class="emoji">🤦‍♂️</div>
  <p class="message">
    Ops! Hai provato ad utilizzare un metodo che non è gradito a questo URL.
    <br>È come tentare di aprire una porta con una forchetta!
  </p>
  <p>
    Sembra che tu stia cercando di comunicare con questo server in un modo che lui non capisce.
    <br>Prova a cambiare il tuo metodo di richiesta o torna alla pagina principale.
  </p>
  <div class="buttons">
    <button class="btn" onclick="window.history.back()">Torna Indietro</button>
    <button class="btn" onclick="window.location.href='./'">Vai alla Home</button>
  </div>
  <div class="fun-fact">
    <strong>Lo sapevi?</strong> L'errore 405 significa che hai provato ad usare un metodo HTTP (come POST, GET, DELETE)
    non supportato dalla risorsa che stai cercando di accedere. È come provare a parlare in francese con qualcuno che capisce solo l'italiano!
  </div>
</div>
</body>
</html>