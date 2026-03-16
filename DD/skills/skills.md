# Skills

<!-- ================================================================
     WHAT ARE SKILLS?

     Skills are instruction files that teach Claude how to do specific
     tasks on your project. Each skill lives in its own folder inside
     skills/ and contains a SKILL.md file with step-by-step guidance.

     Think of them like recipes: instead of explaining your project's
     conventions every time you ask Claude to do something, the skill
     has the recipe ready to go.

     HOW THEY WORK

     When you ask Claude to do something that matches a skill's
     description, it reads the SKILL.md and follows those instructions.
     This means Claude will automatically use the right patterns,
     file locations, and naming conventions — even in a brand new
     conversation where it hasn't seen your code yet.

     ADDING A NEW SKILL

     1. Create a new folder: skills/<skill-name>/
     2. Add a SKILL.md file inside it (see existing skills for format)
     3. Add a row to the table below
     4. That's it — Claude will pick it up automatically

     The SKILL.md file needs two things at the top:
       - name: a short identifier (same as the folder name)
       - description: when Claude should use this skill (be specific!)

     WHEN TO CREATE A SKILL

     If you find yourself explaining the same process to Claude more
     than twice, it's a good candidate for a skill. Common examples:
       - Repetitive setup tasks (adding pages, players, etc.)
       - Tasks with specific conventions to follow
       - Workflows that touch multiple files in a specific order
     ================================================================ -->


## Available Skills

| Skill        | Folder               | What It Does                                         |
|--------------|----------------------|------------------------------------------------------|
| update-docs  | skills/update-docs/  | Updates claude.md after changes to the project       |
| add-npc      | skills/add-npc/      | Adds a new NPC to the campaign's NPC manager         |


## Skill Ideas for Later

<!-- Jot down ideas here so you remember them. When you're ready
     to build one, just ask Claude to create it. -->

- **add-page** — Walk through creating a new page with all the
  project conventions (nav, CSS vars, autosave, API key)
- **session-prep** — Help draft session prep content using data
  from previous sessions
- **add-player** — Add a new player/character to the system
