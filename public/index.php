<?php
require_once dirname(__DIR__) . '/app/shared/bootstrap.php';
?>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= e($config['app']['name']) ?></title>
    <link rel="stylesheet" href="<?= e(app_url('assets/css/style.css')) ?>">
</head>

<body>
    <h1><?= e($config['app']['name']) ?></h1>
    <?php
    require_once(e('check- db.php'));
    if (!isset($_SESSION['userID'])) {
        header("location:" . e(app_url('login.php')));
    } else {
        session_start();
        $sql = "SELECT role_id FROM users WHERE user_id = $_SESSION[userID]";
        if ($results = $mysqli->query(query: $sql)) {
            while ($record = $results->fetch_assoc()) {
                header("location: " . e(app_url('login.php?' . $record['role_id'])));
            }
        }


    } ?>
</body>

</html>