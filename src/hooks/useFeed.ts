import { useState, useEffect } from 'react'

export const API_URL = import.meta.env.VITE_API_URL as string

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
