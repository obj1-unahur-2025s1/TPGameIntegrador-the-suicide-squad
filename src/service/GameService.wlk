import src.service.ScenarioService.*
import src.util.Logger.*
import src.util.logsList.*
import src.config.stateConfig.*
import src.config.appConfig.*
import src.service.InputService.*
import src.service.TickService.*
import src.model.Frog.*

class GameService {
  const frog = new Frog(
    startX = appConfig.initXPosition(),
    startY = appConfig.initYPosition()
  )
  const tickService = new TickService()
  const inputService = new InputService()
  const scenarioService = new ScenarioService()
  const logger = new Logger(callerName = "GameService")
  
  method frog() = frog
  
  method mainSetup() {
    inputService.bindControls(self, frog)
    inputService.bindRestartButton(self)
    self.roundSetup()
  }
  
  method roundSetup() {
    stateConfig.startRound()
    scenarioService.setUpRoundScenario(frog)
    tickService.setupTicks(self)
    game.say(frog, "Usa las flechas para jugar")
  }
  
  method tryMoveFrogTo(newPosition) {
    logger.message("Trying to move frog to " + newPosition)
    if (stateConfig.isInProgress()) frog.moveTo(newPosition)
  }
  
  method gameWon() {
    tickService.stopTicks()
    game.say(frog, "Ganaste! Pulsa una tecla para reiniciar")
    stateConfig.setIsGameOverScreenTrue()
  }
  
  method gameOver() {
    tickService.stopTicks()
    game.say(frog, "Perdiste! Pulsa una tecla para reiniciar")
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
            if (frog.isOutOfBounds(log.speed())) self.gameOver()
            else frog.moveTo(game.at(newFrogX, frog.position().y()))
          }
        }
      }
    )
  }
  
  method handleCheckFrog() {
    if (frog.reachedGoal()) {
      self.gameWon()
    } else {
      if ((frog.position().y() > 0) && (frog.position().y() < appConfig.initYPosition()))
        self.handleDangerZone()
    }
  }
  
  method handleDangerZone() {
    if (!logsList.logs().any({ log => log.position() == frog.position() }))
      self.gameOver()
  }
}