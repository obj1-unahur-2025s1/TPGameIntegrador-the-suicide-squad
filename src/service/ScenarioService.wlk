// src/service/ScenarioService.wlk
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
    position = game.at(constants.lifeCounterX(), constants.hudY()),
    currentKey = { stateManager.currentLives() }
  )

  const levelCounter = new VisualBox(
    imageDic = constants.levelCounterImages(),
    position = game.at(constants.levelCounterX(), constants.hudY()),
    currentKey = { stateManager.currentLevel() }
  )

  const pointsCounter = new UiText(
    position = game.at(constants.pointsCounterX(), constants.pointsCounterY()),
    text = { "Puntos: " + stateManager.points() }
  )

  const finalPointsCounter = new UiText(
    position = game.at(constants.finalPointsCounterX(), constants.finalPointsCounterY()),
    text = { "Puntaje Final: " + stateManager.points() }
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
    soundService.quitAllSounds()
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

  method renderFinalPointsCounter(){
    game.addVisual(finalPointsCounter)
  }
  
  /**
  * Displays the pause screen and pauses background audio.
  */
  method renderPauseScreen() {
    if (!game.hasVisual(pauseScreen)) {
      soundService.pauseRiverSound()
      game.addVisual(pauseScreen)
    }
  }
  
  /**
  * Hides the pause screen and resumes background audio.
  */
  method quitPauseScreen() {
    soundService.resumeRiverSound()
    game.removeVisual(pauseScreen)
  }
  
  /**
  * Displays the welcome screen if not already shown.
  */
  method renderWelcomeScreen() {
    if (!game.hasVisual(welcomeScreen)) {
      soundService.playAmbientMusic()
      game.addVisual(welcomeScreen)
    }
  }
  
  /**
  * Renders the "game won" screen and plays corresponding music.
  */
  method renderGameWonScreen() {
    if (!game.hasVisual(wonScreen)) {
      soundService.pauseRiverSound()
      soundService.playWonMusic()
      game.addVisual(wonScreen)
      self.renderFinalPointsCounter()
    }
  }
  
  /**
  * Renders the "game lost" screen and plays corresponding music.
  */
  method renderGameLoseScreen() {
    if (!game.hasVisual(loseScreen)) {
      soundService.pauseRiverSound()
      soundService.playLoseMusic()
      game.addVisual(loseScreen)
      self.renderFinalPointsCounter()
    }
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
    soundService.playRiverSound()
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
  * Handles the movement of logs and checks if the frog is on any log.
  * If the frog is on a log, it updates the frog's position or triggers a game loss.
  * @param moveFrogTo Function to move the frog to a new position.
  * @param loseGame Function to handle game loss.
  * @param frog The frog entity to check against logs.
  */
  method handleMoveLogs(moveFrogTo, loseGame, frog) {
    currentLogsList.forEach(
      { log =>
        const isFrogOnLog = self.isFrogOnCurrentLog(log, frog)
        
        const logHaveToResetPosition = log.moveAndCheckReset()
        
        if (isFrogOnLog) {
          self.incrementPoints(log, frog)
          self.playLogSound(log, frog)
          frog.lastLogId(log.id())
          
          const nextX = frog.nextXPosition(log.speed())
          
          if (logHaveToResetPosition || self.frogWillFall(frog, log)) {
            loseGame.apply()
          } else {
            const newFrogPos = game.at(nextX, frog.position().y())
            moveFrogTo.apply(newFrogPos)
          }
        }
      }
    )
  }
  
  /**
  * Checks if the frog will fall off the log based on its position.
  * @param frog The frog entity to check.
  * @param log The log entity to check against.
  * @return True if the frog will fall off the log, false otherwise.
  */
  method frogWillFall(frog, log) {
    const frogX = frog.position().x()
    const frogY = frog.position().y()
    
    return (((frogX < log.xStart()) || (frogX > log.xEnd())) || (frogY < log.yStart())) || (frogY > log.yEnd())
  }
  
  /**
  * Plays the log's sound if it exists and the interaction is new.
  * @param log The log entity to check for sound.
  * @param frog The frog entity to check interaction.
  */
  method playLogSound(log, frog) {
    if ((log.sound() != null) && self.isNewLogInteraction(log, frog))
      soundService.playGenericSound(log.sound(), log.soundTtl())
  }
  
  /**
  * Increments the player's points if the interaction with the log is new.
  * @param log The log entity that the frog interacted with.
  * @param frog The frog entity to check interaction.
  */
  method incrementPoints(log, frog) {
    if (self.isNewLogInteraction(log, frog)) {
      stateManager.incrementPoints(log.points())
    }
  }
  
  /**
  * Checks if the interaction with the log is new based on the frog's last log ID.
  * @param log The log entity to check.
  * @param frog The frog entity to check interaction.
  * @return True if the interaction is new, false otherwise.
  */
  method isNewLogInteraction(
    log,
    frog
  ) = (log.id() != frog.lastLogId()) && (frog.lastLogId() != null)
  
  /**
  * Checks if the frog is currently on the specified log.
  * @param log The log entity to check.
  * @param frog The frog entity to check against the log.
  * @return True if the frog is on the log, false otherwise.
  */
  method isFrogOnCurrentLog(log, frog) {
    const frogX = frog.position().x()
    const frogY = frog.position().y()
    const logXRange = new Range(start = log.xStart(), end = log.xEnd())
    const logYRange = new Range(start = log.yStart(), end = log.yEnd())
    return logXRange.contains(frogX) && logYRange.contains(frogY)
  }
}