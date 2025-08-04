<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Informativa sulla Privacy - Build Your Dream</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/privacy/privacy.css">
</head>
<body>
<%@ include file="../components/header.jsp" %>

<div class="privacy-container">
    <div class="privacy-header">
        <h1>Informativa sulla Privacy</h1>
        <p class="last-updated">Ultimo aggiornamento: 07/05/2025</p>
    </div>

    <div class="privacy-content">
        <section class="privacy-section">
            <h2>1. Introduzione</h2>
            <p>La presente Informativa sulla Privacy descrive le modalità con cui Build Your Dream ("noi", "nostro" o "il Sito") raccoglie, utilizza e protegge i dati personali dei visitatori e degli utenti del nostro sito web. Rispettiamo la tua privacy e ci impegniamo a proteggere i tuoi dati personali in conformità con il Regolamento Generale sulla Protezione dei Dati (GDPR) e altre leggi applicabili sulla protezione dei dati.</p>
        </section>

        <section class="privacy-section">
            <h2>2. Dati che raccogliamo</h2>
            <p>Possiamo raccogliere i seguenti tipi di informazioni:</p>
            <ul>
                <li><strong>Informazioni personali</strong>: nome, indirizzo email, numero di telefono, indirizzo di spedizione e fatturazione quando effettui un acquisto o crei un account.</li>
                <li><strong>Informazioni di pagamento</strong>: dettagli della carta di credito o altri dettagli di pagamento (nota: i dati completi della carta di credito non vengono archiviati sui nostri server).</li>
                <li><strong>Dati di utilizzo</strong>: informazioni su come utilizzi il nostro sito, quali pagine visiti, quanto tempo trascorri su ciascuna pagina.</li>
                <li><strong>Dati tecnici</strong>: indirizzo IP, tipo di browser, provider di servizi Internet, informazioni sul dispositivo.</li>
                <li><strong>Cookie e tecnologie simili</strong>: utilizziamo cookie per migliorare la tua esperienza sul nostro sito.</li>
            </ul>
        </section>

        <section class="privacy-section">
            <h2>3. Come utilizziamo i tuoi dati</h2>
            <p>Utilizziamo i tuoi dati personali per i seguenti scopi:</p>
            <ul>
                <li>Elaborare e completare i tuoi ordini</li>
                <li>Gestire il tuo account</li>
                <li>Fornire assistenza clienti</li>
                <li>Inviarti comunicazioni di marketing (se hai dato il consenso)</li>
                <li>Migliorare il nostro sito web e i nostri prodotti/servizi</li>
                <li>Prevenire frodi e garantire la sicurezza del sito</li>
                <li>Adempiere agli obblighi legali</li>
            </ul>
        </section>

        <section class="privacy-section">
            <h2>4. Condivisione dei dati</h2>
            <p>Non vendiamo i tuoi dati personali a terze parti. Possiamo condividere i tuoi dati con:</p>
            <ul>
                <li>Fornitori di servizi che ci aiutano a gestire il nostro business (elaborazione pagamenti, spedizioni, hosting del sito)</li>
                <li>Autorità pubbliche o enti governativi quando richiesto dalla legge</li>
                <li>Partner commerciali con il tuo consenso esplicito</li>
            </ul>
        </section>

        <section class="privacy-section">
            <h2>5. Cookie</h2>
            <p>Utilizziamo cookie e tecnologie simili per vari scopi, tra cui:</p>
            <ul>
                <li>Cookie essenziali: necessari per il funzionamento del sito</li>
                <li>Cookie analitici: per capire come gli utenti interagiscono con il nostro sito</li>
                <li>Cookie di marketing: per mostrarti contenuti pertinenti in base ai tuoi interessi</li>
            </ul>
            <p>Puoi gestire le preferenze sui cookie attraverso le impostazioni del tuo browser.</p>
        </section>

        <section class="privacy-section">
            <h2>6. I tuoi diritti</h2>
            <p>In conformità con il GDPR, hai i seguenti diritti:</p>
            <ul>
                <li>Diritto di accesso ai tuoi dati personali</li>
                <li>Diritto di rettifica dei dati inesatti</li>
                <li>Diritto alla cancellazione (diritto all'oblio)</li>
                <li>Diritto di limitazione del trattamento</li>
                <li>Diritto alla portabilità dei dati</li>
                <li>Diritto di opposizione al trattamento</li>
                <li>Diritto di non essere sottoposto a decisioni automatizzate</li>
            </ul>
        </section>

        <section class="privacy-section">
            <h2>7. Sicurezza dei dati</h2>
            <p>Adottiamo misure tecniche e organizzative appropriate per proteggere i tuoi dati personali contro l'accesso non autorizzato, la perdita, la distruzione o il danneggiamento accidentale. Tutti i dati sensibili vengono trasmessi tramite connessioni sicure SSL/TLS.</p>
        </section>

        <section class="privacy-section">
            <h2>8. Conservazione dei dati</h2>
            <p>Conserviamo i tuoi dati personali solo per il tempo necessario agli scopi per cui sono stati raccolti, inclusi gli obblighi legali, contabili o di reporting.</p>
        </section>

        <section class="privacy-section">
            <h2>9. Modifiche alla presente Informativa</h2>
            <p>Ci riserviamo il diritto di aggiornare o modificare la presente Informativa sulla Privacy in qualsiasi momento. Le modifiche saranno pubblicate su questa pagina con la data dell'ultimo aggiornamento.</p>
        </section>
    </div>
</div>

<%@ include file="../components/footer.jsp" %>
</body>
</html>