object stateConfig {
  var gameInProgress = false
  var property isGameOverScreen = false
  var property isStartScreen = false
  
  method isInProgress() = gameInProgress
  
  method startRound() {
    gameInProgress = true
    isGameOverScreen = false
    isStartScreen = false
  }
  
  method setIsStartScreenTrue() {
    gameInProgress = false
    isGameOverScreen = false
    isStartScreen = true
  }
  
  method setIsGameOverScreenTrue() {
    gameInProgress = false
    isGameOverScreen = true
    isStartScreen = false
  }
}