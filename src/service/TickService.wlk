import src.config.stateConfig.*
import src.util.Logger.*
import wollok.game.*

class TickService {
  const logger = new Logger(callerName = "TickService")
  
  method setupTicks(caller) {
    logger.message("Setting up ticks")
    stateConfig.moveLogsTick(game.tick(350, { caller.handleMoveLogs() }, true))
    stateConfig.checkFrogTick(
      game.tick(150, { caller.handleCheckFrog() }, true)
    )
  }
  
  method playTicks() {
    logger.message("Playing ticks")
    stateConfig.moveLogsTick().start()
    stateConfig.checkFrogTick().start()
  }
  
  method stopTicks() {
    logger.message("Stopping ticks")
    stateConfig.moveLogsTick().stop()
    stateConfig.checkFrogTick().stop()
  }
  
  method areTicksRunning() = ((stateConfig.moveLogsTick() != null) && stateConfig.moveLogsTick().isRunning()) && ((stateConfig.checkFrogTick() != null) && stateConfig.checkFrogTick().isRunning())
}