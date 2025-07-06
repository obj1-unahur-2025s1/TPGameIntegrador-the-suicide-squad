import src.utils.constants.*
import src.utils.Logger.*
import src.service.ScenarioService.*
import src.service.FrogService.*
import src.config.StateManager.*
import src.model.Frog.*
import src.service.InputService.*
import src.service.TickService.*

/**
* Orchestrates the game flow, including initialization, input binding,
* game state transitions, level logic, and win/loss handling.
*/
class GameService {
  const stateManager = new StateManager()
  const tickService = new TickService()
  const inputService = new InputService()
  const frogService = new FrogService(stateManager = stateManager)
  const scenarioService = new ScenarioService(stateManager = stateManager)
  const logger = new Logger(name = "GameService")
  const frog = frogService.frog()
  
  // --- Game Initialization ---
  /**
  * Sets up input bindings, tick handlers, and initializes the scenario.
  */
  method initialize() {
    scenarioService.manualInitialize()

    inputService.bindControls(
      { self.startGame() },
      { self.resetGame() },
      { self.pauseGame() },
      { self.resumeGame() },
      { frogService.moveUp() },
      { frogService.moveDown() },
      { frogService.moveLeft() },
      { frogService.moveRight() }
    )
    
    tickService.setupTicks(
      { self.handleCheckFrog() },
      { self.handleMoveLogs() }
    )

    logger.print("Initialized.")  
  }
  
  /**
  * Performs manual initialization: resets scenario and logs message.
  */
  method manualInitialize() {
    scenarioService.manualInitialize()
    logger.print("Initialized.")
  }
  
  // --- Game Control ---
  /**
  * Starts the game if currently on the welcome screen.
  */
  method startGame() {
    logger.print("startGame called.")
    if (stateManager.isStartScreen()) {
      stateManager.startGame()
      scenarioService.renderStage(frog)
      tickService.playTicks()
    } else {
      logger.print("Could not start game.")
    }
  }
  
  /**
  * Continues the current or next level based on game state.
  *
  * @param repeatSameLevel Whether to repeat the current level (true) or go to next (false).
  */
  method continueLevel(repeatSameLevel) {
    logger.print("continueLevel called.")
    if (stateManager.isGameInProgress()) {
      scenarioService.renderLevel(frog, repeatSameLevel)
      tickService.playTicks()
    } else {
      logger.print("Game is not in progress, cannot continue to next level.")
    }
  }
  
  /**
  * Resets the game and reinitializes the scenario.
  */
  method resetGame() {
    logger.print("resetGame called.")
    scenarioService.resetScenario()
    self.manualInitialize()
  }
  
  /**
  * Pauses the game if it's in progress.
  */
  method pauseGame() {
    if (stateManager.isGameInProgress()) {
      logger.print("Game is in progress, pausing...")
      stateManager.pauseGame()
      scenarioService.renderPauseScreen()
      tickService.stopTicks()
    } else {
      logger.print("Game is not in progress, cannot pause.")
    }
  }
  
  /**
  * Resumes the game if it's currently paused.
  */
  method resumeGame() {
    if (stateManager.isGamePaused()) {
      logger.print("Resuming game...")
      stateManager.resumeGame()
      scenarioService.quitPauseScreen()
      tickService.playTicks()
    } else {
      logger.print("Game is not paused, cannot resume.")
    }
  }
  
  // --- Evaluación de estado de juego (ganar/perder) ---
  /**
  * Handles win state: sets final game state, shows win screen, and stops ticks.
  */
  method wonGame() {
    stateManager.wonGame()
    scenarioService.renderGameWonScreen()
    tickService.stopTicks()
    logger.print("Game won!")
  }
  
  /**
  * Handles lose state: sets final game state, shows lose screen, and stops ticks.
  */
  method loseGame() {
    stateManager.loseGame()
    tickService.stopTicks()
    scenarioService.renderGameLoseScreen()
    logger.print("Game lost!")
  }
  
  /**
  * Determines if the game should proceed after losing a life or fully lose.
  */
  method evaluateLose() {
    if (!constants.alwaysWin()) {
      logger.print("Evaluating if the frog has lost...")
      tickService.stopTicks()
      
      if (stateManager.currentLives() > 1) {
        logger.print("Frog has lost a life, resetting level...")
        stateManager.subtractLife()
        self.continueLevel(true)
      } else {
        logger.print("Frog has no lives left, game over.")
        self.loseGame()
      }
    } else {
      logger.print("Always win mode is enabled, skipping lose evaluation.")
    }
  }
  
  /**
  * Determines if the frog has won the level or the entire game.
  */
  method evaluateWon() {
    logger.print("Evaluating if the frog has won...")
    tickService.stopTicks()
    
    if (stateManager.currentLevel() < stateManager.maxLevel()) {
      logger.print("Frog has won the level, proceeding to next level...")
      stateManager.nextLevel()
      self.continueLevel(false)
    } else {
      self.wonGame()
    }
  }
  
  // --- Movement and Interaction ---
  /**
  * Moves the frog to a new position if the game is in progress.
  *
  * @param newPosition The position to move the frog to.
  */
  method moveFrogTo(newPosition) {
    if (stateManager.isGameInProgress()) frogService.moveTo(newPosition)
  }
  
  /**
  * Called on tick: handles log movement and frog interaction with logs.
  */
  method handleMoveLogs() {
    scenarioService.handleMoveLogs(
      { newPosition => self.moveFrogTo(newPosition) },
      { self.evaluateLose() },
      frog
    )
  }
  
  /**
  * Called on tick: evaluates if the frog has reached the goal or died.
  */
  method handleCheckFrog() {
    frogService.checkFrog({ self.evaluateWon() }, { self.evaluateLose() })
  }
}