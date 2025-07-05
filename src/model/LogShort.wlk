import src.model.AbsLog.*
import src.utils.constants.* 

/**
* Represents a short log in the game.
* Inherits behavior from AbsLog and defines its specific image.
*/
class LogShort inherits AbsLog {
  const property points = 140
  
  /**
  * Returns the image used to represent the short log.
  * 
  * @return The image path or identifier for the short log.
  */
  override method image() = constants.logShortImage()
}