-- ============================================================
-- Shadow of the Wolf — Card Database Schema
-- PostgreSQL
-- Run: psql -U dd_user -d dd_cards -f schema.sql
-- ============================================================

-- ── Spells ──
CREATE TABLE IF NOT EXISTS spells (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    level       INTEGER NOT NULL CHECK (level BETWEEN 0 AND 9),
    school      TEXT NOT NULL,           -- Abjuration, Conjuration, Divination, Enchantment, Evocation, Illusion, Necromancy, Transmutation
    casting_time TEXT NOT NULL,           -- '1 action', '1 bonus action', '1 minute', etc.
    range       TEXT NOT NULL,            -- 'Self', '30 feet', 'Touch', etc.
    components  TEXT NOT NULL,            -- 'V, S', 'V, S, M (a pinch of sand)', etc.
    duration    TEXT NOT NULL,            -- 'Instantaneous', '1 hour', 'Concentration, up to 1 minute', etc.
    concentration BOOLEAN NOT NULL DEFAULT FALSE,
    ritual      BOOLEAN NOT NULL DEFAULT FALSE,
    description TEXT NOT NULL,
    higher_levels TEXT,                   -- "At Higher Levels" text, nullable
    classes     TEXT[] NOT NULL,          -- Array: {'Wizard','Sorcerer','Bard'}
    source      TEXT NOT NULL DEFAULT 'SRD 5.1',
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_spells_level ON spells(level);
CREATE INDEX IF NOT EXISTS idx_spells_school ON spells(school);
CREATE INDEX IF NOT EXISTS idx_spells_name ON spells(name);

-- ── Magic Items (general) ──
CREATE TABLE IF NOT EXISTS items (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    type        TEXT NOT NULL,            -- 'Wondrous item', 'Ring', 'Rod', 'Staff', 'Wand', 'Armor', 'Potion', 'Scroll'
    rarity      TEXT NOT NULL,            -- 'Common', 'Uncommon', 'Rare', 'Very Rare', 'Legendary', 'Artifact'
    attunement  BOOLEAN NOT NULL DEFAULT FALSE,
    attunement_req TEXT,                  -- 'by a spellcaster', 'by a cleric', null if no attunement
    description TEXT NOT NULL,
    value_gp    INTEGER,                  -- estimated gold value, nullable
    source      TEXT NOT NULL DEFAULT 'SRD 5.1',
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_items_type ON items(type);
CREATE INDEX IF NOT EXISTS idx_items_rarity ON items(rarity);

-- ── Potions (specialized subset, also in items but with extra fields) ──
CREATE TABLE IF NOT EXISTS potions (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    rarity      TEXT NOT NULL,
    effect      TEXT NOT NULL,
    duration    TEXT,                     -- 'Instantaneous', '1 hour', etc.
    value_gp    INTEGER,
    description TEXT NOT NULL,
    source      TEXT NOT NULL DEFAULT 'SRD 5.1',
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_potions_rarity ON potions(rarity);

-- ── Weapons ──
CREATE TABLE IF NOT EXISTS weapons (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    category    TEXT NOT NULL,            -- 'Simple Melee', 'Simple Ranged', 'Martial Melee', 'Martial Ranged'
    damage      TEXT NOT NULL,            -- '1d8 slashing', '1d6 piercing', etc.
    damage_type TEXT NOT NULL,            -- 'Slashing', 'Piercing', 'Bludgeoning'
    properties  TEXT[],                   -- {'Light','Finesse','Thrown (20/60)'}
    weight_lb   NUMERIC(5,1),
    value_gp    NUMERIC(8,2),
    magical     BOOLEAN NOT NULL DEFAULT FALSE,
    bonus       INTEGER DEFAULT 0,        -- +1, +2, +3 for magic weapons
    description TEXT,
    source      TEXT NOT NULL DEFAULT 'SRD 5.1',
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_weapons_category ON weapons(category);

-- ── Players (syncs with your existing JSON player data) ──
CREATE TABLE IF NOT EXISTS players (
    id          TEXT PRIMARY KEY,         -- matches your player IDs: 'levi', 'jeanette', etc.
    player_name TEXT NOT NULL,
    char_name   TEXT NOT NULL,
    class       TEXT NOT NULL,
    species     TEXT NOT NULL,
    level       INTEGER NOT NULL DEFAULT 1,
    hp          INTEGER,
    max_hp      INTEGER,
    ac          INTEGER,
    str         INTEGER, dex INTEGER, con INTEGER,
    int_stat    INTEGER, wis INTEGER, cha INTEGER,
    portrait    TEXT,                     -- image filename
    notes       TEXT,
    created_at  TIMESTAMPTZ DEFAULT NOW(),
    updated_at  TIMESTAMPTZ DEFAULT NOW()
);
