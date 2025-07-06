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
      new LogLong(id = 1, row = constants.scaledRow(6), startX = constants.scaledX(0), speed = 1),
      new LogLong(id = 2, row = constants.scaledRow(6), startX = constants.scaledX(4), speed = 1),
      new LogLong(id = 3, row = constants.scaledRow(6), startX = constants.scaledX(8), speed = 1),
      new LogLong(id = 4, row = constants.scaledRow(6), startX = constants.scaledX(12), speed = 1),
      new LogLong(id = 5, row = constants.scaledRow(6), startX = constants.scaledX(16), speed = 1),
      new LogLong(id = 6, row = constants.scaledRow(4), startX = constants.scaledX(3), speed = -1),
      new BonusLog(id = 7, row = constants.scaledRow(4), startX = constants.scaledX(8), speed = -1,
        image = constants.bonusLogFitoImage(), sound = constants.bonusLogFitoSound(), soundTtl = 8000),
      new LogLong(id = 8, row = constants.scaledRow(4), startX = constants.scaledX(13), speed = -1),
      new LogLong(id = 9, row = constants.scaledRow(4), startX = constants.scaledX(18), speed = -1),
      new LogLong(id = 10, row = constants.scaledRow(2), startX = constants.scaledX(0), speed = 1),
      new LogLong(id = 11, row = constants.scaledRow(2), startX = constants.scaledX(4), speed = 1),
      new LogLong(id = 12, row = constants.scaledRow(2), startX = constants.scaledX(8), speed = 1),
      new LogLong(id = 13, row = constants.scaledRow(2), startX = constants.scaledX(12), speed = 1),
      new LogLong(id = 14, row = constants.scaledRow(2), startX = constants.scaledX(16), speed = 1)
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
      new LogShort(id = 15, row = constants.scaledRow(6), startX = constants.scaledX(0), speed = 1),
      new LogLong(id = 16, row = constants.scaledRow(6), startX = constants.scaledX(4), speed = 1),
      new LogShort(id = 17, row = constants.scaledRow(6), startX = constants.scaledX(8), speed = 1),
      new LogLong(id = 18, row = constants.scaledRow(6), startX = constants.scaledX(12), speed = 1),
      new LogShort(id = 19, row = constants.scaledRow(6), startX = constants.scaledX(16), speed = 1),
      new LogLong(id = 20, row = constants.scaledRow(4), startX = constants.scaledX(3), speed = -1),
      new BonusLog(id = 21, row = constants.scaledRow(4), startX = constants.scaledX(8), speed = -1,
        image = constants.bonusLogDogImage(), sound = constants.bonusLogDogSound(), soundTtl = 7000),
      new LogLong(id = 22, row = constants.scaledRow(4), startX = constants.scaledX(13), speed = -1),
      new LogShort(id = 23, row = constants.scaledRow(4), startX = constants.scaledX(18), speed = -1),
      new LogLong(id = 24, row = constants.scaledRow(2), startX = constants.scaledX(0), speed = 1),
      new LogLong(id = 25, row = constants.scaledRow(2), startX = constants.scaledX(4), speed = 1),
      new LogShort(id = 26, row = constants.scaledRow(2), startX = constants.scaledX(8), speed = 1),
      new LogLong(id = 27, row = constants.scaledRow(2), startX = constants.scaledX(12), speed = 1),
      new LogLong(id = 28, row = constants.scaledRow(2), startX = constants.scaledX(16), speed = 1)
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
      new LogLong(id = 29, row = constants.scaledRow(6), startX = constants.scaledX(0), speed = 1),
      new LogLong(id = 30, row = constants.scaledRow(6), startX = constants.scaledX(4), speed = 1),
      new LogLong(id = 31, row = constants.scaledRow(6), startX = constants.scaledX(8), speed = 1),
      new LogLong(id = 32, row = constants.scaledRow(6), startX = constants.scaledX(12), speed = 1),
      new LogLong(id = 33, row = constants.scaledRow(6), startX = constants.scaledX(16), speed = 1),
      new LogLong(id = 34, row = constants.scaledRow(4), startX = constants.scaledX(3), speed = -1),
      new BonusLog(id = 35, row = constants.scaledRow(4), startX = constants.scaledX(8), speed = -1,
        image = constants.bonusLogCfImage(), sound = constants.bonusLogCfSound(), soundTtl = 6000),
      new LogLong(id = 36, row = constants.scaledRow(4), startX = constants.scaledX(13), speed = -1),
      new LogShort(id = 37, row = constants.scaledRow(4), startX = constants.scaledX(18), speed = -1),
      new LogShort(id = 38, row = constants.scaledRow(2), startX = constants.scaledX(0), speed = 1),
      new LogShort(id = 39, row = constants.scaledRow(2), startX = constants.scaledX(4), speed = 1),
      new LogShort(id = 40, row = constants.scaledRow(2), startX = constants.scaledX(8), speed = 1),
      new LogShort(id = 41, row = constants.scaledRow(2), startX = constants.scaledX(12), speed = 1),
      new LogShort(id = 42, row = constants.scaledRow(2), startX = constants.scaledX(16), speed = 1)
    ]
  )
}