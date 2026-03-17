# Shadow of the Wolf — DM Companion Site

<!-- ============================================================
     WHAT IS THIS FILE?

     This is a "claude.md" file — a project guide that gives AI
     assistants (like Claude) the context they need to help you
     effectively. Think of it as a README, but written specifically
     so an AI can understand your codebase, conventions, and goals
     at a glance.

     WHY DOES IT MATTER?

     Without this file, every time you start a new conversation
     with Claude about your project, it has to re-discover how
     things work by reading your code. This file shortcuts that
     process and leads to better, more consistent help.

     KEEPING IT CURRENT:

     The most important thing about a claude.md is that it stays
     accurate. When you add a new page, data key, or feature:

       1. Add the file to the "File Layout" section below
       2. If it uses a new API key, add it to "API Keys"
       3. Add a line to "Current Features"
       4. If it's an AI feature, add it to "AI Roadmap"

     You can also just ask Claude: "Update the claude.md to
     reflect the changes we just made" after any work session.
     ============================================================ -->


## Project Overview

<!-- This section tells Claude what the project IS so it doesn't
     have to guess from the code. Keep it to a short paragraph. -->

A multi-page web app for D&D Dungeon Masters, currently running the
"Shadow of the Wolf" campaign. It helps DMs manage sessions, track
players and NPCs, organize maps, and (over time) integrate AI
features like automated session recaps from filmed tabletop play.

The project has three goals:

1. **Run our campaign.** Serve as the day-to-day toolkit for the
   Shadow of the Wolf campaign and its players.
2. **Be useful to any DM.** The site should be general-purpose
   enough that another DM could pick it up for their own campaign
   with minimal changes (swap player data, drop in their own maps).
3. **Stay extensible.** New features — especially AI-powered ones —
   should be easy to add over time without rearchitecting what
   already exists. That's why we keep patterns simple and consistent.


## Tech Stack

<!-- Listing the stack explicitly prevents Claude from suggesting
     libraries or frameworks you aren't using. Update this if you
     introduce new dependencies (e.g., a JS framework). -->

- **Frontend:** Vanilla HTML, CSS, and JavaScript (no framework)
- **Backend:** Single PHP file (`api.php`) serving JSON read/write
- **Card Database:** PostgreSQL (`dd_cards` database) for spell/item/weapon/potion data
- **Card API:** `cards-api.php` — separate PHP endpoint querying PostgreSQL
- **Data storage:** Flat JSON files in `data/` (one per data type) for session/player/NPC data
- **External JS:** SortableJS (CDN) for drag-and-drop reordering
- **Hosting:** Served from `/DD/` path on a local or shared server
- **Plugins:** `anthropics/claude-code`, `frontend-design@claude-code-plugins`, `pbakaus/impeccable`


## File Layout

<!-- This is the section that needs updating most often. When you
     add a new page or directory, drop it in here with a one-line
     description. Claude uses this to know where things live. -->

```
DD/
├── index.html              # Home / session hub — splash image, session list, nav
├── session.html            # Session prep sheet — goal, scenes, NPCs, locations, notes
├── party.html              # Party tracker — character cards with HP, class, level
├── boons.html              # Printable boon cards for each player (print-friendly CSS)
├── npcs.html               # (Legacy) static NPC reference page
├── api.php                 # Backend API — JSON CRUD + map folder management
├── SOTW_splash.png         # Campaign splash artwork
│
├── players/
│   ├── players.html        # Player sheets — stats, gear, boons, notes per player
│   └── images/             # Player/character portraits (levi.png, Levi-Garrick.png, etc.)
│
├── npcs/
│   ├── index.html          # Dynamic NPC manager — add/edit/delete NPC cards
│   └── images/             # NPC portraits (named after NPC, e.g., lich.png)
│
├── maps/
│   ├── index.html          # Map grid per session — titles, notes, images
│   └── images/             # Shared map images (dungeon_entrance.jpeg, etc.)
│   └── <session-slug>/     # Auto-created folders for per-session map images
│
├── marketplace.html        # Player marketplace — buy/sell/trade items between players
│
├── cards/
│   ├── index.html          # Spell card browser — filterable grid of SRD spell cards
│   ├── schema.sql          # PostgreSQL schema (spells, items, potions, weapons, players tables)
│   ├── seed_spells.sql     # 166 SRD spells (levels 1–4) as INSERT statements
│   ├── db-config.php       # PostgreSQL connection settings (host, port, db, user, pass)
│   └── setup.sh            # One-command database setup script
│
├── cards-api.php           # REST API for card queries — reads from PostgreSQL
│
├── magic/
│   ├── index.html          # Magic quick reference — spells, curses, items, powers
│   └── descriptions/       # Preloaded JSON descriptions for instant lookup
│       ├── spells.json     # Cantrips and 1st-level spells by class
│       ├── curses.json     # Curse effects and descriptions
│       ├── items.json      # Magic items (potions, weapons, wondrous)
│       └── powers.json     # Class features and abilities
│
├── audio/
│   └── wolf-howl.mp3       # Sound effect played on Players nav click
│
├── data/                   # JSON data store (protected by .htaccess)
│   └── .htaccess           # "Deny from all" — blocks direct browser access
│
├── skills/                 # Claude skills — reusable instructions for common tasks
│   ├── skills.md           # Overview of all skills + how to add new ones
│   ├── update-docs/        # Skill: update claude.md after project changes
│   │   └── SKILL.md
│   └── add-npc/            # Skill: add a new NPC to the campaign
│       └── SKILL.md
│
└── claude.md               # This file
```


## API Pattern

<!-- This is the core pattern Claude needs to understand to help
     you add features. Every page follows the same approach. -->

All data flows through a single endpoint: **`/DD/api.php`**

### JSON CRUD (the main pattern)

Every page reads and writes data using the same two calls:

```
GET  /DD/api.php?key=<name>       → returns JSON array or object
POST /DD/api.php?key=<name>       → body is the full JSON to save
```

The `key` parameter maps to a file: `data/<key>.json`. The API
validates that the key is in an allow-list and that the POST body
is valid JSON.

### API Keys Currently in Use

<!-- Add a row here whenever you create a new data type. This is
     how Claude knows what's available without reading api.php. -->

| Key         | Used By            | Shape       | Description                        |
|-------------|--------------------|-----------  |------------------------------------|
| `sessions`  | index.html, session.html, maps/ | Array of objects | Session list with prep notes  |
| `players`   | players/players.html | Object (keyed by player ID) | Player sheet data   |
| `npc_cards` | npcs/index.html    | Array of objects | Dynamic NPC cards              |
| `party`     | party.html         | Array of objects | Party character tracker         |
| `maps`      | maps/index.html    | Object (keyed by session ID) | Map grid data per session |
| `npcs`      | npcs.html          | Array       | (Legacy) NPC data                  |
| `magic`     | magic/index.html   | Array of objects | Magic lookup history (circles)  |
| `marketplace` | marketplace.html | Object { market, players } | Market inventory + player gold/items |

### Special API Actions

```
GET /DD/api.php?action=mkSessionDir&title=<title>  → creates maps/<slug>/ folder
GET /DD/api.php?action=mapfiles&folder=<slug>       → lists numbered images in folder
```

### Cards API (PostgreSQL)

A separate endpoint for card data that reads from PostgreSQL:

```
GET /DD/cards-api.php?type=spells                    → all spells
GET /DD/cards-api.php?type=spells&level=1            → by level (1–4)
GET /DD/cards-api.php?type=spells&school=Evocation   → by school
GET /DD/cards-api.php?type=spells&class=Wizard       → by class
GET /DD/cards-api.php?type=spells&search=fire        → name search
GET /DD/cards-api.php?type=spells&id=42              → single spell by ID
GET /DD/cards-api.php?type=items                     → all magic items
GET /DD/cards-api.php?type=potions                   → all potions
GET /DD/cards-api.php?type=weapons                   → all weapons
GET /DD/cards-api.php?type=players                   → all players
```

Filters can be combined: `?type=spells&level=2&school=Evocation&class=Wizard`

Pagination: `&limit=50&offset=0` (default limit 200, max 500)

**Database:** `dd_cards` on PostgreSQL, connection configured in `cards/db-config.php`

**Setup:** Run `cards/setup.sh` to install PostgreSQL, create the database, and seed all spell data.

**PostgreSQL tables:** `spells` (166 rows, levels 1–4), `items`, `potions`, `weapons`, `players` (schema ready, items/potions/weapons/players pending seed data)

### How to Add a New Data Type

1. Pick a key name (e.g., `quests`)
2. Add it to the `$allowed` array in `api.php`
3. Create your page and use the same fetch pattern:
   ```js
   const API = '/DD/api.php?key=quests';
   async function load() { return fetch(API).then(r => r.json()); }
   async function save(data) {
     await fetch(API, {
       method: 'POST',
       headers: { 'Content-Type': 'application/json' },
       body: JSON.stringify(data)
     });
   }
   ```


## UI / Design Conventions

<!-- These conventions keep the site looking consistent. Claude
     should follow these when generating new pages or components. -->

- **Color palette** (CSS custom properties used across all pages):
  - `--bg: #1a1614` (page background) or `#2a3140` (home page)
  - `--surface: #231f1c` (cards, panels)
  - `--border: #3d3530` (subtle borders)
  - `--gold: #c9a84c` (headings, active states, accents)
  - `--accent: #8b1a1a` (buttons, destructive actions — blood red)
  - `--text: #e8ddd0` (body text)
  - `--muted: #8a7d6e` (secondary text, labels)
  - `--green: #5a8a5a` (save confirmations)

- **Typography:** Georgia, serif throughout
- **Layout:** Max-width 860px, centered
- **Navigation:** Consistent nav bar linking Sessions, NPCs, Players, Maps, Magic, Marketplace, Cards
- **Autosave:** All pages debounce saves at 600ms after input, with
  a small "saving…" / "saved" indicator (usually fixed bottom-right)
- **IDs:** Generated with `Date.now().toString(36)` for uniqueness
- **No build step:** Everything is plain files — no bundler, no npm


## Current Players

<!-- This helps Claude reference characters correctly. Update if
     players join/leave or change characters. -->

| Player   | Character  | Class/Species        |
|----------|------------|----------------------|
| Levi     | Garrick    | Gnome Ranger         |
| Jeanette | Eleil      | Elf Druid            |
| Nicole   | HollyGo    | Goliath Paladin      |
| Katie    | Lysandra   | Elf Bard             |
| Brandon  | Vaoker     | Dwarf Fighter        |
| Ashton   | Ash        | Human Fighter        |


## Current Features

<!-- A simple checklist of what exists. Helps Claude avoid
     suggesting features you already have, and shows what's done.
     Mark new features with the date you added them. -->

- [x] Session hub with create/delete/reorder (SortableJS)
- [x] Session prep sheets (goal, scenes, NPCs, locations, notes)
- [x] Player character sheets with stats, boons, gear, notes
- [x] Dynamic NPC manager (add/edit/delete with portraits)
- [x] Party tracker with HP, class, and notes
- [x] Map grid per session with image support
- [x] Auto-created map folders per session
- [x] Printable boon cards (print-friendly layout)
- [x] Autosave on all editable pages
- [x] Audio effect on nav (wolf howl)
- [x] Magic quick reference (spells, curses, items, powers with preloaded descriptions)
- [x] Player marketplace with buy/sell/trade, item circles, character selection
- [x] Structured gear on player sheets (item circles replacing free-text)
- [x] Spell card browser with PostgreSQL backend (166 SRD spells, levels 1–4)
- [x] Cards API with filtering by level, school, class, and name search
- [ ] Item/potion/weapon card seed data (schema ready, data pending)
- [ ] Player card integration (sync player JSON data into PostgreSQL)
- [ ] Session recap (AI-generated from filmed miniatures)
- [ ] Episodic replay viewer
- [ ] Quest/thread tracker
- [ ] Encounter builder
- [x] Loot/inventory manager (via Marketplace)
- [ ] Player-uploaded portrait images


## AI Roadmap

<!-- This is the long-term vision. It helps Claude understand
     where the project is headed so suggestions align with your
     goals. Add ideas here as they come up. -->

The core vision is to layer AI capabilities onto the DM toolkit
over time. Priority features:

### 1. Session Recap from Filmed Play (Primary Goal)
- Film the miniatures/tabletop during an in-person session
- Feed the video (or stills) to an AI vision model
- AI generates a narrative session recap describing what happened
- Recaps are stored per session and browsable as an episodic series
- **Considerations:** Video processing cost, frame sampling strategy,
  combining visual context with session prep notes for better output

### 2. Episodic Replay
- Present session recaps as a story timeline or "episode guide"
- Each episode links to the session, maps, and NPCs involved
- Could include AI-generated illustrations or scene descriptions

### 3. Card System Expansion
- Seed data for items, potions, and weapons tables (schema is ready)
- Sync player JSON data into the PostgreSQL `players` table
- Add tab navigation to cards page (Spells / Items / Potions / Weapons / Players)
- Print-friendly spell card layout for physical reference at the table
- Card detail pages with full descriptions and artwork slots

### 4. Future AI Ideas (Brainstorm)
- NPC dialogue generator (voice/personality based on NPC notes)
- Encounter balancing suggestions based on party composition
- Auto-populate session prep from loose ends of previous sessions
- Map description generator from uploaded map images
- Loot table generator tuned to party level and campaign theme


## Common Tasks & How To

<!-- Quick recipes for things you'll ask Claude to help with often.
     This saves time on repeated explanations. -->

### "Add a new page to the site"
1. Create `newpage.html` following the nav + CSS variable pattern
2. Add the nav link to all existing pages' `<nav>` sections
3. If it needs data, add a key to `$allowed` in `api.php`
4. Use the standard load/save/autosave pattern
5. **Update this claude.md** (file layout, API keys, features)

### "Add a new player"
1. Add their sheet HTML block in `players/players.html`
2. Add their thumb in the selector div
3. Add their ID to the `PLAYERS` array in the script
4. Add portrait images to `players/images/`
5. Update the "Current Players" table in this file

### "Style something new"
Use the existing CSS custom properties. Don't introduce new colors
without updating the palette section above. Stick to Georgia serif.


## Notes for Claude

<!-- These are direct instructions to the AI. Think of them as
     "rules of engagement" for how Claude should behave when
     working on this project. -->

- **Keep it vanilla.** Don't suggest React, Vue, or other frameworks
  unless I specifically ask. The simplicity is intentional.
- **Follow existing patterns.** Match the autosave pattern, the CSS
  variable usage, and the api.php key approach on every new page.
- **Preserve the aesthetic.** This is a dark-themed, fantasy-styled
  DM tool. Keep the mood consistent — parchment tones, gold accents,
  serif fonts.
- **Two data layers.** Session/player/NPC/marketplace data uses flat
  JSON via `api.php`. Card reference data (spells, items, weapons,
  potions) uses PostgreSQL via `cards-api.php`. Keep them separate.
- **Comments welcome.** I'm learning as we build. Add helpful
  comments in code when doing anything non-obvious.
- **AI features are the north star.** When in doubt about what to
  build next, lean toward features that set up the AI integration
  (e.g., structured session data that's easy for a model to process).
