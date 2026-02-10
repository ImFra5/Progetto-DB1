<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione</title>
</head>
<body>
    <div class="container">
        <h2>Registrazione</h2>
        <div id="message"></div>
        <form id="registerForm" method="POST" action="registration_result.php">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required>
            </div>
            <div class="form-group">
                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome" required>
            </div>
            <div class="form-group">
                <label for="email">email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="data_di_nascita">Data di nascità:</label>
                <input type="date" id="data_di_nascita" name="data_di_nascita" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="indirizzo">indirizzo:</label>
                <input type="text" id="indirizzo" name="indirizzo" required>
            </div>
            <div class="form-group">
                <label for="cellulare">cellulare:</label>
                <input type="tel" id="cellulare" name="cellulare" required>
            </div>
            <button type="submit">Registrati</button>
        </form>
    </div>
    <a 
        href="homepage.php"><button>Torna alla homepage</button>
    </a>

</body>
</html>