<?php
require_once("./authentication.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $database = new Authentication();
    $esito = $database->register($_POST);

    if ($esito === true) {
        header("Location: login.php");
        exit();
    } 
    else 
    {
        echo "<p>Utente già registrato o dati non validi</p>";
        echo '<a href="registration.php"><button>Torna alla registrazione</button></a>';
        echo '<a href="homepage.php"><button>Torna alla homepage</button></a>';
    }
}
?>