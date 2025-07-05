import src.model.UiText.*
import src.model.UiScreen.*
import src.model.VisualBox.*
import src.service.SoundService.*
import src.config.StateManager.*
import src.utils.StageFactory.*
import wollok.game.*
import src.utils.constants.*

/**
* Handles visual setup and updates for game scenarios, such as 
* screens, stages, counters, and interactions with sound.
*/
class ScenarioService {
  const stateManager
  var currentLogsList = []
  const stageFactory = new StageFactory()
  const soundService = new SoundService(stateManager = stateManager)

  const lifeCounter = new VisualBox(
    imageDic = constants.lifeCounterImages(),
    position = game.at(constants.gameWidth() - 2, constants.gameHeight() - 1),
    currentKey = { stateManager.currentLives() }
  )

  const levelCounter = new VisualBox(
    imageDic = constants.levelCounterImages(),
    position = game.at(0, constants.gameHeight() - 1),
    currentKey = { stateManager.currentLevel() }
  )

  const pointsCounter = new UiText(
    position = game.at(2, constants.gameHeight() - 1),
    text = { "                    " + "Puntos: " + stateManager.points() },
    image = constants.pointsCounterBadge()
  )

  const welcomeScreen = new UiScreen(image = constants.welcomeScreen())
  const pauseScreen = new UiScreen(image = constants.pauseScreen())
  const wonScreen = new UiScreen(image = constants.wonScreen())
  const loseScreen = new UiScreen(image = constants.loseScreen())
  
  /**
  * Sets initial board ground and renders the welcome screen.
  */
  method initialize() {
    game.boardGround(constants.boardGround())
    self.renderWelcomeScreen()
  }
  
  /**
  * Performs full reinitialization: stops sounds, resets state, 
  * and renders the welcome screen.
  */
  method manualInitialize() {
    soundService.quitAllSounds()
    stateManager.river(null)
    stateManager.resetGameState()
    stateManager.river(game.sound(constants.riverSound()))
    stateManager.river().shouldLoop(true)
    self.renderWelcomeScreen()
  }
  
  /**
  * Renders the heart/life counter on screen.
  */
  method renderLifeCounter() {
    game.addVisual(lifeCounter)
  }
  
  /**
  * Renders the level counter on screen.
  */
  method renderLevelCounter() {
    game.addVisual(levelCounter)
  }

  /**
  * Updates the points counter text and renders it on screen.
  */
  method renderPointsCounter() {
    game.addVisual(pointsCounter)
  }
  
  /**
  * Displays the pause screen and pauses background audio.
  */
  method renderPauseScreen() {
    if (!game.hasVisual(pauseScreen)) {
      soundService.pauseBackgroundSound()
      game.addVisual(pauseScreen)
    }
  }
  
  /**
  * Hides the pause screen and resumes background audio.
  */
  method quitPauseScreen() {
    soundService.resumeBackgroundSound()
    game.removeVisual(pauseScreen)
  }
  
  /**
  * Displays the welcome screen if not already shown.
  */
  method renderWelcomeScreen() {
    if (!game.hasVisual(welcomeScreen)) game.addVisual(welcomeScreen)
  }
  
  /**
  * Removes the welcome screen.
  */
  method quitWelcomeScreen() {
    game.removeVisual(welcomeScreen)
  }
  
  /**
  * Renders the "game won" screen and plays corresponding music.
  */
  method renderGameWonScreen() {
    if (!game.hasVisual(wonScreen)) {
      soundService.pauseBackgroundSound()
      soundService.playWonMusic()
      game.addVisual(wonScreen)
    }
  }
  
  /**
  * Removes the "game won" screen and stops the music.
  */
  method quitGameWonScreen() {
    game.removeVisual(wonScreen)
    soundService.quitWonMusic()
  }
  
  /**
  * Renders the "game lost" screen and plays corresponding music.
  */
  method renderGameLoseScreen() {
    if (!game.hasVisual(loseScreen)) {
      soundService.pauseBackgroundSound()
      soundService.playLoseMusic()
      game.addVisual(loseScreen)
    }
  }
  
  /**
  * Removes the "game lost" screen and stops the music.
  */
  method quitGameLoseScreen() {
    game.removeVisual(loseScreen)
    soundService.quitLoseMusic()
  }
  
  /**
  * Renders the entire stage including visuals, logs, counters and frog.
  * 
  * @param frog The frog entity to render.
  */
  method renderStage(frog) {
    self.removeAllVisuals()
    self.updateLogsList()
    self.renderLogs()
    self.renderLifeCounter()
    self.renderLevelCounter()
    self.renderPointsCounter()
    self.renderFrog(frog)
    soundService.playBackgroundSound()
  }
  
  /**
  * Renders the level, with an optional sound for retrying same level.
  * 
  * @param frog The frog to display.
  * @param repeatSameLevel Whether it's a retry (true) or new level (false).
  */
  method renderLevel(frog, repeatSameLevel) {
    if (repeatSameLevel) soundService.playWaterFall()
    else soundService.playNextLevel()
    
    self.removeAllVisuals()
    self.updateLogsList()
    self.renderLogs()
    self.renderLifeCounter()
    self.renderLevelCounter()
    self.renderPointsCounter()
    self.renderFrog(frog)
  }
  
  /**
  * Clears visuals and resets the scenario state.
  */
  method resetScenario() {
    self.removeAllVisuals()
    stateManager.resetGame()
    currentLogsList = []
  }
  
  /**
  * Updates the current list of logs for the current level.
  */
  method updateLogsList() {
    currentLogsList = stageFactory.allStages().find(
      { stage => stage.level() == stateManager.currentLevel() }
    ).logList()
    
    stateManager.currentLogsList(currentLogsList)
  }
  
  /**
  * Renders all logs visually on the game board.
  */
  method renderLogs() {
    currentLogsList.forEach({ log => game.addVisual(log) })
  }
  
  /**
  * Resets the frog's position, adds it visually, and shows an initial message.
  * 
  * @param frog The frog entity to render.
  */
  method renderFrog(frog) {
    frog.resetPosition()
    game.addVisual(frog)
  }
  
  /**
  * Removes all visual elements currently displayed on the game board.
  */
  method removeAllVisuals() {
    game.allVisuals().forEach({ visual => game.removeVisual(visual) })
  }
  
  /**
  * Handles movement of logs and collision logic with the frog during game ticks.
  * Increments points if the frog is on a log and checks for game loss conditions.
  * 
  * @param moveFrogTo Function to move the frog to a new position.
  * @param loseGame Function to invoke if the frog is lost.
  * @param frog The frog entity involved in the interactions.
  */
  method handleMoveLogs(moveFrogTo, loseGame, frog) {
    currentLogsList.forEach(
      { log =>
        const frogIsOnLog = log.position() == frog.position()
        const logReset = log.moveAndCheckReset()
        
        if (!frogIsOnLog) {
          return
        }

        if(log.id() != frog.lastLogId()) {
          stateManager.incrementPoints(log.points())
        }

        if(log.id() != frog.lastLogId() && log.sound() != null) {
          soundService.playGenericSound(log.sound())
        }

        frog.lastLogId(log.id())

        if (logReset || frog.isOutOfBounds(log.speed())) {
          loseGame.apply()
          return
        }
        
        const newFrogX = frog.nextXPosition(log.speed())
        const newFrogPos = game.at(newFrogX, frog.position().y())

        return moveFrogTo.apply(newFrogPos)
      }
    )
  }
}