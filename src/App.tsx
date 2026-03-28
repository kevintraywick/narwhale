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

function Homepage() {
  return (
    <div className="grid h-screen w-screen bg-white" style={{ gridTemplateColumns: 'repeat(9, 1fr)', gridTemplateRows: 'repeat(9, 1fr)' }}>
      {/* Blog — spans positions 1 and 4 (col 1-3, row 1-6) */}
      <div className="relative overflow-hidden bg-black" style={{ gridColumn: '1 / 4', gridRow: '1 / 7' }}>
        <FeedOverlay />
      </div>
      {/* Text Me — position 2 */}
      <a href="sms:+12068608292" className="overflow-hidden" style={{ gridColumn: '4 / 7', gridRow: '1 / 4' }}>
        <img src={bubbleImg} alt="Text Me" className="w-full h-full object-cover" />
      </a>
      {/* Blackmoor — position 3 */}
      <a href="https://blackmoor-production.up.railway.app" target="_blank" rel="noopener noreferrer" className="overflow-hidden" style={{ gridColumn: '7 / 10', gridRow: '1 / 4' }}>
        <img src={andImg} alt="Blackmoor" className="w-full h-full object-cover" />
      </a>

      {/* K — position 5 (center) */}
      <div className="flex items-center justify-center" style={{ gridColumn: '4 / 7', gridRow: '4 / 7', fontFamily: '"Barlow Condensed", sans-serif', fontWeight: 900, fontSize: 'clamp(120px, 18vw, 280px)', lineHeight: 1 }}>
        K
      </div>
      {/* JustEdit — position 6 */}
      <a href="/justedit/justedit.html" target="_blank" rel="noopener noreferrer" className="overflow-hidden" style={{ gridColumn: '7 / 10', gridRow: '4 / 7' }}>
        <img src={penImg} alt="JustEdit" className="w-full h-full object-cover" />
      </a>

      {/* position 7 */}
      <div className="flex items-center justify-center bg-white border border-black" style={{ gridColumn: '1 / 4', gridRow: '7 / 10', fontFamily: '"Barlow Condensed", sans-serif', fontWeight: 900, fontSize: 'clamp(80px, 12vw, 200px)', lineHeight: 1 }}>
        7
      </div>
      {/* Fast French — position 8 (moved from 4) */}
      <a href="/fast-french/" target="_blank" rel="noopener noreferrer" className="overflow-hidden" style={{ gridColumn: '4 / 7', gridRow: '7 / 10' }}>
        <img src={pastryImg} alt="Fast French" className="w-full h-full object-cover" />
      </a>
      {/* Wind — position 9 */}
      <div className="overflow-hidden" style={{ gridColumn: '7 / 10', gridRow: '7 / 10' }}>
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
