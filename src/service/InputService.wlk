import src.config.stateConfig.*

class InputService {
  method bindControls(caller, frog) {
    keyboard.up().onPressDo({ caller.tryMoveFrogTo(frog.position().up(2)) })
    
    keyboard.down().onPressDo({ caller.tryMoveFrogTo(frog.position().down(2)) })
    
    keyboard.left().onPressDo({ caller.tryMoveFrogTo(frog.position().left(1)) })
    
    keyboard.right().onPressDo(
      { caller.tryMoveFrogTo(frog.position().right(1)) }
    )
//    keyboard.space().onPressDo(
//    { if (caller.waitingForNextLevel) caller.continueToNextLevel() }
//  )
  }
  
  method bindCommonProcessRestart(caller) {
    keyboard.any().onPressDo({ caller.restartCommonProcessIfNeeded() })
  }
  
  method bindRestartButton(caller) {
    keyboard.r().onPressDo(
      { if (stateConfig.isGameOverScreen()) caller.resetGame() }
    )
  }

}