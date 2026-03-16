---
name: add-npc
description: >
  Helps create a new NPC for the campaign by adding it to the npc_cards
  data and optionally filling in abilities, weaknesses, and notes. Use
  this skill when the user says things like "add an NPC", "create a new
  NPC", "I need a shopkeeper", "make a villain", "new character for the
  campaign", or describes any non-player character they want to add to
  the site. Also trigger when the user provides an NPC concept or asks
  for help fleshing out an NPC's details.
---

# Add NPC

<!-- ================================================================
     WHAT THIS SKILL DOES

     This skill walks Claude through adding a new NPC to the campaign's
     NPC manager. It handles both the data side (writing to the JSON
     via the API) and the creative side (helping flesh out abilities,
     weaknesses, and notes if the user wants help).

     The NPC manager lives at npcs/index.html and stores data via
     the `npc_cards` API key.
     ================================================================ -->

## NPC Data Structure

Each NPC is stored as an object in the `npc_cards` array:

```json
{
  "id": "m1abc2d",
  "name": "Thornwick",
  "abilities": "Spellcasting (3rd-level wizard). Favors Sleep and Charm Person...",
  "weaknesses": "Low HP (18). Cowardly — flees below half health...",
  "notes": "Runs the Dusty Tome bookshop in Millhaven. Secretly a member of..."
}
```

<!-- The id is generated with Date.now().toString(36), which gives a
     short unique string like "m1abc2d". This is the same pattern
     used across the whole site for IDs. -->

### Field Guide

| Field        | What goes here                                        |
|--------------|-------------------------------------------------------|
| `id`         | Auto-generated. Use `Date.now().toString(36)`         |
| `name`       | The NPC's display name. Also used to find their image |
| `abilities`  | Powers, attacks, spells, special actions               |
| `weaknesses` | Vulnerabilities, low stats, behavioral flaws           |
| `notes`      | Lore, personality, location, plot hooks, tactics       |

### Image Convention

NPC portraits live in `npcs/images/`. The filename is derived from
the NPC name: lowercased, spaces become hyphens, non-alphanumeric
characters removed, with `.png` extension.

Example: "Thornwick the Grey" → `npcs/images/thornwick-the-grey.png`

The image is optional — the UI shows a placeholder if none exists.

## Steps to Add an NPC

### 1. Get the NPC concept from the user

At minimum you need a name. But ideally ask about:
- **Role**: What is this NPC? (merchant, villain, quest-giver, etc.)
- **Context**: Where do they show up? Which session or location?
- **Tone**: Serious threat? Comic relief? Mysterious ally?

If the user already described the NPC in detail, skip the questions
and work with what they gave you.

### 2. Load the existing NPC list

```js
// Fetch current NPCs from the API
const response = await fetch('/DD/api.php?key=npc_cards');
const npcs = await response.json();
```

Read the current data so you can append to it rather than overwrite.

### 3. Create the NPC object

Build the new NPC with a generated ID and the user's info:

```js
const newNPC = {
  id: Date.now().toString(36),
  name: "NPC Name",
  abilities: "",
  weaknesses: "",
  notes: ""
};
```

### 4. Offer to flesh out the details

If the user only gave a name or brief concept, offer to help fill
in abilities, weaknesses, and notes. When writing these:

- **Abilities**: Be specific and game-useful. Include spell levels,
  damage dice, or action economy where relevant. DMs need to run
  this NPC at the table, not just read about them.
- **Weaknesses**: Include both mechanical weaknesses (low AC, fire
  vulnerability) and behavioral ones (greedy, overconfident). These
  give the players ways to interact beyond combat.
- **Notes**: This is the richest field. Include personality traits,
  speech patterns, motivations, where they're found, and any plot
  hooks they connect to. Write it so a DM can roleplay this NPC
  from the notes alone.

Keep the tone consistent with the campaign — dark fantasy, not
cartoonish, but allow for lighter NPCs when appropriate.

### 5. Save to the API

Append the new NPC to the array and save the whole thing:

```js
npcs.push(newNPC);
await fetch('/DD/api.php?key=npc_cards', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(npcs)
});
```

### 6. Remind about the portrait

Let the user know they can add a portrait image at:
`npcs/images/<name-slug>.png`

The NPC will show up on the site immediately (just refresh the
NPCs page), and the portrait will appear once the image file exists.

### 7. Run the update-docs skill

After adding the NPC, run the `update-docs` skill to keep
claude.md current — especially if this is a major recurring NPC
that should be noted somewhere.

## Tips for Good NPCs

<!-- These tips help Claude generate NPCs that are actually useful
     at the table, not just flavor text. -->

- Give every NPC at least one memorable trait the DM can latch onto
  when roleplaying (a verbal tic, a habit, an unusual appearance)
- Connect NPCs to the campaign's existing threads when possible —
  check the session data for loose ends or locations that need
  characters
- Include a "secret" or hidden motivation in the notes — it gives
  the DM something to reveal if the players dig deeper
- For combat NPCs, keep stat notes brief but actionable: AC, HP,
  main attack, and one signature move is usually enough
