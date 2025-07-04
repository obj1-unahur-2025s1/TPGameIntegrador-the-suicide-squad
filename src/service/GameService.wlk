// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
// src/service/GameService.wlk
import src.utils.Logger.*
import src.service.ScenarioService.*
import src.service.FrogService.*
import src.config.StateManager.*
import src.model.Frog.*
import src.service.InputService.*
import src.service.TickService.*

class GameService {
  const stateManager = new StateManager()
  const tickService = new TickService()
  const inputService = new InputService()
  const frogService = new FrogService(stateManager = stateManager)
  const scenarioService = new ScenarioService(stateManager = stateManager)
  const logger = new Logger(name = "GameService")
  const frog = frogService.frog()
  
  method initialize() {
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
    self.manualInitialize()
  }
  
  method manualInitialize() {
    scenarioService.manualInitialize()
    logger.print("Initialized.")
  }
  
  method startGame() {
    logger.print("startGame called.")
    if (stateManager.isStartScreen()) {
      stateManager.startGame()
      scenarioService.playBackgroundSound()
      scenarioService.renderStage(frog)
      tickService.playTicks()
    } else {
      logger.print("Could not start game.")
    }
  }
  
  method continueLevel() {
    logger.print("continueLevel called.")
    if (stateManager.isGameInProgress()) {
      scenarioService.renderStage(frog)
      tickService.playTicks()
    } else {
      logger.print("Game is not in progress, cannot continue to next level.")
    }
  }
  
  method resetGame() {
    logger.print("resetGame called.")
    scenarioService.resetScenario()
    self.manualInitialize()
  }
  
  method pauseGame() {
    if (stateManager.isGameInProgress()) {
      logger.print("Game is in progress, pausing...")
      stateManager.pauseGame()
      scenarioService.pauseBackgroundSound()
      scenarioService.renderPauseScreen()
      tickService.stopTicks()
    } else {
      logger.print("Game is not in progress, cannot pause.")
    }
  }
  
  method resumeGame() {
    if (stateManager.isGamePaused()) {
      logger.print("Resuming game...")
      stateManager.resumeGame()
      scenarioService.resumeBackgroundSound()
      scenarioService.quitPauseScreen()
      tickService.playTicks()
    } else {
      logger.print("Game is not paused, cannot resume.")
    }
  }
  
  method wonGame() {
    stateManager.wonGame()
    scenarioService.renderGameWonScreen()
    tickService.stopTicks()
    logger.print("Game won!")
  }
  
  method loseGame() {
    stateManager.loseGame()
    tickService.stopTicks()
    scenarioService.renderGameLoseScreen()
    logger.print("Game lost!")
  }
  
  method evaluateLose() {
    logger.print("Evaluating if the frog has lost...")
    tickService.stopTicks()
    
    if (stateManager.currentLives() > 1) {
      logger.print("Frog has lost a life, resetting level...")
      stateManager.subtractLife()
      self.continueLevel()
    } else {
      logger.print("Frog has no lives left, game over.")
      self.loseGame()
    }
  }
  
  method evaluateWon() {
    logger.print("Evaluating if the frog has won...")
    tickService.stopTicks()
    
    if (stateManager.currentLevel() < stateManager.maxLevel()) {
      logger.print("Frog has won the level, proceeding to next level...")
      stateManager.nextLevel()
      self.continueLevel()
    } else {
      stateManager.resetLevel()
      scenarioService.showGameWonMessage(frog)
      self.wonGame()
    }
  }
  
  method moveFrogTo(newPosition) {
    if (stateManager.isGameInProgress()) frogService.moveTo(newPosition)
  }
  
  method handleMoveLogs() {
    scenarioService.handleMoveLogs(
      { newPosition => self.moveFrogTo(newPosition) },
      { self.evaluateLose() },
      frog
    )
  }
  
  method handleCheckFrog() {
    frogService.checkFrog({ self.evaluateWon() }, { self.evaluateLose() })
  }
}