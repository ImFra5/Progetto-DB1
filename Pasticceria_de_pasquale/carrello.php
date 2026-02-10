<?php
session_start();
require_once("./database.php");

if (!isset($_SESSION['id_cliente'])) {
    die("Devi effettuare il login.");
}

$db = (new Database())->connect();
$id_cliente = (int)$_SESSION['id_cliente'];

// 1) Importo totale del carrello
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

$id_carrello = null;
$totale = 0.0;

if ($res->num_rows === 1) {
    $row = $res->fetch_assoc();
    $id_carrello = (int)$row["id_carrello"];
    $totale = (float)$row["totale"];
}

// 2) Lista prodotti nel carrello per il checkout
$stmt = $db->prepare("
    SELECT prodotto.nome, carrello_prodotto.quantita
    FROM carrello_prodotto
    JOIN prodotto
      ON prodotto.id_prodotto = carrello_prodotto.id_prodotto
    WHERE carrello_prodotto.id_carrello = ?
");
$stmt->bind_param("i", $id_carrello);
$stmt->execute();
$resProd = $stmt->get_result();
$stmt->close();
?>

<h2>Checkout</h2>

<?php if (!$id_carrello): ?>
  <p>Nessun carrello attivo.</p>
  <a href="mainpage.php">Torna ai prodotti</a>

<?php else: ?>

<ul>
<?php while ($r = $resProd->fetch_assoc()): ?>
  <li>
    <?php echo htmlspecialchars($r["nome"]); ?> —
    quantità: <?php echo (int)$r["quantita"]; ?>
  </li>
<?php endwhile; ?>
</ul>

<p><b>Totale da pagare: €<?php echo htmlspecialchars($totale); ?></b></p>

<form method="POST" action="checkout.php">
  <button type="submit">Acquista</button>
</form>

<a href="mainpage.php">Torna ai prodotti</a>

<?php endif; ?>
