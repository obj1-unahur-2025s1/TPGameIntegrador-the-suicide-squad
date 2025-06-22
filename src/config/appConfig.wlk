import src.config.stateConfig.*

object appConfig {
  const width = 20
  const height = 9
  const cellSize = 80
  var currentTitle = "Frogger: Cross the river"
  
  method initialize() {
    game.width(width)
    game.height(height)
    game.cellSize(cellSize)
    self.setTitle(currentTitle)
    game.boardGround("bg-river.png")
    self.initializeRiver()
  }
  
  method initializeRiver() {
    const river = game.sound("river-sound.mp3")
    river.shouldLoop(true)
    river.play()
    stateConfig.river(river)
  }
  
  method setTitle(title) {
    currentTitle = title
    game.title(title)
  }
  
  method width() = width
  
  method height() = height
  
  method cellSize() = cellSize
  
  method initXPosition() = width / 2
  
  method initYPosition() = height - 1
  
  method middleXPosition() = width / 2
}