object stateConfig {
  var gameInProgress = true
  var property isGameOverScreen = false
  var property isStartScreen = false
  
  method isInProgress() = gameInProgress
  
  method startRound() {
    gameInProgress = true
    isGameOverScreen = false
    isStartScreen = false
  }
  
  method setIsGameOverScreenTrue() {
    gameInProgress = false
    isGameOverScreen = true
    isStartScreen = false
  }
}