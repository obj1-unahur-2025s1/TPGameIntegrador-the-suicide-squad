import src.util.Logger.*
import src.config.stateConfig.*

class InputService {
  const logger = new Logger(callerName = "InputService")
  
  method bindControls(caller, frog) {
    keyboard.up().onPressDo({ caller.tryMoveFrogTo(frog.position().up(2)) })
    
    keyboard.down().onPressDo({ caller.tryMoveFrogTo(frog.position().down(2)) })
    
    keyboard.left().onPressDo({ caller.tryMoveFrogTo(frog.position().left(1)) })
    
    keyboard.right().onPressDo(
      { caller.tryMoveFrogTo(frog.position().right(1)) }
    )
  }
  
  method bindRestartButton(caller) {
    keyboard.any().onPressDo(
      { if (stateConfig.isGameOverScreen()) {
          logger.message("Restarting game")
          caller.resetGame()
        } }
    )
  }
}