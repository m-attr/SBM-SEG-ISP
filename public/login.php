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
    <main>
        <div id="form">
            <form name="login form" id="login_form" action="login_process.php" method="post">
                <fieldset>
                    <div class="formField">
                        <div><label for="email: ">Email Address: </label><br></div>
                        <input type="text" id="email" name="email" placeholder="Email">
                        <div id="email_err" class="err_label"></div>
                    </div>
                    <br>
                    <div class="formField">
                        <div><label for="password: ">Password: </label><br></div>
                        <input type="password" name="password" id="password" placeholder="Password">
                        <div id="password_err" class="err_label"></div>
                    </div>
                    <div id="submitbutton">
                        <input type="submit" class="button" value="Login">
                    </div>
                </fieldset>
            </form>
            <?php
            if (isset($_GET['error']) && $_GET['error'] == 'invalidLogin') {
                echo "<script>document.getElementById('submission_err').innerHTML = 'Invalid login'</script>";
            } ?>
        </div>

    </main>
    <script src="js/jquery.js"></script>
    <script src="js/login.js"></script>
</body>

</html>