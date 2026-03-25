import { useState, useRef } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useFeed } from '../hooks/useFeed'
import type { Entry, Comment } from '../hooks/useFeed'

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
  const { entries, loading, postEntry, postComment } = useFeed()
  const navigate = useNavigate()

  const titleRef = useRef<HTMLInputElement>(null)
  const linkRef = useRef<HTMLInputElement>(null)
  const noteRef = useRef<HTMLInputElement>(null)

  async function handlePost() {
    const title = titleRef.current!.value.trim()
    if (!title) return
    try {
      await postEntry(title, linkRef.current!.value.trim(), noteRef.current!.value.trim())
      titleRef.current!.value = ''
      linkRef.current!.value = ''
      noteRef.current!.value = ''
      navigate('/blog')
    } catch {}
  }

  return (
    <div className="min-h-screen bg-white font-sans">
      <div className="max-w-2xl mx-auto px-6 py-12">
        <div className="flex items-baseline justify-between mb-8">
          <Link to="/" className="text-sm font-semibold text-gray-400 uppercase tracking-widest hover:text-gray-600">
            Kevin Traywick · thoughts &amp; links
          </Link>
        </div>

        {/* Post form */}
        <div className="mb-10 pb-8 border-b border-gray-100">
          <div className="flex flex-col gap-2">
            <input
              ref={titleRef}
              className="w-full text-sm border border-gray-200 rounded px-2.5 py-1.5 focus:outline-none"
              placeholder="Title…"
              onKeyDown={e => { if (e.key === 'Enter') handlePost() }}
            />
            <input
              ref={linkRef}
              className="w-full text-sm border border-gray-200 rounded px-2.5 py-1.5 focus:outline-none"
              placeholder="Link (optional)…"
            />
            <input
              ref={noteRef}
              className="w-full text-sm border border-gray-200 rounded px-2.5 py-1.5 focus:outline-none"
              placeholder="Note…"
              onKeyDown={e => { if (e.key === 'Enter') handlePost() }}
            />
            <div>
              <button
                onClick={handlePost}
                className="text-xs bg-gray-900 text-white rounded px-3 py-1.5 hover:bg-gray-700"
              >
                Post
              </button>
            </div>
          </div>
        </div>

        {loading && <p className="text-gray-300 text-sm">Loading…</p>}
        {entries.map(entry => (
          <EntryRow key={entry.id} entry={entry} postComment={postComment} />
        ))}
      </div>
    </div>
  )
}
