<?php
header('Content-Type: application/json');

// Handle map image listing
$action = $_GET['action'] ?? '';
if ($action === 'mapfiles') {
    $sessId = preg_replace('/[^a-z0-9]/i', '', $_GET['session'] ?? '');
    if (!$sessId) { http_response_code(400); echo '{"error":"invalid session"}'; exit; }
    $imgDir = __DIR__ . '/maps/images/' . $sessId;
    if (!is_dir($imgDir)) mkdir($imgDir, 0755, true);
    $files = [];
    foreach (scandir($imgDir) as $f) {
        if (preg_match('/^(\d+)\.(jpe?g|png|gif|webp)$/i', $f, $m)) {
            $files[(int)$m[1]] = $f;
        }
    }
    echo json_encode($files);
    exit;
}

$allowed = ['sessions', 'npcs', 'party', 'players', 'npc_cards', 'maps'];
$key = $_GET['key'] ?? '';

if (!in_array($key, $allowed, true)) {
    http_response_code(400);
    echo '{"error":"invalid key"}';
    exit;
}

$dir  = __DIR__ . '/data';
$file = $dir . '/' . $key . '.json';

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
