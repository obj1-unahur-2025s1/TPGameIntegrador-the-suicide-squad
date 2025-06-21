import wollok.game.*
import src.config.stateConfig.stateConfig

class Frog {
  const startX = 0
  const startY = 0
  var property position = game.at(startX, startY)
  var property alive = true
  
  method image() = "frog3.png"
  
  method moveTo(pos) {
    if (self.canMoveTo(pos)) {
      position = pos
    }
  }
  
  method resetPosition() {
    position = game.at(startX, startY)
  }
  
  method canMoveTo(
    pos
  ) = stateConfig.isInProgress() && self.isPositionWithinBounds(pos)
  
  method isPositionWithinBounds(
    pos
  ) = (((pos.x() >= 0) && (pos.x() < game.width())) && (pos.y() >= 0)) && (pos.y() < game.height())
  
  method isOutOfBounds(logSpeed) = (self.calculateNextFrogX(
    logSpeed
  ) < 0) || (self.calculateNextFrogX(logSpeed) >= game.width())
  
  method calculateNextFrogX(logSpeed) = self.position().x() + logSpeed
  
  method reachedGoal() = position.y() == 0
}