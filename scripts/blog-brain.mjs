#!/usr/bin/env node

// Blog Brain Agent 🧠
// Finds new blog entries with .html links, reads the page,
// generates a <30 word description via Claude, and posts it as a comment.

const API_URL = process.env.VITE_API_URL
const ANTHROPIC_API_KEY = process.env.ANTHROPIC_API_KEY

if (!API_URL || !ANTHROPIC_API_KEY) {
  console.error('Missing VITE_API_URL or ANTHROPIC_API_KEY')
  process.exit(1)
}

async function fetchEntries() {
  const res = await fetch(`${API_URL}/entries`)
  if (!res.ok) throw new Error(`Failed to fetch entries: ${res.status}`)
  return res.json()
}

async function fetchEntryDetail(id) {
  const res = await fetch(`${API_URL}/entries/${id}`)
  if (!res.ok) throw new Error(`Failed to fetch entry ${id}: ${res.status}`)
  return res.json()
}

async function postComment(entryId, body) {
  const res = await fetch(`${API_URL}/entries/${entryId}/comments`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ body }),
  })
  if (!res.ok) throw new Error(`Failed to post comment on entry ${entryId}: ${res.status}`)
  return res.json()
}

const MAX_FETCH_RETRIES = 10

async function fetchHtmlText(url) {
  let lastError
  for (let attempt = 1; attempt <= MAX_FETCH_RETRIES; attempt++) {
    try {
      const res = await fetch(url)
      if (!res.ok) throw new Error(`Failed to fetch ${url}: ${res.status}`)
      const html = await res.text()
      // Strip tags, collapse whitespace, take first 5000 chars for the prompt
      const text = html
        .replace(/<script[\s\S]*?<\/script>/gi, '')
        .replace(/<style[\s\S]*?<\/style>/gi, '')
        .replace(/<[^>]+>/g, ' ')
        .replace(/\s+/g, ' ')
        .trim()
        .slice(0, 5000)
      return text
    } catch (err) {
      lastError = err
      console.log(`  Attempt ${attempt}/${MAX_FETCH_RETRIES} failed: ${err.message}`)
      if (attempt < MAX_FETCH_RETRIES) {
        await new Promise(r => setTimeout(r, 1000 * attempt))
      }
    }
  }
  throw lastError
}

async function generateDescription(pageText, title) {
  const res = await fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': ANTHROPIC_API_KEY,
      'anthropic-version': '2023-06-01',
    },
    body: JSON.stringify({
      model: 'claude-haiku-4-5-20251001',
      max_tokens: 100,
      messages: [{
        role: 'user',
        content: `You are writing a brief comment on a blog post. The blog entry is titled "${title}" and links to a web page. Here is the text content of that page:\n\n${pageText}\n\nWrite a description in under 120 characters. Be direct and descriptive — no filler phrases like "This page" or "This is". End your response with exactly: 🧠`,
      }],
    }),
  })
  if (!res.ok) {
    const err = await res.text()
    throw new Error(`Claude API error: ${res.status} ${err}`)
  }
  const data = await res.json()
  let text = data.content[0].text.trim()
  // Ensure it ends with 🧠
  if (!text.endsWith('🧠')) {
    text = text.replace(/\s*$/, ' 🧠')
  }
  return text
}

function hasLink(link) {
  if (!link) return false
  try {
    new URL(link)
    return true
  } catch {
    return false
  }
}

const BRAIN = '🧠'

function alreadyCommented(comments) {
  return comments.some(c => c.body.includes(BRAIN))
}

async function main() {
  console.log('Blog Brain Agent starting...')

  const entries = await fetchEntries()
  console.log(`Found ${entries.length} entries`)

  // Only check entries from the last 24 hours with .html links
  const cutoff = Date.now() - 24 * 60 * 60 * 1000
  const recent = entries.filter(e =>
    hasLink(e.link) && new Date(e.created_at).getTime() > cutoff
  )

  console.log(`${recent.length} recent entries with .html links`)

  for (const entry of recent) {
    console.log(`Checking entry ${entry.id}: "${entry.title}"`)

    const detail = await fetchEntryDetail(entry.id)
    if (alreadyCommented(detail.comments)) {
      console.log(`  Already commented, skipping`)
      continue
    }

    console.log(`  Fetching ${entry.link}`)
    let pageText
    try {
      pageText = await fetchHtmlText(entry.link)
    } catch (err) {
      console.log(`  Failed to fetch after ${MAX_FETCH_RETRIES} attempts, skipping: ${err.message}`)
      continue
    }

    console.log(`  Generating description...`)
    const description = await generateDescription(pageText, entry.title)
    console.log(`  Description: ${description}`)

    await postComment(entry.id, description)
    console.log(`  Comment posted!`)
  }

  console.log('Done.')
}

main().catch(err => {
  console.error(err)
  process.exit(1)
})
