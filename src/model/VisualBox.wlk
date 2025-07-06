/**
* Represents a visual component in the game that displays an image 
* based on a dynamic key (e.g. current lives or level).
*/
class VisualBox {
  /**
  * Default image to be used if no key matches in the dictionary.
  */
  const image = null 
  
  /**
  * A function that returns the current key used to select the image.
  */
  const property currentKey = null 
  
  /**
  * The position where the visual element should appear on the game board.
  */
  const property position
  
  /**
  * A dictionary mapping keys to their corresponding images.
  */
  const property imageDic = new Dictionary()
  
  /**
  * Evaluates and returns the current key using the `currentKey` function.
  *
  * @return The current dynamic key.
  */
  method currentKey() = currentKey.apply()
  
  /**
  * Returns the image corresponding to the current key.
  * If the key is not found in the dictionary, returns the default image.
  *
  * @return The image to be displayed.
  */
  method image() = imageDic.getOrElse(currentKey.apply(), { image })
}