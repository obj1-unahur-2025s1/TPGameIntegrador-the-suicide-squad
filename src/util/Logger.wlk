class Logger {
  const callerName
  
  method message(msg) {
    console.println((("" + callerName) + ": ") + msg)
  }
}