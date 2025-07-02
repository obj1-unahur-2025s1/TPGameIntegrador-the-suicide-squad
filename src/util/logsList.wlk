// src/util/logsList.wlk
// src/util/logsList.wlk
// src/util/logsList.wlk
// src/util/logsList.wlk
import src.model.LogLong.LogLong
import src.model.LogShort.LogShort

object logsList {
  const property logs = []

  method addLogs(list) {
    logs.clear()
    logs.addAll(list)
  }
  
  method resetAll() {
    logs.forEach({ log => log.resetPosition() })
  }
}