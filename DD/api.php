<?php
$allowed = ['sessions', 'npcs', 'party', 'players'];
$key = $_GET['key'] ?? '';

if (!in_array($key, $allowed, true)) {
    http_response_code(400);
    echo '{"error":"invalid key"}';
    exit;
}

$dir  = __DIR__ . '/data';
$file = $dir . '/' . $key . '.json';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    echo file_exists($file) ? file_get_contents($file) : '[]';

} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $body = file_get_contents('php://input');
    json_decode($body);
    if (json_last_error() !== JSON_ERROR_NONE) {
        http_response_code(400);
        echo '{"error":"invalid json"}';
        exit;
    }
    if (!is_dir($dir)) mkdir($dir, 0755, true);
    file_put_contents($file, $body, LOCK_EX);
    echo '{"ok":true}';
} else {
    http_response_code(405);
    echo '{"error":"method not allowed"}';
}
