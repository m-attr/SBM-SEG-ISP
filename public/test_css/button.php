<?php
require_once dirname(__DIR__) . '/../app/shared/bootstrap.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<?= e(app_url('/assets/css/common.css')) ?>">
    <title>Document</title>
    <style>
        .parentElement {
            width: 200px;
            border: 1px solid black;
        }
    </style>
</head>

<body>
    <div class="parentElement">
        <button type=" button" class="button">Click Me!</button>
    </div>
</body>

</html>