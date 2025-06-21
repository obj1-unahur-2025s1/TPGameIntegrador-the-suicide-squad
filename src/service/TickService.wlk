import src.util.Logger.*
import wollok.game.*

class TickService {
  const logger = new Logger(callerName = "TickService")
  
  method setupTicks(caller) {
    logger.message("Setting up ticks")
    game.onTick(350, "moveLogs", { caller.handleMoveLogs() })
    game.onTick(150, "checkFrog", { caller.handleCheckFrog() })
  }
  
  method stopTicks() {
    logger.message("Stopping ticks")
    game.removeTickEvent("moveLogs")
    game.removeTickEvent("checkFrog")
  }
}