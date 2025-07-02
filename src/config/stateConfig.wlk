object stateConfig {
  var gameInProgress = false
  var property isGameOverScreen = false
  var property isStartScreen = false
  var property river = null
  var property moveLogsTick = null
  var property checkFrogTick = null
  var property isInMenu = true  // Nuevo estado para menú

  method isInProgress() = gameInProgress
  method isInMenu() = isInMenu

  method startRound() {
    gameInProgress = true
    isGameOverScreen = false
    isStartScreen = false
    isInMenu = false
  }

  method setIsGameOverScreenTrue() {
    gameInProgress = false
    isGameOverScreen = true
    isStartScreen = false
    isInMenu = false
  }

  method startMenu() {
    isInMenu = true
    gameInProgress = false
    isGameOverScreen = false
    isStartScreen = false
  }

  method startGame() {
    isInMenu = false
    gameInProgress = true
    isGameOverScreen = false
    isStartScreen = false
  }
}
