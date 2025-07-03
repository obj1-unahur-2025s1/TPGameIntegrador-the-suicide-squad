import wollok.game.*
import src.model.TickBinding.*
import src.utils.constants.*

/**
 * Service that manages the game ticks for periodic actions,
 * such as checking the frog's state and moving logs.
 */
class TickService {
  const bindings = []

  /**
   * Sets up the ticks for frog checking and log movement using provided handlers.
   * 
   * @param handleCheckFrog The action to check the frog's state.
   * @param handleMoveLogs The action to move the logs.
   */
  method setupTicks(handleCheckFrog, handleMoveLogs) {
    bindings.addAll(
      [
        new TickBinding(
          interval = constants.checkFrogTickInterval(),
          action = { handleCheckFrog }
        ),
        new TickBinding(
          interval = constants.moveLogsTickInterval(),
          action = { handleMoveLogs }
        )
      ]
    )

    bindings.forEach({ element => element.bind() })
  }

  /**
   * Starts all bound ticks.
   */
  method playTicks() {
    bindings.forEach({ element => element.start() })
  }

  /**
   * Stops all bound ticks.
   */
  method stopTicks() {
    bindings.forEach({ element => element.stop() })
  }

  /**
   * Checks if all ticks are currently running.
   * 
   * @return true if all ticks are running; false otherwise.
   */
  method areTicksRunning() = bindings.all({ element => element.isRunning() })
}
