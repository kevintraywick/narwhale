# Feed Frontend Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add the FeedOverlay component to the type box, a /blog listing page, and a /blog/:id permalink page to kevintraywick.com.

**Architecture:** React Router added for /blog routing. `useFeed` hook centralises all API calls. FeedOverlay is absolutely positioned inside the type box grid cell. GitHub Pages 404.html trick enables deep-link support for SPA routes.

**Tech Stack:** React, TypeScript, Tailwind, React Router DOM, Vitest, @testing-library/react

**Prerequisite:** kt-feed API deployed to Railway. Have `VITE_API_URL` (e.g. `https://your-app.up.railway.app`) and `VITE_POST_SECRET` ready.

> ⚠️ `VITE_POST_SECRET` is compiled into the JS bundle and visible to anyone who inspects it. This is intentional — the `[[` trigger is obscurity-based auth for a low-stakes personal site.

---

## File Structure

```
src/
  hooks/
    useFeed.ts            — fetch entries, post entry, post comment
    useFeed.test.ts       — hook tests (mocked fetch)
  components/
    FeedOverlay.tsx       — type box overlay (feed list + post form)
    FeedOverlay.test.tsx  — render + interaction tests
  pages/
    Blog.tsx              — full listing at /blog
    Blog.test.tsx
    BlogEntry.tsx         — single entry at /blog/:id
    BlogEntry.test.tsx
  test-setup.ts           — @testing-library/jest-dom setup
Modify:
  src/App.tsx             — add Router, wire FeedOverlay into type box cell
  src/main.tsx            — wrap app in BrowserRouter
  vite.config.ts          — add Vitest config
  public/404.html         — GitHub Pages SPA deep-link fix
  .env.example            — document new env vars
```

---

### Task 1: Install deps, configure Vitest, add 404.html

**Files:**
- Modify: `vite.config.ts`
- Create: `src/test-setup.ts`
- Create: `public/404.html`
- Create: `.env.example` (update)

- [ ] **Step 1: Install packages**

```bash
npm install react-router-dom
npm install -D vitest @testing-library/react @testing-library/user-event @testing-library/jest-dom jsdom
```

- [ ] **Step 2: Update vite.config.ts**

```ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [react(), tailwindcss()],
  base: '/',
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./src/test-setup.ts'],
  },
})
```

- [ ] **Step 3: Create src/test-setup.ts**

```ts
import '@testing-library/jest-dom'
```

- [ ] **Step 4: Add test script to package.json**

In `package.json`, add to `"scripts"`:
```json
"test": "vitest run",
"test:watch": "vitest"
```

- [ ] **Step 5: Create public/404.html** (GitHub Pages SPA routing fix)

```html
<!DOCTYPE html>
<html>
<head>
  <script>
    // Redirect paths to index.html, encoding the path as a query param
    const path = window.location.pathname;
    if (path !== '/') {
      window.location.replace('/?path=' + encodeURIComponent(path));
    }
  </script>
</head>
</html>
```

- [ ] **Step 6: Update index.html to decode the redirect**

In `index.html`, add inside `<head>` before other scripts:
```html
<script>
  // Restore path from GitHub Pages 404 redirect
  const params = new URLSearchParams(window.location.search);
  const redirectPath = params.get('path');
  if (redirectPath) {
    window.history.replaceState(null, '', redirectPath);
  }
</script>
```

- [ ] **Step 7: Create .env.example**

```
VITE_API_URL=https://your-app.up.railway.app
VITE_POST_SECRET=your-secret-here
```

- [ ] **Step 8: Create .env.local with your actual values** (do not commit this file)

```
VITE_API_URL=https://your-railway-url.up.railway.app
VITE_POST_SECRET=your-actual-secret
```

- [ ] **Step 9: Verify vitest works**

```bash
npm test
```
Expected: "No test files found" (no failures)

- [ ] **Step 10: Commit**

```bash
git add vite.config.ts src/test-setup.ts public/404.html index.html .env.example package.json package-lock.json
git commit -m "chore: add react-router-dom, vitest, github pages SPA fix"
```

---

### Task 2: useFeed hook

**Files:**
- Create: `src/hooks/useFeed.ts`
- Create: `src/hooks/useFeed.test.ts`

- [ ] **Step 1: Write failing tests**

Create `src/hooks/useFeed.test.ts`:

```ts
import { renderHook, waitFor } from '@testing-library/react'
import { useFeed } from './useFeed'

beforeEach(() => {
  vi.stubGlobal('fetch', vi.fn())
})

afterEach(() => {
  vi.unstubAllGlobals()
})

test('loads entries on mount', async () => {
  vi.mocked(fetch).mockResolvedValueOnce({
    ok: true,
    json: async () => [{ id: 1, title: 'Hello', comment_count: 0, created_at: '2026-03-20' }]
  } as Response)

  const { result } = renderHook(() => useFeed())
  await waitFor(() => expect(result.current.loading).toBe(false))
  expect(result.current.entries).toHaveLength(1)
  expect(result.current.entries[0].title).toBe('Hello')
})

test('handles fetch failure gracefully — returns empty entries', async () => {
  vi.mocked(fetch).mockRejectedValueOnce(new Error('Network error'))
  const { result } = renderHook(() => useFeed())
  await waitFor(() => expect(result.current.loading).toBe(false))
  expect(result.current.entries).toHaveLength(0)
})
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
npm test
```
Expected: FAIL — `Cannot find module './useFeed'`

- [ ] **Step 3: Create src/hooks/useFeed.ts**

```ts
import { useState, useEffect } from 'react'

const API_URL = import.meta.env.VITE_API_URL as string

export interface Entry {
  id: number
  title: string
  link?: string
  note?: string
  created_at: string
  comment_count: number
}

export interface Comment {
  id: number
  entry_id: number
  body: string
  created_at: string
}

export interface EntryDetail extends Omit<Entry, 'comment_count'> {
  comments: Comment[]
}

export function useFeed() {
  const [entries, setEntries] = useState<Entry[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetch(`${API_URL}/entries`)
      .then(r => r.json())
      .then(setEntries)
      .catch(() => {})
      .finally(() => setLoading(false))
  }, [])

  async function postEntry(title: string, link: string, note: string) {
    const secret = import.meta.env.VITE_POST_SECRET as string
    const res = await fetch(`${API_URL}/entries`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${secret}`,
      },
      body: JSON.stringify({
        title,
        link: link || undefined,
        note: note || undefined,
      }),
    })
    if (!res.ok) throw new Error('Post failed')
    const entry = await res.json()
    setEntries(prev => [{ ...entry, comment_count: 0 }, ...prev])
    return entry
  }

  async function postComment(entryId: number, body: string) {
    const res = await fetch(`${API_URL}/entries/${entryId}/comments`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ body }),
    })
    if (!res.ok) throw new Error('Comment failed')
    return res.json()
  }

  return { entries, loading, postEntry, postComment }
}

export async function fetchEntry(id: string): Promise<EntryDetail> {
  const res = await fetch(`${API_URL}/entries/${id}`)
  if (!res.ok) throw new Error('Not found')
  return res.json()
}
```

- [ ] **Step 4: Export API_URL from useFeed.ts**

Add this line near the top of `src/hooks/useFeed.ts`, after the `const API_URL` declaration:

```ts
export const API_URL = import.meta.env.VITE_API_URL as string
```

(Replace the existing `const API_URL` line — just add `export` to it.)

- [ ] **Step 5: Run tests to verify they pass**

```bash
npm test
```
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add src/hooks/
git commit -m "feat: useFeed hook with entries, postEntry, postComment"
```

---

### Task 3: FeedOverlay component

**Files:**
- Create: `src/components/FeedOverlay.tsx`
- Create: `src/components/FeedOverlay.test.tsx`

- [ ] **Step 1: Write failing test**

Create `src/components/FeedOverlay.test.tsx`:

```tsx
import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { FeedOverlay } from './FeedOverlay'

vi.mock('../hooks/useFeed', () => ({
  useFeed: () => ({
    entries: [
      { id: 1, title: 'Test entry', note: 'A note here', created_at: '2026-03-20T00:00:00', comment_count: 0 },
    ],
    loading: false,
    postEntry: vi.fn(),
    postComment: vi.fn(),
  }),
}))

test('renders entry title', () => {
  render(<MemoryRouter><FeedOverlay /></MemoryRouter>)
  expect(screen.getByText('Test entry')).toBeInTheDocument()
})

test('renders entry note preview', () => {
  render(<MemoryRouter><FeedOverlay /></MemoryRouter>)
  expect(screen.getByText('A note here')).toBeInTheDocument()
})

test('renders comment input for each entry', () => {
  render(<MemoryRouter><FeedOverlay /></MemoryRouter>)
  expect(screen.getByPlaceholderText('Add a comment…')).toBeInTheDocument()
})

test('renders post form inputs', () => {
  render(<MemoryRouter><FeedOverlay /></MemoryRouter>)
  expect(screen.getByPlaceholderText('Title…')).toBeInTheDocument()
  expect(screen.getByPlaceholderText('Link…')).toBeInTheDocument()
  expect(screen.getByPlaceholderText('Comment…')).toBeInTheDocument()
})
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
npm test
```
Expected: FAIL — `Cannot find module './FeedOverlay'`

- [ ] **Step 3: Create src/components/FeedOverlay.tsx**

```tsx
import { useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import { useFeed } from '../hooks/useFeed'

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
}

function hostname(url: string) {
  try { return new URL(url).hostname } catch { return url }
}

export function FeedOverlay() {
  const { entries, postEntry, postComment } = useFeed()
  const navigate = useNavigate()
  const titleRef = useRef<HTMLInputElement>(null)
  const linkRef = useRef<HTMLInputElement>(null)
  const noteRef = useRef<HTMLInputElement>(null)

  const recent = entries.slice(0, 8)

  async function handlePost() {
    const raw = titleRef.current!.value.trim()
    const isKevin = raw.startsWith('[[')
    const title = isKevin ? raw.slice(2).trim() : raw
    if (!title) return
    if (!isKevin) return // no auth header — server will reject; show nothing
    try {
      await postEntry(title, linkRef.current!.value.trim(), noteRef.current!.value.trim())
      titleRef.current!.value = ''
      linkRef.current!.value = ''
      noteRef.current!.value = ''
    } catch {}
  }

  async function handleComment(entryId: number, input: HTMLInputElement) {
    const body = input.value.trim()
    if (!body) return
    try {
      await postComment(entryId, body)
      input.value = ''
    } catch {
      input.style.borderColor = '#f87171'
      setTimeout(() => { input.style.borderColor = '' }, 600)
    }
  }

  return (
    <div className="absolute inset-0 flex flex-col font-sans text-xs overflow-hidden bg-white/60 backdrop-blur-sm">
      {/* Feed */}
      <div className="flex-1 overflow-y-auto p-2.5 space-y-2">
        {recent.map(entry => (
          <div key={entry.id} className="border-b border-black/8 pb-2">
            <div className="leading-snug">
              <span className="text-gray-400 text-[10px] mr-1.5">{formatDate(entry.created_at)}</span>
              <button
                className="font-semibold text-gray-900 hover:underline text-left text-[11px]"
                onClick={() => navigate(`/blog/${entry.id}`)}
              >
                {entry.title}
              </button>
              {entry.link && (
                <>
                  <span className="text-gray-300 mx-1">·</span>
                  <a
                    href={entry.link}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-gray-400 italic text-[10px]"
                    onClick={e => e.stopPropagation()}
                  >
                    {hostname(entry.link)}
                  </a>
                </>
              )}
            </div>
            {entry.note
              ? <p className="text-gray-500 text-[10px] leading-snug mt-0.5 line-clamp-3">{entry.note}</p>
              : <p className="text-gray-300 text-[10px] italic mt-0.5">no note yet</p>
            }
            <input
              className="mt-1 w-full text-[10px] border border-gray-200 rounded px-1.5 py-0.5 bg-white/80 placeholder-gray-300 focus:outline-none"
              placeholder="Add a comment…"
              onKeyDown={e => { if (e.key === 'Enter') handleComment(entry.id, e.currentTarget) }}
            />
          </div>
        ))}
      </div>

      {/* Post form — always visible, no labels */}
      <div className="border-t border-black/10 p-2 bg-white/70 flex flex-col gap-1">
        <input
          ref={titleRef}
          className="w-full text-[11px] border border-gray-200 rounded px-1.5 py-1 bg-white/90 focus:outline-none"
          placeholder="Title…"
          onKeyDown={e => { if (e.key === 'Enter') handlePost() }}
        />
        <input
          ref={linkRef}
          className="w-full text-[11px] border border-gray-200 rounded px-1.5 py-1 bg-white/90 focus:outline-none"
          placeholder="Link…"
        />
        <input
          ref={noteRef}
          className="w-full text-[11px] border border-gray-200 rounded px-1.5 py-1 bg-white/90 focus:outline-none"
          placeholder="Comment…"
          onKeyDown={e => { if (e.key === 'Enter') handlePost() }}
        />
      </div>
    </div>
  )
}
```

- [ ] **Step 4: Run tests**

```bash
npm test
```
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add src/components/
git commit -m "feat: FeedOverlay component"
```

---

### Task 4: Blog listing page

**Files:**
- Create: `src/pages/Blog.tsx`
- Create: `src/pages/Blog.test.tsx`

- [ ] **Step 1: Write failing test**

Create `src/pages/Blog.test.tsx`:

```tsx
import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import Blog from './Blog'

vi.mock('../hooks/useFeed', () => ({
  useFeed: () => ({
    entries: [
      { id: 1, title: 'First post', note: 'Full note text here', created_at: '2026-03-20T00:00:00', comment_count: 2 },
      { id: 2, title: 'Second post', note: null, created_at: '2026-03-18T00:00:00', comment_count: 0 },
    ],
    loading: false,
    postComment: vi.fn(),
  }),
}))

test('renders blog header', () => {
  render(<MemoryRouter><Blog /></MemoryRouter>)
  expect(screen.getByText(/Kevin Traywick/i)).toBeInTheDocument()
})

test('renders entry titles', () => {
  render(<MemoryRouter><Blog /></MemoryRouter>)
  expect(screen.getByText('First post')).toBeInTheDocument()
  expect(screen.getByText('Second post')).toBeInTheDocument()
})

test('renders comment count', () => {
  render(<MemoryRouter><Blog /></MemoryRouter>)
  expect(screen.getByText('2 comments')).toBeInTheDocument()
})
```

- [ ] **Step 2: Run to verify failure**

```bash
npm test
```
Expected: FAIL

- [ ] **Step 3: Create src/pages/Blog.tsx**

```tsx
import { useState } from 'react'
import { useFeed, Entry, Comment } from '../hooks/useFeed'

const API_URL = import.meta.env.VITE_API_URL as string

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
}

function hostname(url: string) {
  try { return new URL(url).hostname } catch { return url }
}

function EntryRow({ entry, postComment }: { entry: Entry, postComment: (id: number, body: string) => Promise<unknown> }) {
  const [expanded, setExpanded] = useState(false)
  const [comments, setComments] = useState<Comment[]>([])
  const [loadedComments, setLoadedComments] = useState(false)

  async function expand() {
    if (!expanded && !loadedComments) {
      const res = await fetch(`${API_URL}/entries/${entry.id}`)
      const data = await res.json()
      setComments(data.comments || [])
      setLoadedComments(true)
    }
    setExpanded(e => !e)
  }

  async function handleComment(input: HTMLInputElement) {
    const body = input.value.trim()
    if (!body) return
    try {
      const comment = await postComment(entry.id, body) as Comment
      setComments(prev => [...prev, comment])
      input.value = ''
    } catch {
      input.style.borderColor = '#f87171'
      setTimeout(() => { input.style.borderColor = '' }, 600)
    }
  }

  return (
    <div className="border-b border-gray-100 py-4">
      <div>
        <span className="text-gray-400 text-xs mr-2">{formatDate(entry.created_at)}</span>
        <button
          className="font-semibold text-gray-900 hover:underline text-sm text-left"
          onClick={expand}
        >
          {entry.title}
        </button>
        {entry.link && (
          <>
            <span className="text-gray-300 mx-1.5 text-xs">·</span>
            <a href={entry.link} target="_blank" rel="noopener noreferrer"
              className="text-gray-400 italic text-xs">
              {hostname(entry.link)}
            </a>
          </>
        )}
      </div>

      {!expanded && (
        <div className="mt-1">
          {entry.note && <p className="text-gray-500 text-xs leading-relaxed">{entry.note}</p>}
          <p className="text-gray-400 text-xs mt-1">
            {entry.comment_count > 0 ? `${entry.comment_count} comment${entry.comment_count === 1 ? '' : 's'}` : 'no comments yet'}
          </p>
        </div>
      )}

      {expanded && (
        <div className="mt-3">
          {entry.note && <p className="text-gray-600 text-sm leading-relaxed mb-4">{entry.note}</p>}
          <div className="pl-3 border-l-2 border-gray-100">
            <p className="text-xs text-gray-400 font-semibold uppercase tracking-wide mb-2">Comments</p>
            {comments.map(c => (
              <div key={c.id} className="mb-2">
                <span className="text-gray-400 text-xs mr-2">visitor</span>
                <span className="text-gray-700 text-sm">{c.body}</span>
              </div>
            ))}
            {comments.length === 0 && (
              <p className="text-gray-300 text-xs italic mb-2">no comments yet</p>
            )}
            <input
              className="w-full max-w-sm text-xs border border-gray-200 rounded px-2 py-1 mt-1 focus:outline-none"
              placeholder="Add a comment…"
              onKeyDown={e => { if (e.key === 'Enter') handleComment(e.currentTarget) }}
            />
          </div>
        </div>
      )}
    </div>
  )
}

export default function Blog() {
  const { entries, loading, postComment } = useFeed()

  return (
    <div className="min-h-screen bg-white font-sans">
      <div className="max-w-2xl mx-auto px-6 py-12">
        <h1 className="text-sm font-semibold text-gray-400 uppercase tracking-widest mb-8">
          Kevin Traywick · thoughts &amp; links
        </h1>
        {loading && <p className="text-gray-300 text-sm">Loading…</p>}
        {entries.map(entry => (
          <EntryRow key={entry.id} entry={entry} postComment={postComment} />
        ))}
      </div>
    </div>
  )
}
```

- [ ] **Step 4: Run tests**

```bash
npm test
```
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add src/pages/Blog.tsx src/pages/Blog.test.tsx
git commit -m "feat: Blog listing page"
```

---

### Task 5: BlogEntry permalink page

**Files:**
- Create: `src/pages/BlogEntry.tsx`
- Create: `src/pages/BlogEntry.test.tsx`

- [ ] **Step 1: Write failing test**

Create `src/pages/BlogEntry.test.tsx`:

```tsx
import { render, screen, waitFor } from '@testing-library/react'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import BlogEntry from './BlogEntry'

beforeEach(() => {
  vi.stubGlobal('fetch', vi.fn().mockResolvedValue({
    ok: true,
    json: async () => ({
      id: 1,
      title: 'Hello world',
      note: 'Full note text.',
      link: null,
      created_at: '2026-03-20T00:00:00',
      comments: [{ id: 1, entry_id: 1, body: 'Nice!', created_at: '2026-03-21T00:00:00' }]
    })
  }))
})

afterEach(() => vi.unstubAllGlobals())

test('renders entry title and note', async () => {
  render(
    <MemoryRouter initialEntries={['/blog/1']}>
      <Routes><Route path="/blog/:id" element={<BlogEntry />} /></Routes>
    </MemoryRouter>
  )
  await waitFor(() => expect(screen.getByText('Hello world')).toBeInTheDocument())
  expect(screen.getByText('Full note text.')).toBeInTheDocument()
})

test('renders comments', async () => {
  render(
    <MemoryRouter initialEntries={['/blog/1']}>
      <Routes><Route path="/blog/:id" element={<BlogEntry />} /></Routes>
    </MemoryRouter>
  )
  await waitFor(() => expect(screen.getByText('Nice!')).toBeInTheDocument())
})
```

- [ ] **Step 2: Run to verify failure**

```bash
npm test
```
Expected: FAIL

- [ ] **Step 3: Create src/pages/BlogEntry.tsx**

```tsx
import { useState, useEffect } from 'react'
import { useParams, Link } from 'react-router-dom'
import { fetchEntry, EntryDetail, Comment, API_URL } from '../hooks/useFeed'

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
}

export default function BlogEntry() {
  const { id } = useParams<{ id: string }>()
  const [entry, setEntry] = useState<EntryDetail | null>(null)
  const [comments, setComments] = useState<Comment[]>([])

  useEffect(() => {
    if (!id) return
    fetchEntry(id).then(data => {
      setEntry(data)
      setComments(data.comments)
    }).catch(() => {})
  }, [id])

  async function handleComment(input: HTMLInputElement) {
    const body = input.value.trim()
    if (!body || !id) return
    try {
      const res = await fetch(`${import.meta.env.VITE_API_URL}/entries/${id}/comments`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ body }),
      })
      if (!res.ok) throw new Error()
      const comment = await res.json() as Comment
      setComments(prev => [...prev, comment])
      input.value = ''
    } catch {
      input.style.borderColor = '#f87171'
      setTimeout(() => { input.style.borderColor = '' }, 600)
    }
  }

  if (!entry) return (
    <div className="min-h-screen bg-white flex items-center justify-center">
      <p className="text-gray-300 text-sm">Loading…</p>
    </div>
  )

  return (
    <div className="min-h-screen bg-white font-sans">
      <div className="max-w-2xl mx-auto px-6 py-12">
        <Link to="/blog" className="text-xs text-gray-400 hover:text-gray-600 mb-8 block">← all posts</Link>
        <p className="text-gray-400 text-xs mb-1">{formatDate(entry.created_at)}</p>
        <h1 className="text-xl font-bold text-gray-900 mb-1">{entry.title}</h1>
        {entry.link && (
          <a href={entry.link} target="_blank" rel="noopener noreferrer"
            className="text-gray-400 italic text-sm block mb-4">{entry.link}</a>
        )}
        {entry.note && <p className="text-gray-600 text-sm leading-relaxed mt-4 mb-8">{entry.note}</p>}

        <div className="border-t border-gray-100 pt-6">
          <p className="text-xs text-gray-400 font-semibold uppercase tracking-wide mb-4">Comments</p>
          {comments.map(c => (
            <div key={c.id} className="mb-3">
              <span className="text-gray-400 text-xs mr-2">visitor</span>
              <span className="text-gray-700 text-sm">{c.body}</span>
            </div>
          ))}
          {comments.length === 0 && <p className="text-gray-300 text-xs italic mb-4">no comments yet</p>}
          <input
            className="w-full max-w-sm text-xs border border-gray-200 rounded px-2 py-1.5 mt-2 focus:outline-none"
            placeholder="Add a comment…"
            onKeyDown={e => { if (e.key === 'Enter') handleComment(e.currentTarget) }}
          />
        </div>
      </div>
    </div>
  )
}
```

- [ ] **Step 4: Run tests**

```bash
npm test
```
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add src/pages/BlogEntry.tsx src/pages/BlogEntry.test.tsx
git commit -m "feat: BlogEntry permalink page"
```

---

### Task 6: Wire everything into App.tsx + main.tsx

**Files:**
- Modify: `src/main.tsx`
- Modify: `src/App.tsx`

- [ ] **Step 1: Update src/main.tsx to add BrowserRouter**

```tsx
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import './index.css'
import App from './App.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </StrictMode>,
)
```

- [ ] **Step 2: Update src/App.tsx to add routes and FeedOverlay**

```tsx
import { Routes, Route } from 'react-router-dom'
import pastryImg from './assets/pastry.png'
import bubbleImg from './assets/bubble.png'
import penImg from './assets/pen.png'
import andImg from './assets/and.png'
import typeImg from './assets/type.png'
import { FeedOverlay } from './components/FeedOverlay'
import Blog from './pages/Blog'
import BlogEntry from './pages/BlogEntry'

function Homepage() {
  return (
    <div className="grid h-screen w-screen bg-white" style={{ gridTemplateColumns: '1fr 1fr 1fr', gridTemplateRows: '1fr 1fr' }}>
      {/* Row 1 */}
      <div className="relative overflow-hidden">
        <img src={typeImg} alt="" className="w-full h-full object-cover" style={{ objectPosition: 'center 45%' }} />
        <FeedOverlay />
      </div>
      <div className="flex items-center justify-center" style={{ fontFamily: '-apple-system, "SF Pro Display", BlinkMacSystemFont, sans-serif', fontSize: 'clamp(80px, 12vw, 180px)' }}>
        K
      </div>
      <div className="overflow-hidden">
        <img src={andImg} alt="" className="w-full h-full object-cover" />
      </div>

      {/* Row 2 */}
      <a href="/fast-french/" target="_blank" rel="noopener noreferrer" className="overflow-hidden">
        <img src={pastryImg} alt="Fast French" className="w-full h-full object-cover" />
      </a>
      <a href="sms:+12068608292" className="overflow-hidden">
        <img src={bubbleImg} alt="Text Me" className="w-full h-full object-cover" />
      </a>
      <a href="/justedit/justedit.html" target="_blank" rel="noopener noreferrer" className="overflow-hidden">
        <img src={penImg} alt="JustEdit" className="w-full h-full object-cover" />
      </a>
    </div>
  )
}

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Homepage />} />
      <Route path="/blog" element={<Blog />} />
      <Route path="/blog/:id" element={<BlogEntry />} />
    </Routes>
  )
}
```

- [ ] **Step 3: Run dev server to verify visually**

```bash
npm run dev
```

Open http://localhost:5173 — should see the grid with FeedOverlay in the top-left cell.
Open http://localhost:5173/blog — should see the blog listing.

- [ ] **Step 4: Run all tests**

```bash
npm test
```
Expected: all PASS

- [ ] **Step 5: Commit**

```bash
git add src/main.tsx src/App.tsx
git commit -m "feat: wire FeedOverlay and blog routes into app"
```

---

### Task 7: Set env vars in GitHub Actions + deploy

- [ ] **Step 1: Add secrets to GitHub repo**

```bash
gh secret set VITE_API_URL --body "https://your-railway-url.up.railway.app"
gh secret set VITE_POST_SECRET --body "your-post-secret"
```

- [ ] **Step 2: Update .github/workflows/deploy.yml to pass env vars at build time**

In the `- run: npm run build` step, add env:
```yaml
      - run: npm run build
        env:
          VITE_API_URL: ${{ secrets.VITE_API_URL }}
          VITE_POST_SECRET: ${{ secrets.VITE_POST_SECRET }}
```

- [ ] **Step 3: Commit and push**

```bash
git add .github/workflows/deploy.yml
git commit -m "chore: pass VITE env vars to build in CI"
git push origin main
```

- [ ] **Step 4: Verify deploy**

```bash
gh run watch
```
Wait for green. Then open kevintraywick.com — FeedOverlay should appear in the type box.

- [ ] **Step 5: End-to-end smoke test**

1. Open kevintraywick.com
2. In the type box, type `[[Hello world` in the Title field, add a note, press Enter — entry should appear
3. Open kevintraywick.com/blog — entry visible
4. Click the title — expands with note + comment input
5. Add a comment — appears inline
6. Open kevintraywick.com/blog/1 — permalink loads correctly
