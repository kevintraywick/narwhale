import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useFeed } from '../hooks/useFeed'
import { formatDate, hostname } from '../utils/format'

const FEED_PREVIEW_LIMIT = 8

export function FeedOverlay() {
  const { entries, postComment } = useFeed()
  const navigate = useNavigate()
  const [isDragOver, setIsDragOver] = useState(false)
  const [commentValues, setCommentValues] = useState<Record<number, string>>({})
  const [commentErrors, setCommentErrors] = useState<Record<number, boolean>>({})

  const recent = entries.slice(0, FEED_PREVIEW_LIMIT)

  function handleDragOver(e: React.DragEvent) {
    e.preventDefault()
    if (!isDragOver) setIsDragOver(true)
  }

  function handleDragLeave(e: React.DragEvent) {
    if (!e.currentTarget.contains(e.relatedTarget as Node)) {
      setIsDragOver(false)
    }
  }

  function handleDrop(e: React.DragEvent) {
    e.preventDefault()
    setIsDragOver(false)
    const url = e.dataTransfer.getData('text/uri-list') || e.dataTransfer.getData('text/plain')
    if (url?.startsWith('http')) {
      navigate('/blog', { state: { title: hostname(url), link: url } })
    }
    // file drops and unrecognized content: do nothing
  }

  async function handleComment(entryId: number) {
    const body = (commentValues[entryId] || '').trim()
    if (!body) return
    try {
      await postComment(entryId, body)
      setCommentValues(prev => ({ ...prev, [entryId]: '' }))
      setCommentErrors(prev => ({ ...prev, [entryId]: false }))
    } catch {
      setCommentErrors(prev => ({ ...prev, [entryId]: true }))
      setTimeout(() => setCommentErrors(prev => ({ ...prev, [entryId]: false })), 600)
    }
  }

  return (
    <div
      className="absolute inset-0 flex flex-col font-sans text-xs overflow-hidden transition-colors"
      style={{ background: isDragOver ? 'rgba(255,255,255,0.08)' : 'transparent' }}
      onDragOver={handleDragOver}
      onDragLeave={handleDragLeave}
      onDrop={handleDrop}
    >
      {/* Feed */}
      <div
        className="flex-1 overflow-y-auto p-2.5 space-y-2"
        style={{ scrollbarWidth: 'none' }}
      >
        {recent.map(entry => (
          <div key={entry.id} className="bg-white/90 rounded p-2">
            <div className="leading-snug">
              <span className="text-gray-500 text-[12px] mr-1.5">{formatDate(entry.created_at)}</span>
              <button
                className="font-semibold text-black hover:underline text-left text-[13px]"
                onClick={() => navigate('/blog/' + entry.id)}
              >
                {entry.title}
              </button>
              {entry.link && (
                <>
                  <span className="text-gray-400 mx-1">·</span>
                  <a
                    href={entry.link}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-gray-500 italic text-[12px]"
                    onClick={e => e.stopPropagation()}
                  >
                    {hostname(entry.link)}
                  </a>
                </>
              )}
            </div>
            {entry.note && (
              <p className="text-black text-[12px] leading-snug mt-0.5 line-clamp-3">{entry.note}</p>
            )}
            <input
              className={`mt-1 w-full text-[12px] border rounded px-1.5 py-0.5 bg-white placeholder-gray-400 focus:outline-none ${commentErrors[entry.id] ? 'border-red-400' : 'border-gray-200'}`}
              placeholder="Add a comment…"
              value={commentValues[entry.id] || ''}
              onChange={e => setCommentValues(prev => ({ ...prev, [entry.id]: e.target.value }))}
              onKeyDown={e => { if (e.key === 'Enter') handleComment(entry.id) }}
            />
          </div>
        ))}
      </div>

      {/* + button */}
      <button
        className="border-t border-white/10 flex items-center justify-center py-1.5 w-full cursor-pointer"
        onClick={() => navigate('/blog')}
        aria-label="Go to blog"
      >
        <span
          className="w-5 h-5 rounded-full flex items-center justify-center text-white leading-none"
          style={{ background: '#999', fontSize: '16px', opacity: isDragOver ? 0.8 : 0.4 }}
        >
          +
        </span>
      </button>
    </div>
  )
}
