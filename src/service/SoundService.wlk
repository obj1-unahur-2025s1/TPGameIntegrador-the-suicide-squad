import src.utils.constants.*
import wollok.game.*

/**
* Provides methods to control game sounds, including background music,
* win/lose music, and sound effects for game events.
*/
class SoundService {
  const stateManager
  var won = null
  var lose = null

  /**
  * Plays the background river sound with reduced volume.
  */
  method playBackgroundSound() {
    stateManager.river().play()
    stateManager.river().volume(0.3)
  }

  /**
  * Stops the background river sound.
  */
  method pauseBackgroundSound() {
    stateManager.river().stop()
  }

  /**
  * Resumes playing the background river sound.
  */
  method resumeBackgroundSound() {
    stateManager.river().play()
  }

  /**
  * Stops the background river sound if it's paused or playing.
  */
  method quitBackgroundSound() {
    if ((stateManager.river() != null) && (stateManager.river().paused() || stateManager.river().played()))
      stateManager.river().stop()
  }

  /**
  * Plays the music for the win condition in a loop.
  */
  method playWonMusic() {
    won = game.sound(constants.wonSound())
    won.shouldLoop(true)
    won.play()
  }

  /**
  * Stops the win music if it is playing.
  */
  method quitWonMusic() {
    if ((won != null) && won.played()) won.stop()
  }

  /**
  * Plays the music for the lose condition in a loop.
  */
  method playLoseMusic() {
    lose = game.sound(constants.loseSound())
    lose.shouldLoop(true)
    lose.play()
  }

  /**
  * Stops the lose music if it is playing.
  */
  method quitLoseMusic() {
    if ((lose != null) && lose.played()) lose.stop()
  }

  /**
  * Stops all game sounds, including background, win, and lose music.
  */
  method quitAllSounds() {
    self.quitBackgroundSound()
    self.quitWonMusic()
    self.quitLoseMusic()
  }

  /**
  * Plays the "next level" transition sound effect.
  */
  method playNextLevel() {
    const croack = game.sound(constants.nextLevelSound())
    croack.play()
  }

  /**
  * Plays the sound effect of a waterfall.
  */
  method playWaterFall() {
    const waterFall = game.sound(constants.waterFallSound())
    waterFall.play()
  }
}
