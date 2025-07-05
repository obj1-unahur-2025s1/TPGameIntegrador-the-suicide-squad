import src.utils.constants.*
import src.model.Frog.* 
import wollok.game.*

/**
* Provides services related to the frog's state and movement,
* including checking if the frog reached the goal, movement validation,
* and danger zone detection.
*/
class FrogService {
  const stateManager

  const property frog = new Frog(
    startX = stateManager.frogInitXPosition(),
    startY = stateManager.frogInitYPosition()
  )
  
  /**
  * Evaluates the current game state based on the frog's position.
  * If the frog reaches the goal, triggers win condition.
  * If the frog is in a danger zone and not on a log, triggers lose condition.
  *
  * @param evaluateWon Function to invoke if the frog wins.
  * @param loseGame Function to invoke if the frog loses.
  */
  method checkFrog(evaluateWon, loseGame) {
    if (self.didFrogReachGoal()) {
      evaluateWon.apply()
    } else {
      if (self.isDangerZone() && (!self.isInLog())) loseGame.apply()
    }
  }
  
  /**
  * Checks if the frog has reached the goal.
  * 
  * @return true if the frog reached the goal; false otherwise.
  */
  method didFrogReachGoal() = frog.reachedGoal()
  
  /**
  * Moves the frog to a specified position if the move is valid.
  * 
  * @param pos The position to move the frog to.
  */
  method moveTo(pos) {
    if (self.canMoveTo(pos)) frog.position(pos)
  }
  
  /**
  * Resets the frog's position to the initial starting position.
  */
  method resetPosition() {
    frog.position(
      game.at(
        stateManager.frogInitXPosition(),
        stateManager.frogInitYPosition()
      )
    )
  }
  
  /**
  * Plays the frog's croack sound effect.
  */
  method croack() {
    const croack = game.sound(constants.croackSound())
    croack.play()
  }
  
  /**
  * Moves the frog one unit up if the game is in progress.
  */
  method moveUp() {
    if (stateManager.isGameInProgress()) {
      self.croack()
      self.moveTo(frog.position().up(2))
    }
  }
  
  /**
  * Moves the frog one unit down if the game is in progress.
  */
  method moveDown() {
    if (stateManager.isGameInProgress()) {
      self.croack()
      self.moveTo(frog.position().down(2))
    }
  }
  
  /**
  * Moves the frog one unit left if the game is in progress.
  */
  method moveLeft() {
    if (stateManager.isGameInProgress()) {
      self.croack()
      self.moveTo(frog.position().left(2))
    }
  }
  
  /**
  * Moves the frog one unit right if the game is in progress.
  */
  method moveRight() {
    if (stateManager.isGameInProgress()) {
      self.croack()
      self.moveTo(frog.position().right(2))
    }
  }
  
  /**
  * Checks if the frog is currently in a danger zone (between start and goal rows).
  * 
  * @return true if the frog is in a danger zone; false otherwise.
  */
  method isDangerZone() = (frog.position().y() > 0) && (frog.position().y() < stateManager.frogInitYPosition())
  
  /**
  * Checks if the frog is currently positioned on any log.
  * 
  * @return true if the frog is on a log; false otherwise.
  */
  method isInLog() = stateManager.currentLogsList().any(
    { log => log.position() == frog.position() }
  )
  
  /**
  * Checks if the frog can move to a given position,
  * considering if the game is in progress and position bounds.
  * 
  * @param pos The position to validate.
  * @return true if the move is valid; false otherwise.
  */
  method canMoveTo(
    pos
  ) = stateManager.isGameInProgress() && self.isWithinBounds(pos)
  
  /**
  * Checks if a position is within the horizontal and vertical bounds of the game area.
  * 
  * @param pos The position to check.
  * @return true if the position is within bounds; false otherwise.
  */
  method isWithinBounds(pos) = self.isInsideHorizontalBounds(
    pos
  ) && self.isInsideVerticalBounds(pos)
  
  /**
  * Checks if a position is within the horizontal bounds of the game.
  * 
  * @param pos The position to check.
  * @return true if the X coordinate is within bounds; false otherwise.
  */
  method isInsideHorizontalBounds(
    pos
  ) = (pos.x() >= 0) && (pos.x() < game.width())
  
  /**
  * Checks if a position is within the vertical bounds of the game.
  * 
  * @param pos The position to check.
  * @return true if the Y coordinate is within bounds; false otherwise.
  */
  method isInsideVerticalBounds(
    pos
  ) = (pos.y() >= 0) && (pos.y() < game.height())
}