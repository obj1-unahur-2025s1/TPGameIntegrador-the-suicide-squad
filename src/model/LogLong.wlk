import src.model.AbsLog.*
import src.utils.constants.*

/**
* Represents a long log in the game.
* Inherits behavior from AbsLog and defines its specific image.
*/
class LogLong inherits AbsLog {
  const property points = 70

  /**
  * Returns the image used to represent the long log.
  * 
  * @return The image path or identifier for the long log.
  */
  override method image() = constants.logLongImage()
}