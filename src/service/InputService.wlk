import wollok.game.*
import src.model.KeyBinding.*

/**
* Service responsible for binding keyboard keys to game actions.
*/
class InputService {
  var keyMoves = []
  var commonProcessBindings = []
  const bindings = []
  
  /**
  * Binds all control actions (game start, movement, pause, etc.) to keys.
  * 
  * @param startGame Function to call when starting the game (Enter).
  * @param resetGame Function to call when resetting the game (R).
  * @param pauseGame Function to call when pausing the game (P).
  * @param resumeGame Function to call when resuming the game (Q).
  * @param moveUp Function to call when pressing the up arrow.
  * @param moveDown Function to call when pressing the down arrow.
  * @param moveLeft Function to call when pressing the left arrow.
  * @param moveRight Function to call when pressing the right arrow.
  */
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
  
  /**
  * Binds all prepared key bindings to the game.
  */
  method bindAll() {
    bindings.forEach({ binding => binding.bind() })
  }
  
  /**
  * Prepares the list of key bindings for movement and game control actions.
  * 
  * @param startGame Function for start action.
  * @param resetGame Function for reset action.
  * @param pauseGame Function for pause action.
  * @param resumeGame Function for resume action.
  * @param moveUp Function for upward movement.
  * @param moveDown Function for downward movement.
  * @param moveLeft Function for left movement.
  * @param moveRight Function for right movement.
  */
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