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
  method playRiverSound() {
    self.playIfNotPlaying(stateManager.river())
    stateManager.river().volume(0.3)
  }
  
  /**
  * Stops the background river sound.
  */
  method pauseRiverSound() {
    self.pauseIfPlaying(stateManager.river())
  }
  
  /**
  * Resumes playing the background river sound.
  */
  method resumeRiverSound() {
    self.resumeIfPaused(stateManager.river())
  }

  /**
  * Stops the background river sound if it's paused or playing.
  */
  method quitRiverSound() {
    self.stopIfPlaying(stateManager.river())
  }

  /**
  * Plays the welcome screen music in a loop.
  */
  method playAmbientMusic() {
    game.schedule(
      1000,
      { 
        stateManager.ambientMusic(self.playLoopingSound(constants.welcomeMusic()))
        stateManager.ambientMusic().volume(0.1)
      }
    )
  }
  
  /**
  * Stops the welcome music if it is playing.
  */
  method quitAmbientMusic() {
    self.stopIfPlaying(stateManager.ambientMusic())
  }
  
  /**
  * Plays the music for the win condition in a loop.
  */
  method playWonMusic() {
    self.quitAmbientMusic()
    won = self.playLoopingSound(constants.wonSound())
  }
  
  /**
  * Stops the win music if it is playing.
  */
  method quitWonMusic() {
    self.stopIfPlaying(won)
  }
  
  /**
  * Plays the music for the lose condition in a loop.
  */
  method playLoseMusic() {
    self.quitAmbientMusic()
    lose = self.playLoopingSound(constants.loseSound())
  }
  
  /**
  * Stops the lose music if it is playing.
  */
  method quitLoseMusic() {
    self.stopIfPlaying(lose)
  }
  
  /**
  * Plays the "next level" transition sound effect.
  */
  method playNextLevel() {
    self.playTemporarySound(constants.nextLevelSound(), constants.nextLevelTtl(), 0.1, 0.1)
  }
  
  /**
  * Plays the sound effect of a waterfall.
  */
  method playWaterFall() {
    self.playTemporarySound(constants.waterFallSound(), constants.waterFallTtl(), 0.1, 0.1)
  }
  
  /**
  * Plays a generic sound effect.
  */
  method playGenericSound(sound, ttl) {
    self.playTemporarySound(sound, ttl, 0.05, 0.1)
  }

  /**
  * Plays a sound in a loop.
  * @param path The sound file path to play.
  * @return The sound object that is playing.
  */
  method playLoopingSound(path) {
    const sound = game.sound(path)
    sound.shouldLoop(true)
    self.playIfNotPlaying(sound)
    return sound
  }

  /**
  * Plays a temporary sound effect with specified volume before and after.
  * @param path The sound file path to play.
  * @param ttl The time-to-live in milliseconds for the sound effect.
  * @param volumeBefore The volume level before the sound plays.
  * @param volumeAfter The volume level after the sound stops.
  */
  method playTemporarySound(path, ttl, volumeBefore, volumeAfter) {
    const sound = game.sound(path)
    stateManager.ambientMusic().volume(volumeBefore)
    sound.play()
    game.schedule(
      ttl,
      { 
        sound.stop()
        return stateManager.ambientMusic().volume(volumeAfter)
      }
    )
  }

  /**
  * Stops a sound if it is currently playing.
  * @param sound The sound object to stop.
  */
  method stopIfPlaying(sound) {
    if ((sound != null) && sound.played()) sound.stop()
  }

  /**
  * Resumes a sound if it is currently paused.
  * @param sound The sound object to resume.
  */
  method resumeIfPaused(sound) {
    if ((sound != null) && sound.paused()) sound.resume()
  }

  /**
  * Pauses a sound if it is currently playing.
  * @param sound The sound object to pause.
  */
  method pauseIfPlaying(sound) {
    if ((sound != null) && sound.played()) sound.pause()
  }

  /**
  * Plays a sound if it is not already playing.
  * @param sound The sound object to play.
  */
  method playIfNotPlaying(sound) {
    if ((sound != null) && !sound.played()) sound.play()
  }

  /**
  * Stops all game sounds, including background, win, and lose music.
  */
  method quitAllSounds() {
    self.quitRiverSound()
    self.quitWonMusic()
    self.quitLoseMusic()
    self.quitAmbientMusic()
  }
  
}