import wollok.game.*
import src.model.KeyBinding.*

/**
 * Service responsible for binding keyboard inputs to game actions.
 * It manages key bindings for player movement and common game controls.
 */
class InputService {
  const bindings = []
  const stateManager

  /**
   * Prepares and binds all controls for the caller and frog entities.
   * 
   * @param caller The object that will handle the input actions.
   * @param frog The frog entity to be controlled.
   */
  method bindControls(caller, frog) {
    self.prepareBindings(caller, frog)
    self.bindAll()
  }

  /**
   * Binds all prepared key bindings to their respective key events.
   */
  method bindAll() {
    bindings.forEach({ binding => binding.bind() })
  }

  /**
   * Prepares the list of key bindings for movement and common game actions.
   * 
   * @param caller The object that will handle the input actions.
   * @param frog The frog entity to be controlled.
   */
  method prepareBindings(caller, frog) {
    const keyMoves = [
      new KeyBinding(
        key = keyboard.up(),
        action = { caller.tryMoveFrogTo(frog.position().up(2)) }
      ),
      new KeyBinding(
        key = keyboard.down(),
        action = { caller.tryMoveFrogTo(frog.position().down(2)) }
      ),
      new KeyBinding(
        key = keyboard.left(),
        action = { caller.tryMoveFrogTo(frog.position().left(2)) }
      ),
      new KeyBinding(
        key = keyboard.right(),
        action = { caller.tryMoveFrogTo(frog.position().right(2)) }
      )
    ]

    const commonProcessBindings = [
      new KeyBinding(
        key = keyboard.any(),
        action = { caller.restartCommonProcessIfNeeded() }
      ),
      new KeyBinding(
        key = keyboard.space(),
        condition = stateManager.gameOver(),
        action = { caller.roundSetup() }
      )
    ]

    bindings.addAll(keyMoves)
    bindings.addAll(commonProcessBindings)
  }
}
