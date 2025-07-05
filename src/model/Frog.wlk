import wollok.game.*
import src.utils.constants.*

/**
* Represents the player-controlled frog in the game.
* Tracks position, movement, and state.
*/
class Frog {
  const startX = 0
  const startY = 0
  var property position = game.at(startX, startY)
  var property lastLogId = null 

  /**
  * Determines if the frog's next horizontal move would take it out of the game bounds.
  * 
  * @param logSpeed The speed of the log the frog is on.
  * @return true if the next position is out of bounds; false otherwise.
  */
  method isOutOfBounds(logSpeed) = (self.nextXPosition(
    logSpeed
  ) < 0) || (self.nextXPosition(logSpeed) >= game.width())
  
  /**
  * Returns the image used to represent the frog.
  * 
  * @return The frog image path or identifier.
  */
  method image() = constants.frogImage()
  
  /**
  * Resets the frog's position to its initial coordinates.
  */
  method resetPosition() {
    position = game.at(startX, startY)
  }
  
  /**
  * Checks whether the frog has reached the goal line (bottom of the screen).
  * 
  * @return true if the frog is on the bottom row; false otherwise.
  */
  method reachedGoal() = position.y() == 0
  
  /**
  * Calculates the frog's next X position based on log speed.
  * 
  * @param logSpeed The speed of the log the frog is on.
  * @return The next X coordinate of the frog.
  */
  method nextXPosition(logSpeed) = position.x() + logSpeed
}