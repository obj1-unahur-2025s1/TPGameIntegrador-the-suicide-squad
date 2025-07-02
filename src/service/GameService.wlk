import src.config.setup.*
import src.service.ScenarioService.*
import src.util.Logger.*
import src.util.logsList.*
import src.config.stateConfig.*
import src.config.appConfig.*
import src.service.InputService.*
import src.service.TickService.*
import src.model.Frog.*
import src.model.LogLong.LogLong
import src.model.LogShort.LogShort

class GameService {
  const stages = []
  var property actualStageIndex = 0

  method actualStage() = stages.get(actualStageIndex)

  method addStage(newStage) {
    stages.add(newStage)
  }

  const frog = new Frog(
    startX = appConfig.initXPosition(),
    startY = appConfig.initYPosition()
  )
  const tickService = new TickService()
  const inputService = new InputService()
  const scenarioService = new ScenarioService()
  const logger = new Logger(callerName = "GameService")

  method frog() = frog

  method showMenu() {
    scenarioService.removeAllVisuals()
    game.boardGround("menuScreen.png")
    keyboard.space().onPressDo({
      if (stateConfig.isInMenu()) {
        self.startGame()
      }
    })
  }
  method startGame() {
    stateConfig.startGame()
    self.mainSetup()
  }

  method mainSetup() {
    self.configStages()

    inputService.bindControls(self, frog)
    inputService.bindCommonProcessRestart(self)
    inputService.bindRestartButton(self)
    tickService.setupTicks(self)

    self.roundFirstSetup()
  }

  method configStages() {
    self.addStage(new Stage(
      bg = "bg-river.png",
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
    ))

    self.addStage(new Stage(
      bg = "bg-river2.png",
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
    ))

    self.addStage(new Stage(
      bg = "bg-river3.png",
      logList = [
        new LogLong(row = 6, startX = 0, speed = 1),
        new LogLong(row = 6, startX = 4, speed = 1),
        new LogLong(row = 6, startX = 8, speed = 1),
        new LogLong(row = 6, startX = 12, speed = 1),
        new LogLong(row = 6, startX = 16, speed = 1),
        new LogShort(row = 2, startX = 0, speed = 1),
        new LogShort(row = 2, startX = 4, speed = 1),
        new LogShort(row = 2, startX = 8, speed = 1),
        new LogShort(row = 2, startX = 12, speed = 1),
        new LogShort(row = 2, startX = 16, speed = 1)
      ]
    ))
  }

  method roundFirstSetup() {
    game.boardGround(self.actualStage().bg())
    logsList.addLogs(self.actualStage().logList())
    stateConfig.startRound()
    scenarioService.setUpRoundScenario(frog)
    tickService.playTicks()
    game.say(frog, "Usa las flechas para jugar")
  }

  method tryMoveFrogTo(newPosition) {
    if (stateConfig.isInProgress())
      frog.moveTo(newPosition)
  }

  method restartCommonProcessIfNeeded() {
    if (stateConfig.isInProgress() && (!tickService.areTicksRunning()))
      tickService.playTicks()
  }

  method gameWon() {
    tickService.stopTicks()
    stateConfig.setIsGameOverScreenTrue()
    scenarioService.removeAllVisuals()
    game.boardGround("gameWon.png")
    game.say(frog, "¡Ganaste los 3 niveles!")
  }

  method gameOver() {
    tickService.stopTicks()
    game.say(frog, "Perdiste! Pulsa R para reiniciar")
    stateConfig.setIsGameOverScreenTrue()
  }

method resetGame() {
  scenarioService.removeAllVisuals()
  frog.resetPosition()
  actualStageIndex = 0
  game.boardGround(self.actualStage().bg())
  logsList.addLogs(self.actualStage().logList())
  self.config()
}


  method handleMoveLogs() {
    logsList.logs().forEach({ log =>
      const frogIsOnLog = log.position() == frog.position()
      const reset = log.moveAndCheckReset()

      if (frogIsOnLog) {
        if (reset) {
          self.gameOver()
        } else {
          const newFrogX = frog.calculateNextFrogX(log.speed())
          if (frog.isOutOfBounds(log.speed()))
            self.gameOver()
          else
            frog.moveTo(game.at(newFrogX, frog.position().y()))
        }
      }
    })
  }

method handleCheckFrog() {
  if (frog.reachedGoal()) {
    self.nextLevel()
  } else {
    if (actualStageIndex == 2) { // Solo en nivel 3
      if ((frog.position().y() > 0) && (frog.position().y() < appConfig.initYPosition()) && frog.position().y() != 4)
        self.handleDangerZone()
    } else {
      if ((frog.position().y() > 0) && (frog.position().y() < appConfig.initYPosition()))
        self.handleDangerZone()
    }
  }
}


  method handleDangerZone() {
    if (!logsList.logs().any({ log => log.position() == frog.position() }))
      self.gameOver()
  }

  method config() {
    stateConfig.startRound()
    scenarioService.setUpRoundScenario(frog)
    tickService.playTicks()
  }

//  method continueToNextLevel() {
//  waitingForNextLevel = false
//  frog.resetPosition()
//  game.boardGround(self.actualStage().bg())
//  logsList.addLogs(self.actualStage().logList())
//  self.config()
//}


  method nextLevel() {
    actualStageIndex += 1
    if (actualStageIndex < stages.size()) {
      frog.resetPosition()
      scenarioService.removeAllVisuals()
      //game.boardGround("levelComplete.png")
      //waitingForNextLevel = true
      //tickService.stopTicks()
      game.boardGround(self.actualStage().bg())
      logsList.addLogs(self.actualStage().logList())
      self.config()
    } else {
      self.gameWon()
    }
  }
}

class Stage {
  const bg
  const logList

  method bg() = bg
  method logList() = logList
}
