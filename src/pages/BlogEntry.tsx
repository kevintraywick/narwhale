import { useState, useEffect } from 'react'
import { useParams, Link } from 'react-router-dom'
import { fetchEntry, API_URL } from '../hooks/useFeed'
import { formatDate } from '../utils/format'
import type { EntryDetail, Comment } from '../hooks/useFeed'

export default function BlogEntry() {
  const { id } = useParams<{ id: string }>()
  const [entry, setEntry] = useState<EntryDetail | null>(null)
  const [comments, setComments] = useState<Comment[]>([])
  const [commentValue, setCommentValue] = useState('')
  const [commentError, setCommentError] = useState(false)

  useEffect(() => {
    if (!id) return
    fetchEntry(id).then(data => {
      setEntry(data)
      setComments(data.comments)
    }).catch(() => {})
  }, [id])

  async function handleComment() {
    const body = commentValue.trim()
    if (!body || !id) return
    try {
      const res = await fetch(`${API_URL}/entries/${id}/comments`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ body }),
      })
      if (!res.ok) throw new Error()
      const comment = await res.json() as Comment
      setComments(prev => [...prev, comment])
      setCommentValue('')
      setCommentError(false)
    } catch {
      setCommentError(true)
      setTimeout(() => setCommentError(false), 600)
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
        <p className="text-gray-400 text-xs mb-1">{formatDate(entry.created_at, true)}</p>
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
            className={`w-full max-w-sm text-xs border rounded px-2 py-1.5 mt-2 focus:outline-none ${commentError ? 'border-red-400' : 'border-gray-200'}`}
            placeholder="Add a comment…"
            value={commentValue}
            onChange={e => setCommentValue(e.target.value)}
            onKeyDown={e => { if (e.key === 'Enter') handleComment() }}
          />
        </div>
      </div>
    </div>
  )
}
