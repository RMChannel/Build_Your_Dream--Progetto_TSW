<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Sito in Manutenzione</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0a1929;
            color: #e0e6f0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 800px;
            padding: 30px;
            background-color: #132f4c;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.8s ease-in;
        }
        h1 {
            color: #66b2ff;
            font-size: 3rem;
            margin-bottom: 10px;
        }
        .status-code {
            font-size: 5rem;
            color: #66b2ff;
            font-weight: bold;
            margin: 0;
            text-shadow: 0 0 10px rgba(102, 178, 255, 0.3);
        }
        .message {
            font-size: 1.5rem;
            margin: 20px 0;
            line-height: 1.5;
        }
        .emoji {
            font-size: 5rem;
            margin: 20px 0;
            animation: bounce 2s infinite;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-20px);
            }
        }
        @media (max-width: 600px) {
            .status-code {
                font-size: 3rem;
            }
            h1 {
                font-size: 2rem;
            }
            .message {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="emoji" title="Manutenzione">🛠️</div>
        <div class="status-code">503</div>
        <h1>Sito in Manutenzione</h1>
        <div class="message">
            Stiamo lavorando per migliorare il servizio.<br>
            Il sito è temporaneamente non disponibile.<br>
            Torna a trovarci tra poco!
        </div>
        <form action="login" method="post" style="margin-top: 35px;">
            <h2 style="color:#66b2ff; font-size:1.3rem; margin-bottom:10px;">Login Amministrazione</h2>
            <input type="text" name="username" placeholder="Username" required style="width: 80%; max-width: 300px; padding: 10px; margin-bottom: 10px; border-radius: 6px; border: none; font-size: 1rem;">
            <br>
            <input type="password" name="password" placeholder="Password" required style="width: 80%; max-width: 300px; padding: 10px; margin-bottom: 15px; border-radius: 6px; border: none; font-size: 1rem;">
            <br>
            <button type="submit" style="background-color: #1976d2; color: white; border: none; padding: 10px 25px; border-radius: 8px; font-size: 1rem; cursor: pointer; transition: all 0.3s;">Login</button>
        </form>
        <button onclick="window.location.href='<%=request.getContextPath()%>'" style="background-color: #2196f3; color: white; border: none; padding: 10px 25px; border-radius: 8px; font-size: 1rem; cursor: pointer; margin-top: 18px; transition: all 0.3s;">Ricarica</button>
    </div>
</body>
</html>
