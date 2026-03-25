---
title: "feat: Image drop to post with thumbnail preview"
type: feat
status: completed
date: 2026-03-24
---

# feat: Image drop to post with thumbnail preview

## Overview

Allow the user to drop an image file onto the blog pane's "+" area to trigger a new post with the image pre-loaded. The blog form shows an image preview; the user edits the title/note and submits. Entry cards in the FeedOverlay grow to show a small thumbnail when a post has an image.

## Problem Frame

The blog pane is already a drag-and-drop zone for URLs. Images have no equivalent path. The user wants a first-class "drop image → blog post" workflow from the homepage, mirroring how link drops work today. A previous implementation was attempted and reverted ("to be revisited") — the sticking point was passing a `File` object across navigation. This plan resolves that by uploading the image immediately on drop and passing a plain string URL through Router state.

## Requirements Trace

- R1. Dropping an image file onto the "+" area in the FeedOverlay uploads it and navigates to /blog with the image pre-loaded in the form.
- R2. The Blog form shows the image as a preview with a remove button; the user can edit title/note before posting.
- R3. When the user posts, the `image_url` is included in the entry.
- R4. FeedOverlay entry cards display a compact thumbnail when `entry.image_url` is present, resizing the card naturally.
- R5. The BlogEntry detail page shows the full image when present.

## Scope Boundaries

- No changes to the backend's image storage mechanism (CDN/filesystem choice is a backend concern).
- No multi-image support in this iteration.
- Image editing/cropping is out of scope.
- The existing URL drop behavior is unchanged.

## Context & Research

### Relevant Code and Patterns

- `src/components/FeedOverlay.tsx` — drop handler at the overlay level; + button at the bottom. The current file-drop branch is a no-op stub (`// file drops and unrecognized content: do nothing`).
- `src/pages/Blog.tsx` — reads `location.state as { title?: string; link?: string }` from Router state. Pre-fills uncontrolled refs in a `useEffect` on mount.
- `src/hooks/useFeed.ts` — `Entry` interface, `postEntry(title, link?, note?)`, `API_URL` export. All API calls use native `fetch`.
- URL drop pattern (existing): `navigate('/blog', { state: { title: hostname(url), link: url } })` — same pattern applies for image.
- `src/utils/format.ts` — utility module pattern to follow.

### Prior Art

Commits `0804da4` through `1956b66` (before revert `c3c64e3`) attempted this feature using:
- Module-level `pendingDrop` store to pass `File` across navigation
- `FileReader` to convert to data URL for preview
- Drop zone on the Blog form itself
- A "+ add image" file picker button as fallback

This plan supersedes that approach: upload the image on drop, pass the resulting permanent URL through Router state. No module-level mutable state required.

### Institutional Learnings

None — `docs/solutions/` not yet set up on this project.

## Key Technical Decisions

- **Upload on drop, not on submit**: Uploading when the file is dropped (before navigating to the form) means Blog.tsx only ever sees a plain URL string in Router state. This avoids all `File`/`Blob` serialization problems and keeps the Blog form stateless regarding upload mechanics.
- **Upload endpoint is a backend concern**: The frontend sends `multipart/form-data` to `POST /uploads` and expects `{ url: string }` back. How the backend stores the image (Railway volume, R2, Cloudinary server-side, etc.) is deliberately left to the backend implementation.
- **Whole overlay is the drop target; + button provides visual affordance**: Requiring the user to hit a 24×24px button precisely is poor UX. Drops anywhere on the overlay are caught at the existing overlay handler. The + button visually signals it accepts images (distinct pulse/highlight when dragging a file, separate from the URL drag state).
- **`image_url` is a new field, not repurposing `link`**: `link` is an external URL displayed as a hostname link. `image_url` is a hosted image. They are independent optional fields.
- **Loading state blocks navigation**: While the upload is in progress the + button shows a spinner; navigation happens only on success or on explicit error dismiss.

## Open Questions

### Resolved During Planning

- *Should drops go on the + button or the whole overlay?* → Whole overlay, + button provides visual cue. Resolved above.
- *Should upload happen on drop or on submit?* → On drop. Resolved above.
- *Can we use Router state to pass a File object?* → No — File is not serializable. Passing a string URL (after upload) is the solution.

### Deferred to Implementation

- *Exact backend endpoint path (`/uploads` vs `/images` vs `/entries/upload`)* — Confirmed at backend integration time.
- *Max image size validation* — Decide during implementation; add a client-side guard matching whatever the backend enforces.
- *Accepted MIME types* — Start with `image/*`; tighten if the backend rejects specific types.
- *Whether `EntryDetail` (used by BlogEntry) also needs `image_url`* — Likely yes; confirm by checking backend response shape when the field is added.

## High-Level Technical Design

> *This illustrates the intended approach and is directional guidance for review, not implementation specification.*

```
User drags image file over FeedOverlay
  → overlay dragover: distinguish file vs URL (check dataTransfer.types for "Files")
  → overlay shows "image drop" state (+ button highlights distinctly from URL drag state)

User drops image
  → handleDrop detects files[0] is an image (type.startsWith('image/'))
  → setUploadState('loading')
  → fetch POST /uploads (multipart, authenticated)
      success: { url: string }
        → navigate('/blog', { state: { imageUrl: url, title: file.name } })
      failure:
        → setUploadState('error')
        → brief error indicator on + button, then reset

Blog mounts with location.state.imageUrl
  → useEffect on mount: if imageUrl, setPreviewUrl(imageUrl); if title, fill titleRef
  → form renders image preview with ✕ remove button
  → on remove: setPreviewUrl(undefined) only (URL is already uploaded; not revoked)

User clicks Post
  → postEntry(title, link?, note?, imageUrl?)
  → POST /entries JSON { title, link?, note?, image_url? }
  → on success: navigate('/blog'), entry appears in list

FeedOverlay entry card (when entry.image_url present)
  → small thumbnail above title row (max-h ~60px, object-cover, rounded)
  → card height grows naturally; no fixed-height constraint
```

## Implementation Units

> **Backend prerequisite (not a frontend unit):** Before any frontend unit can be tested end-to-end, the backend must:
> 1. Accept `image_url?: string` in `POST /entries` JSON body and persist it.
> 2. Return `image_url` in `GET /entries` and `GET /entries/:id` responses.
> 3. Expose `POST /uploads` (multipart/form-data, authenticated with Bearer token) returning `{ url: string }`.
>
> Frontend units 1–3 can be built and tested with mocks before the backend is ready. Unit 4 (end-to-end) requires the live endpoint.

---

- [ ] **Unit 1: Extend Entry model and useFeed API**

**Goal:** Add `image_url` to the frontend data model and provide an `uploadImage` helper function alongside the updated `postEntry` signature.

**Requirements:** R3 (data model must support image_url through the post flow)

**Dependencies:** None (backend can be mocked in unit tests)

**Files:**
- Modify: `src/hooks/useFeed.ts`
- Test: `src/hooks/useFeed.test.ts`

**Approach:**
- Add `image_url?: string` to the `Entry` and `EntryDetail` interfaces.
- Add `image_url?` parameter to `postEntry`; include it in the JSON body when present.
- Add an `uploadImage(file: File): Promise<string>` function that POSTs multipart FormData to `${API_URL}/uploads` with the Bearer token and returns the URL string from the response.
- Export `uploadImage` from the module so FeedOverlay can call it directly.

**Patterns to follow:**
- `postEntry` in `src/hooks/useFeed.ts` — same auth header pattern.
- `API_URL` constant from the same file.

**Test scenarios:**
- `uploadImage` sends a `POST` to `${API_URL}/uploads` with `Authorization: Bearer` header and FormData body; resolves with the URL string from `{ url }`.
- `uploadImage` rejects when the response is not ok.
- `postEntry` with `image_url` includes it in the JSON body; without it, the key is absent (not `null`).
- `Entry` interface allows `image_url` to be absent — existing entries without images are unaffected.

**Verification:**
- TypeScript compilation passes with no new errors.
- All existing `useFeed` tests still pass.
- New `uploadImage` tests pass with a stubbed `fetch`.

---

- [ ] **Unit 2: FeedOverlay — image drop on + area**

**Goal:** When the user drops an image file over the FeedOverlay, upload it and navigate to /blog with the image URL and filename in Router state. Provide distinct visual feedback for image-file drags vs. URL drags.

**Requirements:** R1

**Dependencies:** Unit 1 (`uploadImage`)

**Files:**
- Modify: `src/components/FeedOverlay.tsx`
- Test: `src/components/FeedOverlay.test.tsx`

**Approach:**
- Add a second drag state: `isFileDragOver` (separate from the existing `isDragOver` which tracks URL drags). Detect whether a drag event carries files using `e.dataTransfer.types.includes('Files')`.
- In `handleDragOver`, set `isFileDragOver` when the payload is a file, `isDragOver` when it is a URL.
- Add an `uploadState: 'idle' | 'loading' | 'error'` state to FeedOverlay.
- In `handleDrop`, detect `e.dataTransfer.files[0]` with an `image/*` MIME type:
  - Set `uploadState('loading')`.
  - Call `uploadImage(file)`.
  - On success: `navigate('/blog', { state: { imageUrl, title: file.name } })`.
  - On failure: set `uploadState('error')`, reset to `'idle'` after ~1.5s.
- The + button renders differently per state: normal (idle), spinner (loading), subtle red flash (error).
- Image file drops do not fall through to the existing URL handler.

**Patterns to follow:**
- Existing `handleDragOver` / `handleDragLeave` / `handleDrop` structure in `FeedOverlay.tsx`.
- Router state navigation pattern: `navigate('/blog', { state: { ... } })`.

**Test scenarios:**
- Dropping an `image/jpeg` file calls `uploadImage` and navigates to `/blog` with `{ imageUrl, title }` in state.
- Dropping a non-image file (`application/pdf`) does nothing (no navigate, no upload).
- When `uploadImage` rejects, `navigate` is not called and the error state resolves after timeout.
- Dropping a URL still navigates with `{ link, title }` as before.
- `isFileDragOver` is true during a file drag, `isDragOver` is true during a URL drag; they are independent.

**Verification:**
- All existing FeedOverlay tests still pass.
- New drop tests pass with mocked `uploadImage`.
- TypeScript passes.

---

- [ ] **Unit 3: Blog form — image preview and post with image_url**

**Goal:** The Blog form reads `imageUrl` from Router state on mount, shows a preview with a remove button, and includes `image_url` in the entry when posting.

**Requirements:** R2, R3

**Dependencies:** Unit 1 (updated `postEntry` signature)

**Files:**
- Modify: `src/pages/Blog.tsx`
- Test: `src/pages/Blog.test.tsx`

**Approach:**
- Extend the Router state type to include `imageUrl?: string`.
- In the mount `useEffect`, if `pending.imageUrl` is present, set a `previewUrl` state (not a ref — it drives conditional rendering).
- Render the image preview above the title input when `previewUrl` is set: a fixed-max-height image (`max-h-48`, `object-contain`, `rounded`, `bg-gray-50`) with an `✕` button that clears `previewUrl`.
- On `handlePost`, pass `previewUrl` as the `imageUrl` argument to `postEntry`.
- Clearing the preview (remove button) sets `previewUrl` to `undefined`; post proceeds without image_url.

**Patterns to follow:**
- Existing `useEffect` for pre-filling title/link refs from Router state.
- `previewUrl` controlled state pattern (was used in the pre-revert implementation at commit `1956b66`).

**Test scenarios:**
- When rendered with `initialEntries={[{ pathname: '/blog', state: { imageUrl: 'https://cdn.example.com/img.jpg', title: 'photo.jpg' } }]}`, an `<img>` is visible and the title input is pre-filled.
- Clicking the ✕ button removes the image preview.
- When no imageUrl in state, no `<img>` is rendered and no ✕ button is shown.
- Submitting with an active preview calls `postEntry` with the imageUrl argument.
- Submitting after removing the preview calls `postEntry` without imageUrl.

**Verification:**
- All existing Blog tests pass.
- New preview tests pass.
- TypeScript passes.

---

- [ ] **Unit 4: FeedOverlay entry cards — image thumbnail**

**Goal:** Entry cards in the FeedOverlay show a small thumbnail when `entry.image_url` is set. Cards grow naturally; no fixed-height container is imposed on the list.

**Requirements:** R4

**Dependencies:** Unit 1 (Entry model has `image_url`), Backend (returns `image_url` in list responses)

**Files:**
- Modify: `src/components/FeedOverlay.tsx`
- Test: `src/components/FeedOverlay.test.tsx`

**Approach:**
- Inside each entry card `<div>`, add a thumbnail above the date/title row when `entry.image_url` is present.
- Use `object-cover`, `w-full`, constrained height (e.g., `max-h-16` or `max-h-20`), `rounded`, no explicit `overflow-hidden` needed since the outer card is `rounded`.
- The note paragraph can stay `line-clamp-3`; the card's natural height accommodates both thumbnail and text.
- Use `loading="lazy"` on the `<img>` to avoid blocking the feed paint.

**Patterns to follow:**
- Existing entry card structure in `FeedOverlay.tsx`.

**Test scenarios:**
- Entry with `image_url` renders an `<img>` element with the correct `src`.
- Entry without `image_url` renders no `<img>` element.
- Entries with and without images can coexist in the same list.

**Verification:**
- New thumbnail tests pass.
- TypeScript passes.

---

- [ ] **Unit 5: BlogEntry detail page — full image display**

**Goal:** The BlogEntry detail page shows the full-width image when `entry.image_url` is present, positioned naturally above the note.

**Requirements:** R5

**Dependencies:** Unit 1 (EntryDetail model), Backend (`GET /entries/:id` returns `image_url`)

**Files:**
- Modify: `src/pages/BlogEntry.tsx`
- Test: `src/pages/BlogEntry.test.tsx`

**Approach:**
- Add `{entry.image_url && <img ... />}` between the link and the note, mirroring how `entry.link` and `entry.note` are conditionally rendered today.
- Style: `w-full`, `rounded`, `max-h-96`, `object-contain`, `bg-gray-50`, `mb-4`.

**Patterns to follow:**
- Existing conditional rendering of `entry.link` and `entry.note` in `BlogEntry.tsx`.

**Test scenarios:**
- With a mocked entry that includes `image_url`, the rendered output contains an `<img>` with the correct `src`.
- Without `image_url`, no `<img>` is rendered.

**Verification:**
- All existing BlogEntry tests pass.
- New image test passes.
- TypeScript passes.

## System-Wide Impact

- **Entry interface**: Adding `image_url?: string` is backward-compatible — existing entries without it are unaffected.
- **Error propagation**: `uploadImage` rejects on non-ok response; FeedOverlay catches this and shows an error state on the + button without crashing.
- **State lifecycle**: The image URL stored in Router state is a permanent backend URL (not a blob URL), so it remains valid regardless of component lifecycle.
- **API surface parity**: `postEntry` gains an optional parameter; existing callers that omit it are unaffected.
- **Upload abandonment**: If the user navigates away from /blog after the image was uploaded but before posting, the uploaded image on the backend is orphaned. Acceptable for a personal site; note as a known limitation.

## Risks & Dependencies

- **Backend prerequisite is the critical path**: Units 1–3 can be built and tested with mocks, but the feature is not shippable until the backend exposes `POST /uploads` and includes `image_url` in entry responses.
- **Previous revert**: The feature was reverted once. This plan directly addresses the root cause (File serialization across navigation) by uploading eagerly and passing a URL string.
- **Upload latency**: On slow connections, the user sees a loading spinner on the + button before navigation. This is an acceptable trade-off vs. the complexity of deferred upload.
- **Image size**: No client-side size limit is enforced in this plan; add a guard (e.g., 10MB) matching whatever the backend enforces.

## Sources & References

- Reverted prior implementation: commits `0804da4`, `482df2a`, `1956b66`, reverted at `c3c64e3`
- Relevant code: `src/components/FeedOverlay.tsx`, `src/pages/Blog.tsx`, `src/hooks/useFeed.ts`
- HTML Drag and Drop API: `dataTransfer.files`, `dataTransfer.types`
- React Router `useLocation().state` pattern: already in use for URL drops
