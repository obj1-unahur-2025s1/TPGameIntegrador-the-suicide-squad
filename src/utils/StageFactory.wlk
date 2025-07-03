import src.model.LogLong.*
import src.model.LogShort.*
import src.model.Stage.*

/**
 * Factory class responsible for creating all stages of the game
 * with their respective logs and configurations.
 */
class StageFactory {
   /**
   * Returns a list of all stages available in the game.
   * 
   * @return List of all game stages.
   */
  method allStages() = [self.stage1(), self.stage2(), self.stage3()]
  
  /**
   * Creates and returns the configuration for stage 1.
   * 
   * @return Stage 1 with its logs.
   */
  method stage1() = new Stage(
    level = 1,
    logList = [
      new LogLong(row = 6, startX = 0, speed = 1),
      new LogLong(row = 6, startX = 4, speed = 1),
      new LogLong(row = 6, startX = 8, speed = 1),
      new LogLong(row = 6, startX = 12, speed = 1),
      new LogLong(row = 6, startX = 16, speed = 1),
      new LogLong(row = 4, startX = 3, speed = -1),
      new LogLong(row = 4, startX = 8, speed = -1),
      new LogLong(row = 4, startX = 13, speed = -1),
      new LogLong(row = 4, startX = 18, speed = -1),
      new LogLong(row = 2, startX = 0, speed = 1),
      new LogLong(row = 2, startX = 4, speed = 1),
      new LogLong(row = 2, startX = 8, speed = 1),
      new LogLong(row = 2, startX = 12, speed = 1),
      new LogLong(row = 2, startX = 16, speed = 1)
    ]
  )
  
  /**
   * Creates and returns the configuration for stage 2.
   * 
   * @return Stage 2 with its logs.
   */
  method stage2() = new Stage(
    level = 2,
    logList = [
      new LogShort(row = 6, startX = 0, speed = 1),
      new LogLong(row = 6, startX = 4, speed = 1),
      new LogShort(row = 6, startX = 8, speed = 1),
      new LogLong(row = 6, startX = 12, speed = 1),
      new LogShort(row = 6, startX = 16, speed = 1),
      new LogLong(row = 4, startX = 3, speed = -1),
      new LogShort(row = 4, startX = 8, speed = -1),
      new LogLong(row = 4, startX = 13, speed = -1),
      new LogShort(row = 4, startX = 18, speed = -1),
      new LogLong(row = 2, startX = 0, speed = 1),
      new LogLong(row = 2, startX = 4, speed = 1),
      new LogShort(row = 2, startX = 8, speed = 1),
      new LogLong(row = 2, startX = 12, speed = 1),
      new LogLong(row = 2, startX = 16, speed = 1)
    ]
  )
  
  /**
   * Creates and returns the configuration for stage 3.
   * 
   * @return Stage 3 with its logs.
   */
  method stage3() = new Stage(
    level = 3,
    logList = [
      new LogLong(row = 6, startX = 0, speed = 1),
      new LogLong(row = 6, startX = 4, speed = 1),
      new LogLong(row = 6, startX = 8, speed = 1),
      new LogLong(row = 6, startX = 12, speed = 1),
      new LogLong(row = 6, startX = 16, speed = 1),
      new LogLong(row = 4, startX = 3, speed = -1),
      new LogShort(row = 4, startX = 8, speed = -1),
      new LogLong(row = 4, startX = 13, speed = -1),
      new LogShort(row = 4, startX = 18, speed = -1),
      new LogShort(row = 2, startX = 0, speed = 1),
      new LogShort(row = 2, startX = 4, speed = 1),
      new LogShort(row = 2, startX = 8, speed = 1),
      new LogShort(row = 2, startX = 12, speed = 1),
      new LogShort(row = 2, startX = 16, speed = 1)
    ]
  )
}