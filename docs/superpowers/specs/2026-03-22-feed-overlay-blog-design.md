# Feed Overlay + Blog — Design Spec
**Date:** 2026-03-22
**Status:** Approved

---

## Overview

A personal feed system for kevintraywick.com. Entries (title, optional link, optional note) are created by Kevin and displayed in two places:

1. **Type box overlay** — overlaid on the `type.png` grid cell on the homepage, showing the 7–8 most recent entries
2. **Blog page** — full listing at `kevintraywick.com/blog`, Hacker News-style

Visitors can leave anonymous comments on any entry. Kevin creates new entries via a hidden quick-post form at the bottom of the type box.

---

## Data Model

### Entry
| Field | Type | Notes |
|-------|------|-------|
| `id` | integer (autoincrement) | primary key |
| `title` | string | required |
| `link` | string | optional URL |
| `note` | string | optional — Kevin's commentary |
| `created_at` | datetime | auto-set on creation |

### Comment
| Field | Type | Notes |
|-------|------|-------|
| `id` | integer (autoincrement) | primary key |
| `entry_id` | integer | foreign key → Entry |
| `body` | string | required |
| `created_at` | datetime | auto-set on creation |

---

## Backend (Railway)

**Stack:** Node.js + Express + SQLite (better-sqlite3)
**Repo:** separate repo, deployed to Railway
**Env vars:** `POST_SECRET` (used to authenticate Kevin's posts)

### Endpoints

| Method | Path | Auth | Description |
|--------|------|------|-------------|
| `GET` | `/entries` | none | All entries, newest first, with comment counts |
| `GET` | `/entries/:id` | none | Single entry with full note + all comments |
| `POST` | `/entries` | Bearer token | Create entry |
| `POST` | `/entries/:id/comments` | none | Add anonymous comment |

**POST /entries** body:
```json
{ "title": "...", "link": "...", "note": "..." }
```

**POST /entries/:id/comments** body:
```json
{ "body": "..." }
```

CORS configured to allow requests from `kevintraywick.com`.

---

## Auth Flow

Kevin's `[[` trigger:

1. Kevin types `[[` at the start of the title field in the quick-post form
2. Client JS detects the `[[` prefix, strips it from the title before submission, and adds `Authorization: Bearer <VITE_POST_SECRET>` to the POST request
3. Server validates the token; rejects without a 401 if missing or wrong
4. `VITE_POST_SECRET` is set as an environment variable in the GitHub Pages build; it matches `POST_SECRET` on Railway

The `[[` trigger is never displayed, hinted at, or documented anywhere visible to visitors.

---

## Frontend

**Stack:** React + TypeScript + Tailwind (existing repo)
**Routing:** React Router DOM added; GitHub Pages 404.html SPA trick for deep links

### New files

```
src/
  components/
    FeedOverlay.tsx     — type box overlay (feed + post form)
  pages/
    Blog.tsx            — full blog listing page
    BlogEntry.tsx       — single entry page (expanded view)
  hooks/
    useFeed.ts          — fetch + post logic, shared between overlay and blog
```

### FeedOverlay.tsx

Renders inside the type box grid cell, absolutely positioned over the `type.png` image. Layout:

- **Feed area** (scrollable, flex-grow): shows 7–8 most recent entries
  - Each entry: `[date] [title] · [link in italics]` on one line
  - Kevin's note: first 3 lines, truncated (`line-clamp-3`)
  - Visitor comment input: `placeholder="Add a comment…"`
  - Clicking the title navigates to `/blog/:id`
- **Post form** (bottom, always visible): three plain inputs — Title, Link, Comment — no labels, no button visible. When `[[` is detected in the title field, a Post button appears and the auth header is prepared.

### Blog.tsx

Full listing at `/blog`:

- Header: `Kevin Traywick · thoughts & links`
- Entries listed newest first
- Collapsed: title line + note preview (full text, no clamp) + comment count
- Clicking a title expands inline to show full note + comment thread + comment input
- Or navigates to `/blog/:id` for permalink

### BlogEntry.tsx

Single entry at `/blog/:id`:

- Full note text
- Comment thread (all comments, chronological)
- Comment input at bottom

---

## Routing

| Path | Component |
|------|-----------|
| `/` | App (homepage grid) |
| `/blog` | Blog |
| `/blog/:id` | BlogEntry |

**GitHub Pages SPA fix:** `public/404.html` redirects to `index.html` with the path encoded as a query param; `index.html` decodes it on load.

---

## Error Handling

- API unreachable: feed shows empty state silently (no error thrown to user)
- Comment submit fails: input shakes briefly, stays populated
- Post submit without auth: server returns 401; client shows no feedback (wrong secret = no post, no hint)

---

## Out of Scope

- Comment moderation or deletion
- Entry editing or deletion from the UI
- User identity / login for commenters
- Pagination (load more can be added later)
