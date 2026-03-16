---
name: update-docs
description: >
  Automatically updates the project's claude.md file after any work session
  where files, features, API keys, or players changed. Use this skill whenever
  Claude has just finished adding a page, creating a feature, adding a player,
  modifying the API, or making any structural change to the project. Also
  trigger when the user says things like "update the docs", "update claude.md",
  "sync the project file", or "make sure the docs reflect what we did."
---

# Update Docs

<!-- ================================================================
     WHAT THIS SKILL DOES

     After you finish building something on the project, this skill
     walks you through updating claude.md so it stays accurate.
     Think of it as a checklist — you scan each section of claude.md
     and patch anything that's now out of date.

     WHY IT MATTERS

     The claude.md file is how Claude understands the project at the
     start of every conversation. If it's stale (lists files that
     don't exist, misses new API keys, etc.), Claude gives worse
     help. Keeping it current takes 30 seconds and pays off every
     time you open a new chat.
     ================================================================ -->

## When to Run This Skill

Run this after any work session where you:

- Added, renamed, or deleted a file or folder
- Added a new API key to `api.php`
- Built a new feature or completed one from the roadmap
- Added or removed a player/character
- Changed the nav bar links
- Added a new CSS custom property or changed the color palette
- Made progress on an AI roadmap item

## Steps

### 1. Read the current claude.md

Read `claude.md` from the project root to get the current state.

### 2. Scan the actual project

Run `ls -R` or use glob patterns to get the real file tree. Compare
it against the "File Layout" section in claude.md.

### 3. Check api.php for allowed keys

Read `api.php` and look at the `$allowed` array. Compare it against
the "API Keys Currently in Use" table in claude.md.

### 4. Check the nav bar

Read any HTML file (e.g., `index.html`) and look at the `<nav>`
links. Make sure the "Navigation" line in UI conventions matches.

### 5. Update each section as needed

Work through these sections in order. Only touch what's changed:

| Section              | What to check                                      |
|----------------------|----------------------------------------------------|
| **File Layout**      | New/renamed/deleted files or folders                |
| **API Keys**         | New keys in `$allowed`, removed keys                |
| **Special Actions**  | New `action=` handlers in api.php                   |
| **UI Conventions**   | New CSS variables, changed nav links                |
| **Current Players**  | Added/removed players, changed characters or classes|
| **Current Features** | Move `[ ]` to `[x]` for completed features, add new ones |
| **AI Roadmap**       | Note progress, add new ideas discussed              |
| **Common Tasks**     | Add new "how to" recipes if a pattern emerged       |

### 6. Preserve the comments

The HTML comments in claude.md are there to help the project owner
learn. Don't remove them. If you add a new section, add a comment
explaining what it's for and when to update it, matching the style
of the existing comments.

### 7. Confirm the changes

After editing, briefly summarize what you updated so the user knows
what changed. Something like:

> "Updated claude.md: added `quests.html` to file layout, added
> `quests` API key, marked Quest Tracker as complete in features."

## Things to Avoid

- Don't rewrite sections that haven't changed
- Don't remove the HTML comments (they're educational)
- Don't change the overall structure/ordering of the file
- Don't add speculative features — only document what actually exists
