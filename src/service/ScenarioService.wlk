import src.config.setup.*
import src.util.logsList.*
import src.config.stateConfig.*
import src.util.Logger.*
import wollok.game.*

class ScenarioService {
  const logger = new Logger(callerName = "ScenarioService")
  
  method removeAllVisuals() {
    logger.message("Removing all visuals from the game")
    const allVisuals = game.allVisuals()
    allVisuals.forEach({ visual => game.removeVisual(visual) })
  }
  
  method addLogs() {
    logger.message("Adding logs to the game")
    logsList.logs().forEach(
      { log =>
        log.resetPosition()
        return game.addVisual(log)
      }
    )
  }
  
  method setUpRoundScenario(frog) {
    logger.message("Setting up game scenario")
    self.removeAllVisuals()
    self.addLogs()
    game.addVisual(frog)
  }
}