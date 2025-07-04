// src/config/StateManager.wlk
// src/config/StateManager.wlk
// src/config/StateManager.wlk
// src/config/StateManager.wlk
// src/config/StateManager.wlk
// src/config/StateManager.wlk
// src/config/StateManager.wlk
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
  var property isInProgress = false
  var property isStartScreen = true //nuevos
  var property currentLevel = 1
  const property maxLevel = 3
  var property isPaused = false //nuevos
  var property gameWon = false //nuevos
  var property gameLose = false //nuevos
  var property river = null 
  const property lives = 3 
  var property currentLives = lives //nuevos
  
method printState() {
    console.println("Game State:")
    console.println("  In Progress: " + isInProgress)
    console.println("  Start Screen: " + isStartScreen)
    console.println("  Current Level: " + currentLevel)
    console.println("  Paused: " + isPaused)
    console.println("  Game Won: " + gameWon)
    console.println("  Game Lose: " + gameLose)
  }

  method isGameInProgress() {
    return isInProgress && !isPaused && !gameWon && !gameLose && !isStartScreen
  }

  method isGamePaused() {
    return isPaused && !isInProgress && !gameWon && !gameLose && !isStartScreen
  }

  method pauseGame() {
    isInProgress = false
    isPaused = true
  }
  
  method resumeGame() {
    isInProgress = true
    isPaused = false
  }
  
  method loseGame() {
    isInProgress = false
    gameLose = true
  }
  
  method wonGame() {
    isInProgress = false
    gameWon = true
  }
  
  method startGame() {
    self.resetGameState()
    isInProgress = true
    isStartScreen = false
  }
  
  method resetGame() {
    self.resetGameState()
  }
  
  method resetGameState() {
    isInProgress = false
    isStartScreen = true
    isPaused = false
    gameWon = false
    gameLose = false
    currentLevel = 1
    currentLogsList = []
    currentLives = lives
  }
  
  method nextLevel() {
    currentLevel += 1
  }
  
  method resetLevel() {
    currentLevel = 1
  }

  method subtractLife() {
    if (currentLives > 0) {
      currentLives -= 1
    }
  }
}