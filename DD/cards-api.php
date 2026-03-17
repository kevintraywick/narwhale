<?php
// ============================================================
// Shadow of the Wolf — Cards API
// Queries the PostgreSQL card database
//
// Usage:
//   GET /DD/cards-api.php?type=spells                    → all spells
//   GET /DD/cards-api.php?type=spells&level=1            → level 1 spells
//   GET /DD/cards-api.php?type=spells&school=Evocation   → by school
//   GET /DD/cards-api.php?type=spells&class=Wizard       → by class
//   GET /DD/cards-api.php?type=spells&search=fire        → name search
//   GET /DD/cards-api.php?type=spells&id=42              → single spell
//   GET /DD/cards-api.php?type=items                     → all items
//   GET /DD/cards-api.php?type=potions                   → all potions
//   GET /DD/cards-api.php?type=weapons                   → all weapons
//   GET /DD/cards-api.php?type=players                   → all players
//
// Filters can be combined:
//   ?type=spells&level=2&school=Evocation&class=Wizard
// ============================================================

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once __DIR__ . '/cards/db-config.php';

$type = $_GET['type'] ?? '';
$allowed = ['spells', 'items', 'potions', 'weapons', 'players'];

if (!in_array($type, $allowed)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid type. Use: ' . implode(', ', $allowed)]);
    exit;
}

try {
    $db = getDB();

    // ── Single record by ID ──
    if (isset($_GET['id'])) {
        $stmt = $db->prepare("SELECT * FROM {$type} WHERE id = :id");
        $stmt->execute([':id' => (int)$_GET['id']]);
        $row = $stmt->fetch();
        if (!$row) {
            http_response_code(404);
            echo json_encode(['error' => 'Not found']);
        } else {
            // Convert PostgreSQL arrays to JSON arrays
            if ($type === 'spells' && isset($row['classes'])) {
                $row['classes'] = pgArrayToPhp($row['classes']);
            }
            if ($type === 'weapons' && isset($row['properties'])) {
                $row['properties'] = pgArrayToPhp($row['properties']);
            }
            echo json_encode($row);
        }
        exit;
    }

    // ── List with filters ──
    $where = [];
    $params = [];

    switch ($type) {
        case 'spells':
            if (isset($_GET['level'])) {
                $where[] = 'level = :level';
                $params[':level'] = (int)$_GET['level'];
            }
            if (isset($_GET['school'])) {
                $where[] = 'school ILIKE :school';
                $params[':school'] = $_GET['school'];
            }
            if (isset($_GET['class'])) {
                $where[] = ':class = ANY(classes)';
                $params[':class'] = $_GET['class'];
            }
            if (isset($_GET['concentration'])) {
                $where[] = 'concentration = :conc';
                $params[':conc'] = $_GET['concentration'] === 'true';
            }
            if (isset($_GET['ritual'])) {
                $where[] = 'ritual = :ritual';
                $params[':ritual'] = $_GET['ritual'] === 'true';
            }
            break;

        case 'items':
            if (isset($_GET['item_type'])) {
                $where[] = 'type ILIKE :item_type';
                $params[':item_type'] = $_GET['item_type'];
            }
            if (isset($_GET['rarity'])) {
                $where[] = 'rarity ILIKE :rarity';
                $params[':rarity'] = $_GET['rarity'];
            }
            if (isset($_GET['attunement'])) {
                $where[] = 'attunement = :attunement';
                $params[':attunement'] = $_GET['attunement'] === 'true';
            }
            break;

        case 'potions':
            if (isset($_GET['rarity'])) {
                $where[] = 'rarity ILIKE :rarity';
                $params[':rarity'] = $_GET['rarity'];
            }
            break;

        case 'weapons':
            if (isset($_GET['category'])) {
                $where[] = 'category ILIKE :category';
                $params[':category'] = '%' . $_GET['category'] . '%';
            }
            if (isset($_GET['magical'])) {
                $where[] = 'magical = :magical';
                $params[':magical'] = $_GET['magical'] === 'true';
            }
            break;

        case 'players':
            if (isset($_GET['player_class'])) {
                $where[] = 'class ILIKE :player_class';
                $params[':player_class'] = $_GET['player_class'];
            }
            break;
    }

    // Universal name search
    if (isset($_GET['search'])) {
        $where[] = 'name ILIKE :search';
        $params[':search'] = '%' . $_GET['search'] . '%';
    }

    $sql = "SELECT * FROM {$type}";
    if ($where) {
        $sql .= ' WHERE ' . implode(' AND ', $where);
    }
    $sql .= ' ORDER BY ' . ($type === 'spells' ? 'level, name' : 'name');

    // Pagination
    $limit = min((int)($_GET['limit'] ?? 200), 500);
    $offset = max((int)($_GET['offset'] ?? 0), 0);
    $sql .= " LIMIT {$limit} OFFSET {$offset}";

    $stmt = $db->prepare($sql);
    $stmt->execute($params);
    $rows = $stmt->fetchAll();

    // Convert PostgreSQL arrays for spells and weapons
    foreach ($rows as &$row) {
        if ($type === 'spells' && isset($row['classes'])) {
            $row['classes'] = pgArrayToPhp($row['classes']);
        }
        if ($type === 'weapons' && isset($row['properties'])) {
            $row['properties'] = pgArrayToPhp($row['properties']);
        }
    }

    echo json_encode($rows);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}

// ── Helper: convert PostgreSQL array string to PHP array ──
function pgArrayToPhp($str) {
    if (!$str || $str === '{}') return [];
    $str = trim($str, '{}');
    return array_map(function($s) {
        return trim($s, '"');
    }, str_getcsv($str));
}
