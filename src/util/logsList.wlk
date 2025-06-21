import src.model.Log.Log

object logsList {
  const property logs = [
    new Log(startX = 2, row = 7, speed = 1),
    new Log(startX = 7, row = 6, speed = -1),
    new Log(startX = 4, row = 5, speed = 1)
  ]
  
  method resetAll() {
    logs.forEach({ log => log.resetPosition() })
  }
}