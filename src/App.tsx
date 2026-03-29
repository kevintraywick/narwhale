import { useState } from 'react'
import { Routes, Route } from 'react-router-dom'
import Footer from './components/Footer'
import pastryImg from './assets/pastry.png'
import bubbleImg from './assets/bubble.png'
import penImg from './assets/pen.png'
import andImg from './assets/and.png'
import windImg from './assets/wind.png'
import { FeedOverlay } from './components/FeedOverlay'
import Blog from './pages/Blog'
import BlogEntry from './pages/BlogEntry'

const kFont = { fontFamily: '"Barlow Condensed", sans-serif', fontWeight: 900 } as const

function Homepage() {
  const [hoverText, setHoverText] = useState<string | null>(null)
  const hover = (text: string) => ({ onMouseEnter: () => setHoverText(text), onMouseLeave: () => setHoverText(null) })

  return (
    <div className="grid h-screen w-screen bg-white" style={{ gridTemplateColumns: 'repeat(9, 1fr)', gridTemplateRows: 'repeat(9, 1fr)' }}>
      {/* Blog — spans positions 1, 4, and 7 (col 1-3, row 1-9) */}
      <div className="relative overflow-hidden bg-black" style={{ gridColumn: '1 / 4', gridRow: '1 / 10' }} {...hover('My blog')}>
        <FeedOverlay />
      </div>
      {/* Text Me — position 2 */}
      <a href="sms:+12068608292" className="overflow-hidden" style={{ gridColumn: '4 / 7', gridRow: '1 / 4' }} {...hover('Text me here')}>
        <img src={bubbleImg} alt="Text Me" className="w-full h-full object-cover" />
      </a>
      {/* Blackmoor — position 3 */}
      <a href="https://blackmoor-production.up.railway.app" target="_blank" rel="noopener noreferrer" className="overflow-hidden" style={{ gridColumn: '7 / 10', gridRow: '1 / 4' }} {...hover('Shadow of the Wolf')}>
        <img src={andImg} alt="Blackmoor" className="w-full h-full object-cover" />
      </a>

      {/* K — position 5 (center) */}
      <div className="relative flex items-center justify-center" style={{ gridColumn: '4 / 7', gridRow: '4 / 7' }}>
        <span style={{ ...kFont, fontSize: 'clamp(120px, 18vw, 280px)', lineHeight: 1, opacity: hoverText ? 0 : 1, transition: 'opacity 0.3s' }}>
          K
        </span>
        {hoverText && (
          <span className="absolute inset-[5%] flex items-center justify-center text-center" style={{ ...kFont, fontSize: 'clamp(28px, 5vw, 72px)', lineHeight: 1.1, opacity: 1, transition: 'opacity 0.3s', whiteSpace: 'pre-line' }}>
            {hoverText}
          </span>
        )}
      </div>
      {/* JustEdit — position 6 */}
      <a href="/justedit/justedit.html" target="_blank" rel="noopener noreferrer" className="overflow-hidden" style={{ gridColumn: '7 / 10', gridRow: '4 / 7' }} {...hover('Write me here')}>
        <img src={penImg} alt="JustEdit" className="w-full h-full object-cover" />
      </a>

      {/* Fast French — position 8 */}
      <a href="/fast-french/" target="_blank" rel="noopener noreferrer" className="overflow-hidden" style={{ gridColumn: '4 / 7', gridRow: '7 / 10' }} {...hover('Fast French,\nmy French learning game')}>
        <img src={pastryImg} alt="Fast French" className="w-full h-full object-cover" />
      </a>
      {/* Wind — position 9 */}
      <div className="overflow-hidden" style={{ gridColumn: '7 / 10', gridRow: '7 / 10' }} {...hover('Windy,\nmy real time wind project')}>
        <img src={windImg} alt="Wind" className="w-full h-full object-cover" />
      </div>
    </div>
  )
}

export default function App() {
  return (
    <>
      <Routes>
        <Route path="/" element={<Homepage />} />
        <Route path="/blog" element={<Blog />} />
        <Route path="/blog/:id" element={<BlogEntry />} />
      </Routes>
      <Footer />
    </>
  )
}
