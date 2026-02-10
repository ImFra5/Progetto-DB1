<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
?>

<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homepage</title>
</head>
<body>

    <h2>Benvenuto in pasticceria!</h2>

    <a href="registration.php">
        <button>Registrati</button>
    </a>

    <a href="login.php">
        <button>Login</button>
    </a>

</body>
</html>