import wollok.game.*

/**
* Manages a repeated action bound to a game tick interval.
* Provides control to start, stop, and check the running state of the tick.
*/
class TickBinding {
  const interval
  const action
  var tick = null 
  
  /**
  * Binds the action to a game tick that runs at the specified interval.
  */
  method bind() {
    tick = game.tick(interval, action.apply(), true)
  }
  
  /**
  * Starts the tick if it has been initialized.
  */
  method start() {
    if (tick != null) tick.start()
  }
  
  /**
  * Stops the tick if it has been initialized.
  */
  method stop() {
    if (tick != null) tick.stop()
  }
  
  /**
  * Checks if the tick is currently running.
  * 
  * @return true if the tick is running; false otherwise.
  */
  method isRunning() = (tick != null) && tick.isRunning()
}