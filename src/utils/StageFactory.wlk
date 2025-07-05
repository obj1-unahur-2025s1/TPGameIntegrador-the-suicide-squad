import src.model.BonusLog.*
import src.model.LogLong.*
import src.model.LogShort.*
import src.model.Stage.* 
import src.utils.constants.*

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
      new LogLong(id = 1, row = 6, startX = 0, speed = 1),
      new LogLong(id = 2, row = 6, startX = 4, speed = 1),
      new LogLong(id = 3, row = 6, startX = 8, speed = 1),
      new LogLong(id = 4, row = 6, startX = 12, speed = 1),
      new LogLong(id = 5, row = 6, startX = 16, speed = 1),
      new LogLong(id = 6, row = 4, startX = 3, speed = -1),
      new BonusLog(id = 7, row = 4, startX = 8, speed = -1, image = constants.bonusLogFitoImage(), sound = constants.bonusLogFitoSound()),
      new LogLong(id = 8, row = 4, startX = 13, speed = -1),
      new LogLong(id = 9, row = 4, startX = 18, speed = -1),
      new LogLong(id = 10, row = 2, startX = 0, speed = 1),
      new LogLong(id = 11, row = 2, startX = 4, speed = 1),
      new LogLong(id = 12, row = 2, startX = 8, speed = 1),
      new LogLong(id = 13, row = 2, startX = 12, speed = 1),
      new LogLong(id = 14, row = 2, startX = 16, speed = 1)
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
      new LogShort(id = 15, row = 6, startX = 0, speed = 1),
      new LogLong(id = 16, row = 6, startX = 4, speed = 1),
      new LogShort(id = 17, row = 6, startX = 8, speed = 1),
      new LogLong(id = 18, row = 6, startX = 12, speed = 1),
      new LogShort(id = 19, row = 6, startX = 16, speed = 1),
      new LogLong(id = 20, row = 4, startX = 3, speed = -1),
      new BonusLog(id = 21, row = 4, startX = 8, speed = -1, image = constants.bonusLogDogImage(), sound = constants.bonusLogDogSound()),
      new LogLong(id = 22, row = 4, startX = 13, speed = -1),
      new LogShort(id = 23, row = 4, startX = 18, speed = -1),
      new LogLong(id = 24, row = 2, startX = 0, speed = 1),
      new LogLong(id = 25, row = 2, startX = 4, speed = 1),
      new LogShort(id = 26, row = 2, startX = 8, speed = 1),
      new LogLong(id = 27, row = 2, startX = 12, speed = 1),
      new LogLong(id = 28, row = 2, startX = 16, speed = 1)
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
      new LogLong(id = 29, row = 6, startX = 0, speed = 1),
      new LogLong(id = 30, row = 6, startX = 4, speed = 1),
      new LogLong(id = 31, row = 6, startX = 8, speed = 1),
      new LogLong(id = 32, row = 6, startX = 12, speed = 1),
      new LogLong(id = 33, row = 6, startX = 16, speed = 1),
      new LogLong(id = 34, row = 4, startX = 3, speed = -1),
      new BonusLog(id = 35, row = 4, startX = 8, speed = -1, image = constants.bonusLogCfImage(), sound = constants.bonusLogCfSound()),
      new LogLong(id = 36, row = 4, startX = 13, speed = -1),
      new LogShort(id = 37, row = 4, startX = 18, speed = -1),
      new LogShort(id = 38, row = 2, startX = 0, speed = 1),
      new LogShort(id = 39, row = 2, startX = 4, speed = 1),
      new LogShort(id = 40, row = 2, startX = 8, speed = 1),
      new LogShort(id = 41, row = 2, startX = 12, speed = 1),
      new LogShort(id = 42, row = 2, startX = 16, speed = 1)
    ]
  )
}