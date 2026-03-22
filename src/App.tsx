import { Routes, Route } from 'react-router-dom'
import pastryImg from './assets/pastry.png'
import bubbleImg from './assets/bubble.png'
import penImg from './assets/pen.png'
import andImg from './assets/and.png'
import typeImg from './assets/type.png'
import { FeedOverlay } from './components/FeedOverlay'
import Blog from './pages/Blog'
import BlogEntry from './pages/BlogEntry'

function Homepage() {
  return (
    <div className="grid h-screen w-screen bg-white" style={{ gridTemplateColumns: '1fr 1fr 1fr', gridTemplateRows: '1fr 1fr' }}>
      {/* Row 1 */}
      <div className="relative overflow-hidden">
        <img src={typeImg} alt="" className="w-full h-full object-cover" style={{ objectPosition: 'center 45%' }} />
        <FeedOverlay />
      </div>
      <div className="flex items-center justify-center" style={{ fontFamily: '-apple-system, "SF Pro Display", BlinkMacSystemFont, sans-serif', fontSize: 'clamp(80px, 12vw, 180px)' }}>
        K
      </div>
      <div className="overflow-hidden">
        <img src={andImg} alt="" className="w-full h-full object-cover" />
      </div>

      {/* Row 2 */}
      <a href="/fast-french/" target="_blank" rel="noopener noreferrer" className="overflow-hidden">
        <img src={pastryImg} alt="Fast French" className="w-full h-full object-cover" />
      </a>
      <a href="sms:+12068608292" className="overflow-hidden">
        <img src={bubbleImg} alt="Text Me" className="w-full h-full object-cover" />
      </a>
      <a href="/justedit/justedit.html" target="_blank" rel="noopener noreferrer" className="overflow-hidden">
        <img src={penImg} alt="JustEdit" className="w-full h-full object-cover" />
      </a>
    </div>
  )
}

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Homepage />} />
      <Route path="/blog" element={<Blog />} />
      <Route path="/blog/:id" element={<BlogEntry />} />
    </Routes>
  )
}
