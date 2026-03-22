import pastryImg from './assets/pastry.png'
import bubbleImg from './assets/bubble.png'
import penImg from './assets/pen.png'
import andImg from './assets/and.png'
import typeImg from './assets/type.png'

function App() {
  return (
    <div className="min-h-screen bg-white flex flex-col justify-end">
      <div className="flex justify-center items-end">
        <div className="flex flex-col">
          <div className="w-[500px] h-[500px] overflow-hidden">
            <img src={typeImg} alt="" className="w-full h-full object-cover opacity-25" style={{ objectPosition: 'center 45%' }} />
          </div>
          <a href="/fast-french/" target="_blank" rel="noopener noreferrer">
            <img src={pastryImg} alt="Fast French" className="w-[500px] h-[500px] object-cover" />
          </a>
        </div>
        <a href="sms:+12068608292">
          <img src={bubbleImg} alt="Text Me" className="w-[500px] h-[500px] object-cover" />
        </a>
        <div className="flex flex-col">
          <img src={andImg} alt="" className="w-[500px] h-[500px] object-cover" />
          <a href="https://kevintraywick.com/justedit/justedit.html" target="_blank" rel="noopener noreferrer">
            <img src={penImg} alt="JustEdit" className="w-[500px] h-[500px] object-cover" />
          </a>
        </div>
      </div>
    </div>
  )
}

export default App
