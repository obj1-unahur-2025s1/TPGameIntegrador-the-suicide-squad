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

  var property currentLevel = 1
  const property maxLevel = 3

  var property isInProgress = false
  var property isStartScreen = true
  var property isPaused = false

  var property gameWon = false
  var property gameLose = false

  const property lives = 3
  var property currentLives = lives

  var property points = 0

  var property river = null

  var property ambientMusic = null
  
  /**
  * Checks if the game is currently in progress (not paused, not won/lost, and not at start screen).
  * 
  * @return true if the game is in progress; false otherwise.
  */
  method isGameInProgress() = (((isInProgress && (!isPaused)) && (!gameWon)) && (!gameLose)) && (!isStartScreen)
  
  /**
  * Checks if the game is currently paused (not in progress, not won/lost, and not at start screen).
  * 
  * @return true if the game is paused; false otherwise.
  */
  method isGamePaused() = (((isPaused && (!isInProgress)) && (!gameWon)) && (!gameLose)) && (!isStartScreen)
  
  /**
  * Pauses the game, setting inProgress false and paused true.
  */
  method pauseGame() {
    isInProgress = false
    isPaused = true
  }
  
  /**
  * Resumes the game, setting inProgress true and paused false.
  */
  method resumeGame() {
    isInProgress = true
    isPaused = false
  }
  
  /**
  * Marks the game as lost and stops game progress.
  */
  method loseGame() {
    isInProgress = false
    gameLose = true
  }
  
  /**
  * Marks the game as won and stops game progress.
  */
  method wonGame() {
    isInProgress = false
    gameWon = true
  }
  
  /**
  * Starts a new game by resetting state and setting inProgress true.
  */
  method startGame() {
    self.resetGameState()
    isInProgress = true
    isStartScreen = false
  }
  
  /**
  * Resets the entire game state to the initial values.
  */
  method resetGame() {
    self.resetGameState()
  }
  
  /**
  * Resets all game state flags, level, logs, and lives.
  */
  method resetGameState() {
    isInProgress = false
    isStartScreen = true
    isPaused = false
    gameWon = false
    gameLose = false
    currentLevel = 1
    currentLogsList = []
    currentLives = lives
    points = 0
  }
  
  /**
  * Advances the current level by one.
  */
  method nextLevel() {
    currentLevel += 1
  }
  
  /**
  * Resets the current level to the first level.
  */
  method resetLevel() {
    currentLevel = 1
  }
  
  /**
  * Subtracts one life from current lives, ensuring it does not go below zero.
  */
  method subtractLife() {
    if (currentLives > 0) {
      currentLives -= 1
    }
  }

  /**
  * Increments the points by a specified amount.
  * @param pointsToAdd The number of points to add to the current score.
  */
  method incrementPoints(pointsToAdd) {
    points += pointsToAdd
  }
}