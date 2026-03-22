# kt-feed API Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build and deploy a Node/Express/SQLite REST API to Railway that stores Kevin's feed entries and visitor comments.

**Architecture:** Express app factory receives a SQLite db instance, enabling clean test isolation with in-memory DBs. All data persists in a single SQLite file on Railway's persistent volume.

**Tech Stack:** Node.js, Express, better-sqlite3, cors, Jest, supertest

---

## File Structure

```
kt-feed-api/
  src/
    db.js          — createDb(path) factory: opens SQLite, runs schema migrations
    app.js         — createApp(db) factory: Express app with all routes
    server.js      — production entrypoint: creates db + app, starts listening
  tests/
    entries.test.js
    comments.test.js
  package.json
  .env.example
  .gitignore
  railway.json
```

---

### Task 1: Scaffold the repo

**Files:**
- Create: `package.json`
- Create: `.gitignore`
- Create: `.env.example`
- Create: `railway.json`

- [ ] **Step 1: Create project directory and init git**

```bash
mkdir kt-feed-api && cd kt-feed-api
git init
```

- [ ] **Step 2: Create package.json**

```json
{
  "name": "kt-feed-api",
  "version": "1.0.0",
  "main": "src/server.js",
  "scripts": {
    "start": "node src/server.js",
    "test": "jest --runInBand"
  },
  "dependencies": {
    "better-sqlite3": "^9.4.3",
    "cors": "^2.8.5",
    "express": "^4.18.3"
  },
  "devDependencies": {
    "jest": "^29.7.0",
    "supertest": "^7.0.0"
  }
}
```

- [ ] **Step 3: Create .gitignore**

```
node_modules/
data/
.env
```

- [ ] **Step 4: Create .env.example**

```
PORT=3000
POST_SECRET=your-secret-here
DB_PATH=./data/feed.db
```

- [ ] **Step 5: Create railway.json**

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": { "builder": "NIXPACKS" },
  "deploy": { "startCommand": "node src/server.js", "restartPolicyType": "ON_FAILURE" }
}
```

- [ ] **Step 6: Install dependencies**

```bash
npm install
```

- [ ] **Step 7: Commit**

```bash
git add .
git commit -m "chore: scaffold kt-feed-api"
```

---

### Task 2: Database module

**Files:**
- Create: `src/db.js`

- [ ] **Step 1: Write the failing test**

Create `tests/entries.test.js`:

```js
process.env.POST_SECRET = 'test-secret'
const createDb = require('../src/db')

test('createDb creates tables', () => {
  const db = createDb(':memory:')
  const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table'").all()
  const names = tables.map(t => t.name)
  expect(names).toContain('entries')
  expect(names).toContain('comments')
})
```

- [ ] **Step 2: Run test to verify it fails**

```bash
npm test -- tests/entries.test.js
```
Expected: FAIL — `Cannot find module '../src/db'`

- [ ] **Step 3: Create src/db.js**

```js
const Database = require('better-sqlite3')

function createDb(path) {
  const db = new Database(path || process.env.DB_PATH || './data/feed.db')
  db.exec(`
    CREATE TABLE IF NOT EXISTS entries (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      link TEXT,
      note TEXT,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    CREATE TABLE IF NOT EXISTS comments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      entry_id INTEGER NOT NULL REFERENCES entries(id),
      body TEXT NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
  `)
  return db
}

module.exports = createDb
```

Also create the data directory:
```bash
mkdir -p data
```

- [ ] **Step 4: Run test to verify it passes**

```bash
npm test -- tests/entries.test.js
```
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add src/db.js tests/entries.test.js
git commit -m "feat: database module with schema migrations"
```

---

### Task 3: Express app — GET /entries and POST /entries

**Files:**
- Create: `src/app.js`
- Modify: `tests/entries.test.js`

- [ ] **Step 1: Add failing tests for GET and POST /entries**

Replace `tests/entries.test.js`:

```js
process.env.POST_SECRET = 'test-secret'
const createDb = require('../src/db')
const createApp = require('../src/app')
const request = require('supertest')

const db = createDb(':memory:')
const app = createApp(db)

afterEach(() => {
  db.exec('DELETE FROM comments')
  db.exec('DELETE FROM entries')
})

test('createDb creates tables', () => {
  const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table'").all()
  expect(tables.map(t => t.name)).toContain('entries')
})

test('GET /entries returns empty array', async () => {
  const res = await request(app).get('/entries')
  expect(res.status).toBe(200)
  expect(res.body).toEqual([])
})

test('POST /entries returns 401 without auth', async () => {
  const res = await request(app).post('/entries').send({ title: 'Test' })
  expect(res.status).toBe(401)
})

test('POST /entries returns 400 without title', async () => {
  const res = await request(app)
    .post('/entries')
    .set('Authorization', 'Bearer test-secret')
    .send({})
  expect(res.status).toBe(400)
})

test('POST /entries creates entry with valid auth', async () => {
  const res = await request(app)
    .post('/entries')
    .set('Authorization', 'Bearer test-secret')
    .send({ title: 'Hello', link: 'https://example.com', note: 'My note' })
  expect(res.status).toBe(201)
  expect(res.body.title).toBe('Hello')
  expect(res.body.id).toBeDefined()
})

test('GET /entries returns entries with comment_count', async () => {
  db.prepare('INSERT INTO entries (title) VALUES (?)').run('Test')
  const res = await request(app).get('/entries')
  expect(res.status).toBe(200)
  expect(res.body[0].title).toBe('Test')
  expect(res.body[0].comment_count).toBe(0)
})
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
npm test -- tests/entries.test.js
```
Expected: FAIL — `Cannot find module '../src/app'`

- [ ] **Step 3: Create src/app.js**

```js
const express = require('express')
const cors = require('cors')

function createApp(db) {
  const app = express()
  app.use(express.json())
  app.use(cors({
    origin: [
      'https://kevintraywick.com',
      'http://localhost:5173',
      'http://localhost:4173'
    ]
  }))

  app.get('/entries', (req, res) => {
    const entries = db.prepare(`
      SELECT e.*, COUNT(c.id) as comment_count
      FROM entries e
      LEFT JOIN comments c ON c.entry_id = e.id
      GROUP BY e.id
      ORDER BY e.created_at DESC
      LIMIT 20
    `).all()
    res.json(entries)
  })

  app.post('/entries', (req, res) => {
    const auth = req.headers.authorization
    if (auth !== `Bearer ${process.env.POST_SECRET}`) {
      return res.status(401).json({ error: 'Unauthorized' })
    }
    const { title, link, note } = req.body
    if (!title) return res.status(400).json({ error: 'title required' })
    const result = db.prepare(
      'INSERT INTO entries (title, link, note) VALUES (?, ?, ?)'
    ).run(title, link || null, note || null)
    const entry = db.prepare('SELECT * FROM entries WHERE id = ?').get(result.lastInsertRowid)
    res.status(201).json(entry)
  })

  return app
}

module.exports = createApp
```

- [ ] **Step 4: Run tests to verify they pass**

```bash
npm test -- tests/entries.test.js
```
Expected: all PASS

- [ ] **Step 5: Commit**

```bash
git add src/app.js tests/entries.test.js
git commit -m "feat: GET /entries and POST /entries with auth"
```

---

### Task 4: GET /entries/:id and POST /entries/:id/comments

**Files:**
- Modify: `src/app.js`
- Create: `tests/comments.test.js`

- [ ] **Step 1: Write failing tests**

Create `tests/comments.test.js`:

```js
process.env.POST_SECRET = 'test-secret'
const createDb = require('../src/db')
const createApp = require('../src/app')
const request = require('supertest')

const db = createDb(':memory:')
const app = createApp(db)
let entryId

beforeEach(() => {
  db.exec('DELETE FROM comments; DELETE FROM entries')
  const { lastInsertRowid } = db.prepare('INSERT INTO entries (title) VALUES (?)').run('Test entry')
  entryId = lastInsertRowid
})

test('GET /entries/:id returns entry with comments', async () => {
  db.prepare('INSERT INTO comments (entry_id, body) VALUES (?, ?)').run(entryId, 'Nice post')
  const res = await request(app).get(`/entries/${entryId}`)
  expect(res.status).toBe(200)
  expect(res.body.title).toBe('Test entry')
  expect(res.body.comments).toHaveLength(1)
  expect(res.body.comments[0].body).toBe('Nice post')
})

test('GET /entries/:id returns 404 for missing entry', async () => {
  const res = await request(app).get('/entries/999')
  expect(res.status).toBe(404)
})

test('POST /entries/:id/comments creates comment', async () => {
  const res = await request(app)
    .post(`/entries/${entryId}/comments`)
    .send({ body: 'Great post!' })
  expect(res.status).toBe(201)
  expect(res.body.body).toBe('Great post!')
  expect(res.body.entry_id).toBe(entryId)
})

test('POST /entries/:id/comments returns 400 without body', async () => {
  const res = await request(app)
    .post(`/entries/${entryId}/comments`)
    .send({})
  expect(res.status).toBe(400)
})

test('POST /entries/:id/comments returns 404 for missing entry', async () => {
  const res = await request(app)
    .post('/entries/999/comments')
    .send({ body: 'comment' })
  expect(res.status).toBe(404)
})
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
npm test -- tests/comments.test.js
```
Expected: FAIL — routes not found (404)

- [ ] **Step 3: Add routes to src/app.js**

Add inside `createApp`, before `return app`:

```js
  app.get('/entries/:id', (req, res) => {
    const entry = db.prepare('SELECT * FROM entries WHERE id = ?').get(req.params.id)
    if (!entry) return res.status(404).json({ error: 'Not found' })
    const comments = db.prepare(
      'SELECT * FROM comments WHERE entry_id = ? ORDER BY created_at ASC'
    ).all(req.params.id)
    res.json({ ...entry, comments })
  })

  app.post('/entries/:id/comments', (req, res) => {
    const entry = db.prepare('SELECT id FROM entries WHERE id = ?').get(req.params.id)
    if (!entry) return res.status(404).json({ error: 'Not found' })
    const { body } = req.body
    if (!body) return res.status(400).json({ error: 'body required' })
    const result = db.prepare(
      'INSERT INTO comments (entry_id, body) VALUES (?, ?)'
    ).run(req.params.id, body)
    const comment = db.prepare('SELECT * FROM comments WHERE id = ?').get(result.lastInsertRowid)
    res.status(201).json(comment)
  })
```

- [ ] **Step 4: Run all tests**

```bash
npm test
```
Expected: all PASS

- [ ] **Step 5: Commit**

```bash
git add src/app.js tests/comments.test.js
git commit -m "feat: GET /entries/:id and POST /entries/:id/comments"
```

---

### Task 5: Production server + deploy to Railway

**Files:**
- Create: `src/server.js`

- [ ] **Step 1: Create src/server.js**

```js
const createDb = require('./db')
const createApp = require('./app')

const db = createDb()
const app = createApp(db)
const port = process.env.PORT || 3000

app.listen(port, () => {
  console.log(`kt-feed-api listening on port ${port}`)
})
```

- [ ] **Step 2: Test locally**

```bash
POST_SECRET=test node src/server.js
# In another terminal:
curl http://localhost:3000/entries
```
Expected: `[]`

- [ ] **Step 3: Commit**

```bash
git add src/server.js
git commit -m "feat: production server entrypoint"
```

- [ ] **Step 4: Create GitHub repo and push**

```bash
gh repo create kt-feed-api --private --source=. --push
```

- [ ] **Step 5: Deploy to Railway**

1. Go to railway.app → New Project → Deploy from GitHub repo → select `kt-feed-api`
2. In Railway dashboard → Variables → add:
   - `POST_SECRET` = (choose a strong secret and save it — you'll need it as `VITE_POST_SECRET` in the frontend)
   - `DB_PATH` = `/data/feed.db`
3. In Railway → Settings → Add a volume mounted at `/data`
4. Wait for deploy to complete

- [ ] **Step 6: Smoke test the live API**

```bash
RAILWAY_URL=https://your-app.up.railway.app
curl $RAILWAY_URL/entries
# Expected: []

curl -X POST $RAILWAY_URL/entries \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_POST_SECRET" \
  -d '{"title":"Hello world","note":"First post"}'
# Expected: {"id":1,"title":"Hello world",...}

curl $RAILWAY_URL/entries
# Expected: [{"id":1,"title":"Hello world","comment_count":0,...}]
```

- [ ] **Step 7: Note the Railway URL** — you'll need it for `VITE_API_URL` in the frontend plan.
