import src.config.StateManager.*
import src.utils.StageFactory.*
import wollok.game.*
import src.utils.constants.*

/**
 * Service to manage the current level progression and resetting levels.
 */
class LevelService {
  var property currentLevel = 1
  const property maxLevel = constants.maxLevel()
  const stateManager

  /**
   * Advances to the next level and updates the state manager accordingly.
   */
  method nextLevel() {
    currentLevel += 1
    stateManager.currentLevel(currentLevel)
  }

  /**
   * Resets the level back to the first one and updates the state manager.
   */
  method resetLevel() {
    currentLevel = 1
    stateManager.currentLevel(currentLevel)
  }
}
