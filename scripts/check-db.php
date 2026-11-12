<?php

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once dirname(__DIR__) . '/app/shared/bootstrap.php';
require_once dirname(__DIR__) . '/app/shared/database.php';

try {
    $pdo = database_connection($config['database'] ?? []);
    if ((int) $pdo->query('SELECT 1')->fetchColumn() !== 1) {
        throw new RuntimeException('Unexpected connection-check response.');
    }
    $tls = $pdo->query("SHOW SESSION STATUS LIKE 'Ssl_version'")->fetch();
    $tables = $pdo->query(
        'SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE()'
    )->fetchColumn();

    echo "Database connection: OK\n";
    echo 'Server: ' . $pdo->getAttribute(PDO::ATTR_SERVER_VERSION) . "\n";
    echo 'Transport: ' . ($tls['Value'] ?? 'TLS') . " (certificate verified)\n";
    echo 'Tables/views in the configured database: ' . $tables . "\n";
} catch (Throwable $error) {
    // Do not print credentials, connection strings or raw server errors.
    $message = $error instanceof PDOException
        ? 'Could not connect securely. Check the credentials, hostname, network access and CA bundle.'
        : $error->getMessage();
    fwrite(STDERR, "Database check failed: " . $message . "\n");
    exit(1);
}
