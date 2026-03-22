import pastryImg from './assets/pastry.png'
import bubbleImg from './assets/bubble.png'
import penImg from './assets/pen.png'
import andImg from './assets/and.png'
import typeImg from './assets/type.png'

function App() {
  return (
    <div className="grid h-screen w-screen bg-white" style={{ gridTemplateColumns: '1fr 1fr 1fr', gridTemplateRows: '1fr 1fr' }}>
      {/* Row 1 */}
      <div className="overflow-hidden">
        <img src={typeImg} alt="" className="w-full h-full object-cover" style={{ objectPosition: 'center 45%' }} />
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
      <a href="https://kevintraywick.com/justedit/justedit.html" target="_blank" rel="noopener noreferrer" className="overflow-hidden">
        <img src={penImg} alt="JustEdit" className="w-full h-full object-cover" />
      </a>
    </div>
  )
}

export default App
