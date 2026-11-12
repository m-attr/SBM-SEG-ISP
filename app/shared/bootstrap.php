<?php
$configFile = dirname(__DIR__, 2) . '/config/local.php';
if (!is_file($configFile)) {
    http_response_code(500);
    exit('Local configuration is missing. Copy config/local.example.php to config/local.php and set app.base_path.');
}
$config = require $configFile;
$basePath = $config['app']['base_path'] ?? '/';
if (
    !is_string($basePath)
    || !str_starts_with($basePath, '/')
    || str_starts_with($basePath, '//')
    || str_contains($basePath, '\\')
    || preg_match('/[\x00-\x20?#]/', $basePath)
) {
    http_response_code(500);
    exit('Invalid application base path.');
}
define('APP_BASE_PATH', rtrim($basePath, '/'));

function app_url(string $path = ''): string
{
    return APP_BASE_PATH . '/' . ltrim($path, '/');
}

function e(string $value): string
{
    return htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
