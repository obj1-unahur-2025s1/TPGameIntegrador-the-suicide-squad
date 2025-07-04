// src/service/InputService.wlk
// src/service/InputService.wlk
// src/service/InputService.wlk
// src/service/InputService.wlk
// src/service/InputService.wlk
// src/service/InputService.wlk
// src/service/InputService.wlk
import wollok.game.*
import src.model.KeyBinding.*

class InputService {
  var keyMoves = []
  var commonProcessBindings = []
  const bindings = []
  
  method bindControls(
    startGame,
    resetGame,
    pauseGame,
    resumeGame,
    moveUp,
    moveDown,
    moveLeft,
    moveRight
  ) {
    self.prepareBindings(
      startGame,
      resetGame,
      pauseGame,
      resumeGame,
      moveUp,
      moveDown,
      moveLeft,
      moveRight
    )
    self.bindAll()
  }
  
  method bindAll() {
    bindings.forEach({ binding => binding.bind() })
  }
  
  method prepareBindings(
    startGame,
    resetGame,
    pauseGame,
    resumeGame,
    moveUp,
    moveDown,
    moveLeft,
    moveRight
  ) {
    keyMoves = [
      new KeyBinding(key = keyboard.up(), action = moveUp),
      new KeyBinding(key = keyboard.down(), action = moveDown),
      new KeyBinding(key = keyboard.left(), action = moveLeft),
      new KeyBinding(key = keyboard.right(), action = moveRight)
    ]
    
    commonProcessBindings = [
      new KeyBinding(key = keyboard.enter(), action = startGame),
      new KeyBinding(key = keyboard.r(), action = resetGame),
      new KeyBinding(key = keyboard.q(), action = resumeGame),
      new KeyBinding(key = keyboard.p(), action = pauseGame)
    ]
    
    bindings.addAll(keyMoves)
    bindings.addAll(commonProcessBindings)
  }
}