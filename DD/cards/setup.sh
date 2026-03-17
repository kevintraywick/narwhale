#!/bin/bash
# ============================================================
# Shadow of the Wolf — Card Database Setup
#
# Run this once on your server to set up PostgreSQL for the
# spell/item/weapon/potion card system.
#
# Usage:
#   chmod +x setup.sh
#   ./setup.sh
#
# Prerequisites: PostgreSQL installed and running
# ============================================================

set -e

DB_NAME="dd_cards"
DB_USER="dd_user"
DB_PASS="dd_pass"

echo "================================================"
echo "  Shadow of the Wolf — Card Database Setup"
echo "================================================"
echo ""

# ── Step 1: Install PostgreSQL if needed ──
if ! command -v psql &> /dev/null; then
    echo "[1/5] PostgreSQL not found. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install postgresql@16
            brew services start postgresql@16
        else
            echo "ERROR: Install Homebrew first: https://brew.sh"
            exit 1
        fi
    else
        # Linux (Debian/Ubuntu)
        sudo apt-get update -qq
        sudo apt-get install -y postgresql postgresql-contrib php-pgsql
        sudo systemctl start postgresql
        sudo systemctl enable postgresql
    fi
    echo "  ✓ PostgreSQL installed and started"
else
    echo "[1/5] PostgreSQL already installed ✓"
fi

# ── Step 2: Create database and user ──
echo "[2/5] Creating database '${DB_NAME}' and user '${DB_USER}'..."

# Check if running as postgres user or need sudo
if command -v sudo &> /dev/null; then
    PSQL_CMD="sudo -u postgres psql"
else
    PSQL_CMD="psql -U postgres"
fi

# Create user (ignore error if exists)
$PSQL_CMD -c "CREATE USER ${DB_USER} WITH PASSWORD '${DB_PASS}';" 2>/dev/null || echo "  (user already exists)"

# Create database (ignore error if exists)
$PSQL_CMD -c "CREATE DATABASE ${DB_NAME} OWNER ${DB_USER};" 2>/dev/null || echo "  (database already exists)"

# Grant privileges
$PSQL_CMD -c "GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${DB_USER};" 2>/dev/null

echo "  ✓ Database and user ready"

# ── Step 3: Run schema ──
echo "[3/5] Creating tables..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PGPASSWORD="${DB_PASS}" psql -U "${DB_USER}" -d "${DB_NAME}" -h localhost -f "${SCRIPT_DIR}/schema.sql"
echo "  ✓ Tables created"

# ── Step 4: Seed spell data ──
echo "[4/5] Seeding spell data (levels 1–4)..."
PGPASSWORD="${DB_PASS}" psql -U "${DB_USER}" -d "${DB_NAME}" -h localhost -f "${SCRIPT_DIR}/seed_spells.sql"
echo "  ✓ Spells loaded"

# ── Step 5: Verify ──
echo "[5/5] Verifying..."
SPELL_COUNT=$(PGPASSWORD="${DB_PASS}" psql -U "${DB_USER}" -d "${DB_NAME}" -h localhost -t -c "SELECT COUNT(*) FROM spells;")
echo "  ✓ ${SPELL_COUNT} spells in database"

echo ""
echo "================================================"
echo "  Setup complete!"
echo ""
echo "  Database: ${DB_NAME}"
echo "  User:     ${DB_USER}"
echo "  Password: ${DB_PASS}"
echo ""
echo "  API endpoint: /DD/cards-api.php"
echo "  Card browser: /DD/cards/"
echo ""
echo "  Don't forget to update cards/db-config.php"
echo "  if you changed the password."
echo "================================================"
