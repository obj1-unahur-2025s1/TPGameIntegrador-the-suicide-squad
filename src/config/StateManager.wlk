import src.utils.constants.*

/**
* Manages the overall game state, including current level, frog position, game progress,
* and visual elements like logs. Provides methods to start a round and set game over state.
*/
class StateManager {
  const width = constants.gameWidth()
  const height = constants.gameHeight()
  const property frogInitXPosition = width / 2
  const property frogInitYPosition = height - 1
  var property currentLogsList = []
  var property gameInProgress = false
  var property gameOver = false
  var property currentLevel = 1
  
  /**
  * Starts a new round by marking the game as in progress and clearing the game over state.
  */
  method setGameOverScreen() {
    gameInProgress = false
    gameOver = true
  }
  
  /**
  * Sets the game state to game over and stops any ongoing gameplay.
  */
  method startRound() {
    gameInProgress = true
    gameOver = false
  }
}