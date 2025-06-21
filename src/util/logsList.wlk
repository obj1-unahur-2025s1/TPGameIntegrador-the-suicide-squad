import src.model.Log.Log

object logsList {
  const property logs = [
    // Fila 6 (velocidad +1)
    new Log(row = 6, startX = 0, speed = 1),
    new Log(row = 6, startX = 4, speed = 1),
    new Log(row = 6, startX = 8, speed = 1),
    new Log(row = 6, startX = 12, speed = 1),
    new Log(row = 6, startX = 16, speed = 1),
    // Fila 4 (velocidad -1)
    new Log(row = 4, startX = 3, speed = -1),
    new Log(row = 4, startX = 8, speed = -1),
    new Log(row = 4, startX = 13, speed = -1),
    new Log(row = 4, startX = 18, speed = -1),
    // Fila 2 (velocidad +2)
    new Log(row = 2, startX = 0, speed = 1),
    new Log(row = 2, startX = 4, speed = 1),
    new Log(row = 2, startX = 8, speed = 1),
    new Log(row = 2, startX = 12, speed = 1),
    new Log(row = 2, startX = 16, speed = 1)
  ]
  
  method resetAll() {
    logs.forEach({ log => log.resetPosition() })
  }
}