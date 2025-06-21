import wollok.game.*

class Log {
  const startX = 0
  const row = 0
  const property speed = 1
  var property position = game.at(startX, row)
  
  method image() = "log1.png"
  
  method resetPosition() {
    position = game.at(startX, row)
  }
  
  method moveAndCheckReset() {
    var newX = position.x() + speed
    var didReset = false
    
    if (newX >= game.width()) {
      newX = 0
      didReset = true
    } else {
      if (newX < 0) {
        newX = game.width() - 1
        didReset = true
      }
    }
    
    position = game.at(newX, row)
    return didReset
  }
  
  method position() = position
}