import src.config.StateManager.*
import src.utils.StageFactory.*
import wollok.game.*
import src.utils.constants.*

/**
 * Manages the game scenario including rendering of stages, logs, and frog,
 * as well as handling log movement and collision detection.
 */
class ScenarioService {
  const stateManager
  var currentLogsList = []
  const stageFactory = new StageFactory()

  /**
   * Initializes the game board background.
   */
  method initialize() {
    game.boardGround(constants.boardGround())
  }

  /**
   * Renders the entire stage including visuals, logs, and frog.
   * 
   * @param frog The frog entity to render.
   */
  method renderStage(frog) {
    self.removeAllVisuals()
    self.updateLogsList()
    self.renderLogs()
    self.renderFrog(frog)
  }

  /**
   * Updates the current list of logs for the current level.
   */
  method updateLogsList() {
    currentLogsList = stageFactory.allStages().find(
      { stage => stage.level() == stateManager.currentLevel() }
    ).logList()
    stateManager.currentLogsList(currentLogsList)
  }

  /**
   * Renders all logs visually on the game board.
   */
  method renderLogs() {
    currentLogsList.forEach({ log => game.addVisual(log) })
  }

  /**
   * Resets the frog's position, adds it visually, and shows an initial message.
   * 
   * @param frog The frog entity to render.
   */
  method renderFrog(frog) {
    frog.resetPosition()
    game.addVisual(frog)
    game.say(frog, constants.useArrowsMessage())
  }

  /**
   * Removes all visual elements currently displayed on the game board.
   */
  method removeAllVisuals() {
    game.allVisuals().forEach({ visual => game.removeVisual(visual) })
  }

  /**
   * Handles movement of logs and collision logic with the frog during game ticks.
   * 
   * @param caller The caller object (usually GameService) to trigger game state changes.
   * @param frog The frog entity involved in the interactions.
   */
  method handleMoveLogs(caller, frog) {
    currentLogsList.forEach(
      { log =>
        const frogIsOnLog = log.position() == frog.position()
        const logReset = log.moveAndCheckReset()

        if (!frogIsOnLog) {
          return
        }

        if (logReset || frog.isOutOfBounds(log.speed())) {
          caller.gameOver()
          return
        }

        const newFrogX = frog.nextXPosition(log.speed())
        const newFrogPos = game.at(newFrogX, frog.position().y())
        return caller.tryMoveFrogTo(newFrogPos)
      }
    )
  }

  /**
   * Shows the game won message to the player.
   * 
   * @param frog The frog entity to display the message near.
   */
  method showGameWonMessage(frog) {
    game.say(frog, constants.gameWonMessage())
  }

  /**
   * Shows a partial win message indicating the current level won.
   * 
   * @param frog The frog entity to display the message near.
   */
  method partiallyWonMessage(frog) {
    game.say(frog, ("¡Ganaste el nivel " + stateManager.currentLevel()) + "!")
  }

  /**
   * Shows the game over message to the player.
   * 
   * @param frog The frog entity to display the message near.
   */
  method showGameOverMessage(frog) {
    game.say(frog, constants.gameLostMessage())
  }
}
