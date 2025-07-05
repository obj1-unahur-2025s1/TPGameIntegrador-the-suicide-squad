import src.utils.constants.*

/**
* Represents a text UI element with position, text content, and color.
*/
class UiText {
  /**
  * Position of the text element on the game board.
  */
  const property position

  /**
  * The string content of the text to display.
  */
  const text

  /**
  * The image to be displayed.
  */
  const property image = null 
  
  /**
  * The color of the text, defaulting to black.
  */
  const property textColor = constants.white()
  
  /**
  * Returns the evaluated text content.
  *
  * @return The current text string.
  */
  method text() = text.apply()
}