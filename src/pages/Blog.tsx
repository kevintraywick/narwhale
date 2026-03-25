import { useState, useRef, useEffect } from 'react'
import { Link, useNavigate, useLocation } from 'react-router-dom'
import { useFeed, API_URL } from '../hooks/useFeed'
import { formatDate, hostname } from '../utils/format'
import type { Entry, Comment } from '../hooks/useFeed'

function EntryRow({ entry, postComment }: { entry: Entry, postComment: (id: number, body: string) => Promise<Comment> }) {
  const [expanded, setExpanded] = useState(false)
  const [comments, setComments] = useState<Comment[]>([])
  const [loadedComments, setLoadedComments] = useState(false)
  const [commentValue, setCommentValue] = useState('')
  const [commentError, setCommentError] = useState(false)

  async function expand() {
    if (!expanded && !loadedComments) {
      try {
        const res = await fetch(`${API_URL}/entries/${entry.id}`)
        if (!res.ok) throw new Error()
        const data = await res.json()
        setComments(data.comments || [])
        setLoadedComments(true)
      } catch {
        return
      }
    }
    setExpanded(e => !e)
  }

  async function handleComment() {
    const body = commentValue.trim()
    if (!body) return
    try {
      const comment = await postComment(entry.id, body)
      setComments(prev => [...prev, comment])
      setCommentValue('')
      setCommentError(false)
    } catch {
      setCommentError(true)
      setTimeout(() => setCommentError(false), 600)
    }
  }

  return (
    <div className="border-b border-gray-100 py-4">
      <div>
        <span className="text-gray-400 text-xs mr-2">{formatDate(entry.created_at, true)}</span>
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
              className={`w-full max-w-sm text-xs border rounded px-2 py-1 mt-1 focus:outline-none ${commentError ? 'border-red-400' : 'border-gray-200'}`}
              placeholder="Add a comment…"
              value={commentValue}
              onChange={e => setCommentValue(e.target.value)}
              onKeyDown={e => { if (e.key === 'Enter') handleComment() }}
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
  const location = useLocation()
  const pending = location.state as { title?: string; link?: string; imageUrl?: string } | null
  const [previewUrl, setPreviewUrl] = useState<string | undefined>()

  const titleRef = useRef<HTMLInputElement>(null)
  const linkRef = useRef<HTMLInputElement>(null)
  const noteRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    if (pending?.title && titleRef.current) titleRef.current.value = pending.title
    if (pending?.link && linkRef.current) linkRef.current.value = pending.link
    if (pending?.imageUrl) setPreviewUrl(pending.imageUrl)
  }, []) // eslint-disable-line react-hooks/exhaustive-deps

  async function handlePost() {
    const title = titleRef.current!.value.trim()
    if (!title) return
    try {
      await postEntry(title, linkRef.current!.value.trim(), noteRef.current!.value.trim(), previewUrl)
      titleRef.current!.value = ''
      linkRef.current!.value = ''
      noteRef.current!.value = ''
      setPreviewUrl(undefined)
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
            {previewUrl && (
              <div className="relative">
                <img
                  src={previewUrl}
                  alt=""
                  className="w-full max-h-48 rounded object-contain bg-gray-50"
                />
                <button
                  type="button"
                  onClick={() => setPreviewUrl(undefined)}
                  className="absolute top-1 right-1 text-xs bg-black/40 text-white rounded px-1.5 py-0.5 hover:bg-black/60"
                >
                  ✕
                </button>
              </div>
            )}
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
