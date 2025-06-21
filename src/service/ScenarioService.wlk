import src.ui.components.startButton.*
import src.ui.screens.gameStartScreen.*
import src.ui.screens.gameOverScreen.*
import src.ui.components.restartButton.*
import src.ui.screens.gameWonScreen.*
import src.config.setup.*
import src.util.logsList.*
import src.config.stateConfig.*
import src.util.Logger.*
import wollok.game.*

class ScenarioService {
  const logger = new Logger(callerName = "ScenarioService")
  
  method removeAllVisuals() {
    const allVisuals = game.allVisuals()
    allVisuals.forEach({ visual => game.removeVisual(visual) })
    logger.message("All visuals removed")
  }
  
  method addLogs() {
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