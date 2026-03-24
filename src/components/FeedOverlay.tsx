import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useFeed } from '../hooks/useFeed'

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
}

function hostname(url: string) {
  try { return new URL(url).hostname } catch { return url }
}

export function FeedOverlay() {
  const { entries, postComment } = useFeed()
  const navigate = useNavigate()
  const [isDragOver, setIsDragOver] = useState(false)

  const recent = entries.slice(0, 8)

  function handleDragOver(e: React.DragEvent) {
    e.preventDefault()
    setIsDragOver(true)
  }

  function handleDragLeave() {
    setIsDragOver(false)
  }

  function handleDrop(e: React.DragEvent) {
    e.preventDefault()
    setIsDragOver(false)
    const file = e.dataTransfer.files[0]
    if (file) {
      const previewUrl = URL.createObjectURL(file)
      navigate('/blog', { state: { draft: { title: file.name, previewUrl } } })
      return
    }
    const url = e.dataTransfer.getData('text/uri-list') || e.dataTransfer.getData('text/plain')
    if (url?.startsWith('http')) {
      navigate('/blog', { state: { draft: { title: hostname(url), link: url } } })
      return
    }
    navigate('/blog')
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
    <div className="absolute inset-0 flex flex-col font-sans text-xs overflow-hidden">
      {/* Feed */}
      <div className="flex-1 overflow-y-auto p-2.5 space-y-2">
        {recent.map(entry => (
          <div key={entry.id} className="bg-white/90 rounded p-2">
            <div className="leading-snug">
              <span className="text-gray-500 text-[12px] mr-1.5">{formatDate(entry.created_at)}</span>
              <button
                className="font-semibold text-black hover:underline text-left text-[13px]"
                onClick={() => navigate(`/blog/${entry.id}`)}
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
            {entry.note
              ? <p className="text-black text-[12px] leading-snug mt-0.5 line-clamp-3">{entry.note}</p>
              : null
            }
            <input
              className="mt-1 w-full text-[12px] border border-gray-200 rounded px-1.5 py-0.5 bg-white placeholder-gray-400 focus:outline-none"
              placeholder="Add a comment…"
              onKeyDown={e => { if (e.key === 'Enter') handleComment(entry.id, e.currentTarget) }}
            />
          </div>
        ))}
      </div>

      {/* + button */}
      <div className="border-t border-black/10 flex items-center justify-center py-1.5 bg-white/60">
        <button
          className="w-5 h-5 rounded-full flex items-center justify-center text-white leading-none transition-opacity"
          style={{ background: isDragOver ? '#666' : '#999', fontSize: '16px', opacity: isDragOver ? 0.8 : 0.4 }}
          onClick={() => navigate('/blog')}
          onDragOver={handleDragOver}
          onDragLeave={handleDragLeave}
          onDrop={handleDrop}
        >
          +
        </button>
      </div>
    </div>
  )
}
