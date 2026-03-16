<?php
header('Content-Type: application/json');

// Handle map folder creation and image listing
$action = $_GET['action'] ?? '';
if ($action === 'mkSessionDir') {
    $title = trim($_GET['title'] ?? '');
    $slug = preg_replace('/[^a-zA-Z0-9]+/', '-', $title);
    $slug = trim($slug, '-');
    if (!$slug) { echo '{"folder":""}'; exit; }
    $dir = __DIR__ . '/maps/' . $slug;
    if (!is_dir($dir)) mkdir($dir, 0755, true);
    echo json_encode(['folder' => $slug]);
    exit;
}
if ($action === 'mapfiles') {
    $folder = basename($_GET['folder'] ?? '');
    if (!$folder) { http_response_code(400); echo '{"error":"invalid folder"}'; exit; }
    $imgDir = __DIR__ . '/maps/' . $folder;
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

$allowed = ['sessions', 'npcs', 'party', 'players', 'npc_cards', 'maps', 'magic'];
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
