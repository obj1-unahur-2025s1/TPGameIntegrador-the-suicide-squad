/**
* Simple logger that prefixes messages with a name and prints to console.
*/
class Logger {
  /**
  * The name to prefix log messages with.
  */
  const name
  
  /**
  * Prints a message to the console with the logger's name prefix.
  *
  * @param message The message to log.
  */
  method print(message) {
    console.println((name + ": ") + message)
  }
}