<?php
$pdo = new PDO("mysql:host=localhost;dbname=gaestebuch", "root", "");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST["name"];
    $nachricht = $_POST["nachricht"];
    $stmt = $pdo->prepare("INSERT INTO eintraege (name, nachricht) VALUES (?, ?)");
    $stmt->execute([$name, $nachricht]);
}

$eintraege = $pdo->query("SELECT * FROM eintraege ORDER BY zeitstempel DESC")->fetchAll();
?>
<!DOCTYPE html>
<html lang="de">
<head><meta charset="UTF-8"><title>Gästebuch</title></head>
<body>
  <h1>Gästebuch</h1>
  <form method="post">
    Name: <input type="text" name="name"><br>
    Nachricht:<br>
    <textarea name="nachricht"></textarea><br>
    <input type="submit" value="Eintragen">
  </form>
  <h2>Einträge:</h2>
  <ul>
    <?php foreach ($eintraege as $e): ?>
      <li><strong><?= htmlspecialchars($e["name"]) ?></strong> (<?= $e["zeitstempel"] ?>):<br>
      <?= nl2br(htmlspecialchars($e["nachricht"])) ?></li>
    <?php endforeach; ?>
  </ul>
</body>
</html>
