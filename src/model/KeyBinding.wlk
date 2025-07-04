import src.utils.Logger.*

class KeyBinding {
  const key
  const action
  const logger = new Logger(name = "KeyBinding")
  
  method bind() {
    key.onPressDo(
      { 
        // logger.print(("Key " + key.keyCodes()) + " pressed.")
         action.apply()
      }
    )
  }
}