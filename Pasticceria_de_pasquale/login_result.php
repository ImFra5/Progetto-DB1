<?php
require_once("./authentication.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $database = new Authentication();
    $esito = $database->login($_POST);

    if ($esito === true) {
        header("Location: mainpage.php");
        exit();
    } else {
        echo "<p>Email o password errate</p>";
        echo '<a href="login.php"><button>Torna al login</button></a>';
        echo '<a href="homepage.php"><button>Torna alla homepage</button></a>';
    }
}
?>
