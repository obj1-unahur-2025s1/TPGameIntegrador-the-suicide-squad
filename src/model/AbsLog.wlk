/**
* Abstract class representing a moving log in the game.
* Handles positioning, movement, and reset behavior when reaching screen edges.
*/
class AbsLog {
  const property id
  const startX = 0
  const row = 0
  const property sound = null
  const property speed = 1
  var property position = game.at(startX, row)
  
  /**
  * Moves the log horizontally according to its speed.
  * If it goes off the screen, its position is reset to the opposite side.
  * 
  * @return true if the log was reset to the opposite side; false otherwise.
  */
  method moveAndCheckReset() {
    var newX = position.x() + speed
    var didReset = false
    
    if (newX >= game.width()) {
      newX = 0
      didReset = true
    } else {
      if (newX < 0) {
        newX = game.width() - 1
        didReset = true
      }
    }
    
    position = game.at(newX, row)
    return didReset
  }
  
  /**
  * Resets the log position to its starting X coordinate on the same row.
  */
  method resetPosition() {
    position = game.at(startX, row)
  }
  
  /**
  * Returns the image of the log.
  * This method is abstract and should be implemented by subclasses.
  */
  method image()
  
  /**
  * Returns the current position of the log.
  * 
  * @return The current game position of the log.
  */
  method position() = position
}