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
    if (!title || !isKevin) return
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
    <div className="absolute inset-0 flex flex-col font-sans text-xs overflow-hidden">
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
