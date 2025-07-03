import src.service.LevelService.*
import src.service.ScenarioService.*
import src.service.FrogService.*
import src.config.StateManager.*
import src.model.Frog.*
import src.service.InputService.*
import src.service.TickService.*

/**
 * Main service that manages the game lifecycle, including initialization,
 * rounds, game state, player input, and interactions between entities.
 */
class GameService {
  const stateManager = new StateManager()
  const tickService = new TickService()
  const inputService = new InputService(stateManager = stateManager)

  const frog = new Frog(
    startX = stateManager.frogInitXPosition(),
    startY = stateManager.frogInitYPosition()
  )

  const frogService = new FrogService(stateManager = stateManager, frog = frog)
  const scenarioService = new ScenarioService(stateManager = stateManager)
  const levelService = new LevelService(stateManager = stateManager)

  /**
   * Initializes the game by binding input controls, setting up ticks,
   * initializing scenario, and setting up the first round.
   */
  method initialize() {
    inputService.bindControls(self, frog)
    tickService.setupTicks(
      { self.handleCheckFrog() },
      { self.handleMoveLogs() }
    )
    scenarioService.initialize()
    self.roundSetup()
  }

  /**
   * Sets up a new round by starting the game, rendering the stage,
   * and playing the game ticks.
   */
  method roundSetup() {
    stateManager.startRound()
    scenarioService.renderStage(frog)
    tickService.playTicks()
  }

  /**
   * Handles the situation when the player wins the game.
   * Stops ticks, sets game over screen, handles level progression,
   * and schedules the next round.
   */
  method gameWon() {
    tickService.stopTicks()
    stateManager.setGameOverScreen()

    if (levelService.currentLevel() < levelService.maxLevel()) {
      self.wonAndNextLevel()
    } else {
      levelService.resetLevel()
      scenarioService.showGameWonMessage(frog)
    }

    game.schedule(1000, { self.roundSetup() })
  }

  /**
   * Shows a partial win message and advances to the next level.
   */
  method wonAndNextLevel() {
    scenarioService.partiallyWonMessage(frog)
    levelService.nextLevel()
  }

  /**
   * Handles the game over state, stopping ticks, showing game over message,
   * and scheduling a new round.
   */
  method gameOver() {
    tickService.stopTicks()
    stateManager.setGameOverScreen()
    scenarioService.showGameOverMessage(frog)
    game.schedule(1000, { self.roundSetup() })
  }

  /**
   * Attempts to move the frog to a new position if the game is in progress.
   * 
   * @param newPosition The new position to move the frog to.
   */
  method tryMoveFrogTo(newPosition) {
    if (stateManager.gameInProgress()) frogService.moveTo(newPosition)
  }

  /**
   * Handles the movement logic of logs during the game ticks.
   */
  method handleMoveLogs() {
    scenarioService.handleMoveLogs(self, frog)
  }

  /**
   * Checks the current status of the frog to determine if the player won
   * or lost, triggering the appropriate game state changes.
   */
  method handleCheckFrog() {
    if (frogService.didFrogReachGoal()) {
      self.gameWon()
    } else {
      if (frogService.isDangerZone() && (!frogService.isInLog()))
        self.gameOver()
    }
  }

  /**
   * Restarts the common game process (ticks) if the game is in progress
   * and the ticks are not currently running.
   */
  method restartCommonProcessIfNeeded() {
    if (stateManager.gameInProgress() && (!tickService.areTicksRunning()))
      tickService.playTicks()
  }
}
