import wollok.game.*

/**
* Represents a full-screen visual component, such as a welcome,
* pause, win or lose screen.
*/
class UiScreen {
  /**
  * The image to be displayed for the screen.
  */
  const property image
  
  /**
  * Returns the position where the screen should be rendered.
  * This always points to the game origin (top-left corner).
  *
  * @return The origin position of the screen.
  */
  method position() = game.origin()
}