<?php
session_start();
require_once("./database.php");

if (!isset($_SESSION['id_cliente'])) {
    die("Devi effettuare il login.");
}

$db = (new Database())->connect();
$id_cliente = (int)$_SESSION['id_cliente'];
$msg = "";

// AGGIUNTA PRODOTTO AL CARRELLO
if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $id_prodotto = (int)($_POST["id_prodotto"] ?? 0);
    $quantita    = (int)($_POST["quantita"] ?? 1);

    if ($id_prodotto > 0 && $quantita > 0) {

        try {
            $db->begin_transaction();

            // 1) Carrello attivo o creazione
            $stmt = $db->prepare("
                SELECT id_carrello
                FROM carrello
                WHERE id_cliente = ? AND stato = 'attivo'
                LIMIT 1
            ");
            $stmt->bind_param("i", $id_cliente);
            $stmt->execute();
            $res = $stmt->get_result();

            if ($res->num_rows === 1) {
                $id_carrello = (int)$res->fetch_assoc()["id_carrello"];
            } else {
                $stato = "attivo";
                $totale = 0.0;
                $stmt2 = $db->prepare("
                    INSERT INTO carrello (id_cliente, stato, totale)
                    VALUES (?, ?, ?)
                ");
                $stmt2->bind_param("isd", $id_cliente, $stato, $totale);
                $stmt2->execute();
                $id_carrello = (int)$db->insert_id;
                $stmt2->close();
            }
            $stmt->close();

            // 2) Prezzo prodotto
            $stmt = $db->prepare("
                SELECT prezzo_corrente
                FROM prodotto
                WHERE id_prodotto = ?
            ");
            $stmt->bind_param("i", $id_prodotto);
            $stmt->execute();
            $prezzo = (float)$stmt->get_result()->fetch_assoc()["prezzo_corrente"];
            $stmt->close();

            // 3) Inserimento / aggiornamento tabella ponte
            $stmt = $db->prepare("
                INSERT INTO carrello_prodotto (id_carrello, id_prodotto, quantita, prezzo_c_uno)
                VALUES (?, ?, ?, ?)
                ON DUPLICATE KEY UPDATE
                    quantita = quantita + VALUES(quantita)
            ");
            $stmt->bind_param("iiid", $id_carrello, $id_prodotto, $quantita, $prezzo);
            $stmt->execute();
            $stmt->close();

            // 4) Aggiorno totale carrello
            $stmt = $db->prepare("
                SELECT SUM(quantita * prezzo_c_uno) AS totale
                FROM carrello_prodotto
                WHERE id_carrello = ?
            ");
            $stmt->bind_param("i", $id_carrello);
            $stmt->execute();
            $totale = (float)$stmt->get_result()->fetch_assoc()["totale"];
            $stmt->close();

            $stmt = $db->prepare("
                UPDATE carrello SET totale = ?
                WHERE id_carrello = ?
            ");
            $stmt->bind_param("di", $totale, $id_carrello);
            $stmt->execute();
            $stmt->close();

            $db->commit();
            $msg = "Prodotto aggiunto al carrello.";

        } catch (Throwable $e) {
            $db->rollback();
            $msg = "Errore.";
        }
    }
}

// LISTA PRODOTTI
$stmt = $db->prepare("
    SELECT id_prodotto, nome, prezzo_corrente
    FROM prodotto
");
$stmt->execute();
$prodotti = $stmt->get_result();
$stmt->close();
?>

<!doctype html>
<html lang="it">
<head>
  <meta charset="utf-8">
  <title>Prodotti</title>
</head>
<body>

<h2>Seleziona un prodotto</h2>

<?php if ($msg): ?>
  <p><?php echo htmlspecialchars($msg); ?></p>
<?php endif; ?>

<form method="POST">
    <select name="id_prodotto" required>
        <option value="">-- scegli --</option>
        <?php while ($p = $prodotti->fetch_assoc()): ?>
            <option value="<?php echo (int)$p["id_prodotto"]; ?>">
                <?php echo htmlspecialchars($p["nome"]); ?>
                (€<?php echo htmlspecialchars($p["prezzo_corrente"]); ?>)
            </option>
        <?php endwhile; ?>
    </select>

    <input type="number" name="quantita" min="1" value="1">
    <button type="submit">Aggiungi</button>
</form>

<p>
  <a href="carrello.php">Vai al checkout</a>
</p>

</body>
</html>
