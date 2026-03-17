<?php
// ============================================================
// Shadow of the Wolf — Database Configuration
// Update these values to match your PostgreSQL setup
// ============================================================

define('DB_HOST', 'localhost');
define('DB_PORT', '5432');
define('DB_NAME', 'dd_cards');
define('DB_USER', 'dd_user');
define('DB_PASS', 'dd_pass');   // Change this in production!

function getDB() {
    static $pdo = null;
    if ($pdo === null) {
        $dsn = sprintf(
            'pgsql:host=%s;port=%s;dbname=%s',
            DB_HOST, DB_PORT, DB_NAME
        );
        $pdo = new PDO($dsn, DB_USER, DB_PASS, [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ]);
    }
    return $pdo;
}
