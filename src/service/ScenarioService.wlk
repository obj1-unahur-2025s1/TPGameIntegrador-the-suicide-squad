import src.ui.components.startButton.*
import src.ui.screens.gameStartScreen.*
import src.ui.screens.gameOverScreen.*
import src.ui.components.restartButton.*
import src.ui.screens.gameWonScreen.*
import src.config.setup.*
import src.util.logsList.*
import src.config.stateConfig.*
import src.util.Logger.*

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
    game.addVisual(frog)
    self.addLogs()
  }
  
  method setupGameWonScenario() {
    logger.message("Setting up game won scenario")
    self.removeAllVisuals()
    game.addVisual(gameWonScreen)
    game.addVisual(restartButton)
  }
  
  method setupGameOverScenario() {
    logger.message("Setting up game over scenario")
    self.removeAllVisuals()
    game.addVisual(gameOverScreen)
    game.addVisual(restartButton)
  }
  
  method setupGameStartScreen() {
    logger.message("Showing game start screen")
    self.removeAllVisuals()
    game.addVisual(gameStartScreen)
    game.addVisual(startButton)
  }
}