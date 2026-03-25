#!/usr/bin/env node
// Usage: node scripts/update-houdini.js
// Scans public/houdini/ and writes public/houdini/files.json

import { readdirSync, writeFileSync } from 'fs'
import { extname, join } from 'path'

const dir = new URL('../public/houdini', import.meta.url).pathname
const SKIP = new Set(['index.html', 'files.json'])

const EXT_TYPE = {
  '.png': 'image', '.jpg': 'image', '.jpeg': 'image',
  '.gif': 'image', '.webp': 'image', '.svg': 'image',
  '.pdf': 'pdf',
  '.html': 'html', '.htm': 'html',
}

const files = readdirSync(dir)
  .filter(f => !SKIP.has(f) && !f.startsWith('.'))
  .sort()
  .map(name => ({ name, type: EXT_TYPE[extname(name).toLowerCase()] ?? 'html' }))

writeFileSync(join(dir, 'files.json'), JSON.stringify(files, null, 2))
console.log(`wrote files.json with ${files.length} entries:`)
files.forEach(f => console.log(`  ${f.type.padEnd(6)} ${f.name}`))
