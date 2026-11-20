<?php
require_once dirname(__DIR__) . '/../app/shared/bootstrap.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<?= e(app_url('/assets/css/css_reset.css')) ?>">
    <link rel="stylesheet" href="<?= e(app_url('/assets/css/common.css')) ?>">
    <title>Document</title>
    <style>

    </style>
</head>

<body>
    <table>
        <tr>
            <th>Student ID</th>
            <th>Student Name</th>
            <th>Level</th>
            <th colspan='2'>Actions</th>
        </tr>
        <tr>
            <td>ST-001</td>
            <td>Aaliyah Tan</td>
            <td>Primary 3</td>
            <td>
                <button class='btn unfilled'>View Classes</button>
            </td>
            <td>
                <button class='btn unfilled'>View Academic Progress</button>
            </td>
        </tr>
        <tr>
            <td colspan='5'>Showing 1 out of 1 student</td>
        </tr>
    </table>
</body>

</html>