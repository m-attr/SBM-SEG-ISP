<?php

/**
 * Open a certificate-verified TLS connection to the configured MariaDB/MySQL database.
 * Call this only when a request needs the database.
 */
function database_connection(#[SensitiveParameter] array $settings): PDO
{
    if (!extension_loaded('pdo_mysql')) {
        throw new RuntimeException('The PDO MySQL extension is required.');
    }

    foreach (['host', 'name', 'username', 'password', 'ssl_ca'] as $key) {
        if (!isset($settings[$key]) || !is_string($settings[$key]) || $settings[$key] === '') {
            throw new InvalidArgumentException('Database configuration is incomplete. Check config/local.php.');
        }
    }

    $port = $settings['port'] ?? 3306;
    if (
        !preg_match('/\A[a-zA-Z0-9.-]+\z/', $settings['host'])
        || !preg_match('/\A[a-zA-Z0-9_-]+\z/', $settings['name'])
        || !is_int($port)
        || $port < 1
        || $port > 65535
    ) {
        throw new InvalidArgumentException('Invalid database host, name or port.');
    }
    if (!is_file($settings['ssl_ca']) || !is_readable($settings['ssl_ca'])) {
        throw new InvalidArgumentException('The database CA certificate bundle is missing or unreadable.');
    }

    $dsn = sprintf(
        'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
        $settings['host'],
        $port,
        $settings['name']
    );
    $pdo = new PDO($dsn, $settings['username'], $settings['password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
        PDO::ATTR_TIMEOUT => 10,
        PDO::MYSQL_ATTR_MULTI_STATEMENTS => false,
        PDO::MYSQL_ATTR_SSL_CA => $settings['ssl_ca'],
        PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT => true,
    ]);

    $tls = $pdo->query("SHOW SESSION STATUS LIKE 'Ssl_cipher'")->fetch();
    if (!$tls || ($tls['Value'] ?? '') === '') {
        throw new RuntimeException('The database connection is not encrypted. Check the SSL settings.');
    }

    return $pdo;
}
