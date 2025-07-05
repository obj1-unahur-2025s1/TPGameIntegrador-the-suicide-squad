import src.service.GameService.*
import src.utils.constants.*

/**
* Handles the initial setup of the game, including window configuration, title, 
* background sound, and instantiation of the main GameService.
*/
object setup {
  const width = constants.gameWidth()
  const height = constants.gameHeight()
  const cellSize = constants.gameCellSize()
  var currentTitle = constants.gameTitle()
  
  /**
  * Initializes the game setup, including screen dimensions, title, river sound, and main game service.
  */
  method initializeSetup() {
    game.width(width)
    game.height(height)
    game.cellSize(cellSize)
    self.setTitle(currentTitle)
    new GameService()
  }
  
  /**
  * Sets the title of the game window and updates the current title variable.
  * 
  * @param title The title to be set for the game window.
  */
  method setTitle(title) {
    currentTitle = title
    game.title(title)
  }
}