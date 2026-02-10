<?php
session_start();
require_once("./database.php");

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    die("Metodo non valido.");
}

if (!isset($_SESSION['id_cliente'])) {
    die("Devi effettuare il login.");
}

$database = new Database();
$db = $database->connect();

$id_cliente = (int)$_SESSION['id_cliente'];

try {
    $db->begin_transaction();

    // Recupera carrello attivo
    $stmt = $db->prepare("
        SELECT id_carrello, totale
        FROM carrello
        WHERE id_cliente = ? AND stato = 'attivo'
        LIMIT 1
    ");
    $stmt->bind_param("i", $id_cliente);
    $stmt->execute();
    $res = $stmt->get_result();
    $stmt->close();

    if ($res->num_rows !== 1) {
        throw new Exception("Nessun carrello attivo.");
    }

    $row = $res->fetch_assoc();
    $id_carrello = (int)$row["id_carrello"];
    $totale = (float)$row["totale"];

    if ($totale <= 0) {
        throw new Exception("Carrello vuoto.");
    }

    // Chiudi carrello
    $stato = "chiuso";
    $stmt = $db->prepare("UPDATE carrello SET stato = ? WHERE id_carrello = ?");
    $stmt->bind_param("si", $stato, $id_carrello);
    $stmt->execute();
    $stmt->close();

    $db->commit();
    $ok = true;

} catch (Throwable $e) {
    $db->rollback();
    $ok = false;
    $err = $e->getMessage();
}
?>
<!doctype html>
<html lang="it">
<head>
  <meta charset="utf-8">
  <title>Acquisto</title>
</head>
<body>

<?php if ($ok): ?>
  <p><b>Acquisto completato!</b></p>
  <p>Totale pagato: €<?php echo htmlspecialchars($totale); ?></p>
<?php else: ?>
  <p><b>Errore durante l'acquisto.</b></p>
  <p><?php echo htmlspecialchars($err ?? ""); ?></p>
<?php endif; ?>

<a href="mainpage.php">Torna ai prodotti</a>

</body>
</html>
