# 💻 Build Your Dream

**Build Your Dream** è un sito web e-commerce sviluppato come progetto per l'esame di **TSW (Tecnologie e Software per il Web)**. Il sito consente agli utenti di acquistare componenti PC, preassemblati, accessori e di configurare un PC personalizzato attraverso un builder interattivo. È possibile registrarsi, salvare la propria configurazione e completare acquisti simulati.

---

## 📚 Tecnologie Utilizzate

- **Java 24**
- **Jakarta Servlet API 6.1.0**
- **Apache Tomcat 11**
- **JSP / HTML / CSS / JavaScript**
- **Maven** per la gestione delle dipendenze
- **MySQL** per il Database

---

## 🛒 Funzionalità principali

- 🧩 Visualizzazione componenti (CPU, GPU, RAM, ecc.)
- 🧰 Sezione accessori e preassemblati
- 🧠 Sistema di configurazione "PC Builder"
- 🔐 Registrazione e login utente
- 💾 Salvataggio configurazioni personalizzate
- 📩 Iscrizione alla newsletter
- 📞 Sezione "Contattaci"
- 🖥️ Interfaccia utente dinamica e responsive

---

## 📁 Struttura del progetto

```
Project-Build_Your_Dream/
│
├── src/
│   └── main/
│       ├── java/
│       │   ├── Controller/         # Servlet Java
│       │   ├── Database/           # Gestione database
│       │   ├── Foto/               # Gestione immagini
│       │   └── Model/              # Modelli dati
│       └── webapp/
│           ├── accessori/          # Pagine accessori
│           ├── admin/              # Area amministrazione
│           ├── builder/            # PC Builder
│           ├── carrello/           # Carrello acquisti
│           ├── components/         # Componenti PC
│           ├── contactUs/          # Contatti
│           ├── errors/             # Pagine errore
│           ├── media/              # File multimediali
│           ├── orders/             # Gestione ordini
│           ├── pezzi/              # Componenti singoli
│           ├── prebuilt/           # PC preassemblati
│           ├── privacy/            # Privacy policy
│           ├── table_page/         # Tabelle dati
│           ├── user/               # Area utente
│           └── WEB-INF/            # Configurazioni web
│               ├── bloccato.jsp
│               ├── categoryStyle.css
│               ├── home.css
│               └── index.jsp
│
├── pom.xml                         # Configurazione Maven
├── .mvn/                           # Wrapper Maven
└── README.md
```

---

## 🚀 Come eseguire il progetto

### Prerequisiti
- JDK 24 installato
- Apache Tomcat 11
- Maven installato (o usa `mvnw` incluso)

### Installazione e avvio

1. **Clona il repository**:
   ```bash
   git clone https://github.com/tuo-utente-github/build-your-dream.git
   cd build-your-dream
   ```

2. **Compila ed esegui il progetto**:
   ```bash
   mvn clean package
   ```

3. **Distribuisci il file `.war`** generato in:
   ```
   target/Project-Build_Your_Dream.war
   ```
   sulla cartella `webapps/` di Tomcat.

4. **Avvia Tomcat** e visita:
   ```
   http://localhost:8080/Project-Build_Your_Dream
   ```

---

## 📌 Note aggiuntive

- Tutte le funzionalità sono state progettate con attenzione all'esperienza utente e al responsive design
- Il progetto può essere esteso con un backend completo (ad esempio Spring Boot) o un'integrazione RESTful
- Il codice è organizzato in maniera modulare per facilitare future espansioni o refactoring

---

## 👨‍🎓 Autore

Progetto sviluppato da **Cito Roberto / Chikviladze Aleksandre**  
Corso di Tecnologie e Software per il Web  
Anno Accademico 2024/2025

---

## 📄 Licenza

⚠️ **Questo progetto è protetto e non può essere copiato, riutilizzato o distribuito senza autorizzazione esplicita dell'autore. È destinato esclusivamente alla presentazione come progetto personale nel portfolio.**