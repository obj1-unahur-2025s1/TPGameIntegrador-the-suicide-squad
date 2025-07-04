// src/service/RoundService.wlk
// src/service/RoundService.wlk
class RoundService {
    const stateManager
  const tickService
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

}