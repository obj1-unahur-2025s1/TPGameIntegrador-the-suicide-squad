import src.utils.Logger.*

/**
* Represents a binding between a keyboard key and an action to perform when that key is pressed.
*/
class KeyBinding {
  /**
  * The keyboard key to listen for.
  */
  const key

  /**
  * The action (function) to execute when the key is pressed.
  */
  const action
  
  /**
  * Binds the key to the specified action. When the key is pressed,
  * the action will be executed.
  */
  method bind() {
    key.onPressDo({ action.apply() })
  }
}