import src.service.ScenarioService.*
import src.util.Logger.*
import src.ui.screens.gameWonScreen.*
import src.ui.components.restartButton.*
import src.ui.screens.gameOverScreen.*
import src.ui.components.startButton.*
import src.ui.screens.gameStartScreen.*
import src.util.logsList.*
import src.config.stateConfig.*
import src.service.InputService.*
import src.service.TickService.*
import src.model.Frog.*

class GameService {
  const frog = new Frog(startX = 5, startY = 9)
  const tickService = new TickService()
  const inputService = new InputService()
  const scenarioService = new ScenarioService()
  const logger = new Logger(callerName = "GameService")
  
  method frog() = frog
  
  method mainSetup() {
    inputService.bindControls(self, frog)
    inputService.bindRestartButton(self)
    inputService.bindStartButton(self)
    self.gameSetup()
    keyboard.n().onPressDo({ logger.message("Tecla UP presionada") })
  }
  
  method gameSetup() {
    self.showGameStartScreen()
  }
  
  method roundSetup() {
    stateConfig.startRound()
    scenarioService.setUpRoundScenario(frog)
    tickService.setupTicks(self)
  }
  
  method tryMoveFrogTo(newPosition) {
    logger.message("Trying to move frog to " + newPosition)
    if (stateConfig.isInProgress()) frog.moveTo(newPosition)
  }
  
  method onFrogWin() {
    game.say(frog, "Safe!")
    self.gameWon()
  }
  
  method onFrogDrown() {
    game.say(frog, "The frog drowned!")
    self.gameOver()
  }
  
  method gameWon() {
    tickService.stopTicks()
    game.schedule(2000, { self.showGameWonScreen() })
  }
  
  method gameOver() {
    tickService.stopTicks()
    game.schedule(2000, { self.showGameOverScreen() })
  }
  
  method showGameStartScreen() {
    scenarioService.setupGameStartScreen()
    stateConfig.setIsStartScreenTrue()
  }
  
  method showGameOverScreen() {
    scenarioService.setupGameOverScenario()
    stateConfig.setIsGameOverScreenTrue()
  }
  
  method showGameWonScreen() {
    scenarioService.setupGameWonScenario()
    stateConfig.setIsGameOverScreenTrue()
  }
  
  method resetGame() {
    frog.resetPosition()
    self.roundSetup()
  }
  
  method handleMoveLogs() {
    logsList.logs().forEach(
      { log =>
        const frogIsOnLog = log.position() == frog.position()
        const reset = log.moveAndCheckReset()
        
        if (frogIsOnLog) {
          if (reset) {
            self.gameOver()
          } else {
            const newFrogX = frog.calculateNextFrogX(log.speed())
            if ((newFrogX < 0) || (newFrogX >= game.width())) self.gameOver()
            else frog.moveTo(game.at(newFrogX, frog.position().y()))
          }
        }
      }
    )
  }
  
  method handleCheckFrog() {
    if (frog.position().y() == 0) {
      self.gameWon()
    } else {
      if ((frog.position().y() > 0) && (frog.position().y() < 9))
        self.handleDangerZone()
    }
  }
  
  method handleDangerZone() {
    if (!logsList.logs().any({ log => log.position() == frog.position() }))
      self.gameOver()
  }
}