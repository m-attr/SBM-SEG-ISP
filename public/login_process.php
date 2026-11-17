<?php
require_once('check-db.php');

$sqlstatement = "SELECT * FROM users WHERE user_id = '$_POST[email]' AND password = '$_POST[password]'";

if ($results = $mysqli->query(query: $sqlstatement)) {
    if ($results->num_rows > 0) {
        $record = $results->fetch_assoc();
        session_start();
        $_SESSION['user_id'] = $record['user_id'];
        $_SESSION['role_id'] = $record['role_id'];
        header("location: " . e(app_url('login.php?' . $record['role_id'])));
    } else {
        header(header: "location: login.php?error=invalidLogin");
    }

    $results->free_result();
    $mysqli->close();
}
?>