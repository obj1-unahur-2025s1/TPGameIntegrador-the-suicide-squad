object appConfig {
  const width = 10
  const height = 10
  const cellSize = 50
  var currentTitle = "Frogger: Cross the river"
  
  method initialize(gameInstance) {
    gameInstance.width(width)
    gameInstance.height(height)
    gameInstance.cellSize(cellSize)
    self.setTitle(currentTitle)
  }
  
  method setTitle(title) {
    currentTitle = title
    game.title(title)
  }
}