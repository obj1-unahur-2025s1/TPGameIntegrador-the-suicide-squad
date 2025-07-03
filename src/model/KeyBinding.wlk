/**
* Represents a key binding that links a key press to an action,
* optionally conditioned on a boolean flag.
*/
class KeyBinding {
  const key
  const action
  const condition = true 
  
  /**
  * Binds the action to the key press, executing it only if the condition is true.
  */
  method bind() {
    key.onPressDo({ if (condition) action.apply() })
  }
}