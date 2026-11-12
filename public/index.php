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
    <p>The local project foundation is ready.</p>
</body>
</html>
