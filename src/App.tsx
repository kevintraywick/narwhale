import pastryImg from './assets/pastry.png'
import bubbleImg from './assets/bubble.png'
import penImg from './assets/pen.png'

function App() {
  return (
    <div className="min-h-screen bg-white flex flex-col justify-end">
      <div className="flex justify-center">
        <a href="https://kevintraywick.com/fast-french" target="_blank" rel="noopener noreferrer">
          <img src={pastryImg} alt="Fast French" className="w-[500px] h-[500px] object-cover" />
        </a>
        <a href="sms:+12068608292">
          <img src={bubbleImg} alt="Text Me" className="w-[500px] h-[500px] object-cover" />
        </a>
        <a href="https://kevintraywick.com/justedit/justedit.html" target="_blank" rel="noopener noreferrer">
          <img src={penImg} alt="JustEdit" className="w-[500px] h-[500px] object-cover" />
        </a>
      </div>
    </div>
  )
}

export default App
