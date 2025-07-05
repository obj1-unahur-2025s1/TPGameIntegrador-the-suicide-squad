/**
* Holds constant configuration values and resources used throughout the game,
* such as game dimensions, asset filenames, sound files, and messages.
*/
object constants {
  const property alwaysWin = false
  const property white = "ffffffff" 
  const property gameTitle = "Frogger: Cross the river"
  const property gameCellSize = 80
  const property gameWidth = 20
  const property gameHeight = 9
  const property riverSound = "river-sound.mp3"
  const property frogImage = "frog3.png"
  const property logLongImage = "log1-1.png"
  const property logShortImage = "log2.png"
  const property maxLevel = 3
  const property boardGround = "bg-river.png"
  const property checkFrogTickInterval = 150
  const property moveLogsTickInterval = 450
  const property welcomeScreen = "welcome6.png"
  const property wonScreen = "won.png"
  const property loseScreen = "lose.png"
  const property pauseScreen = "pausa2.png" 
  const property croackSound = "croack1.mp3"
  const property loseSound = "lose1.mp3"
  const property nextLevelSound = "next-level.mp3"
  const property waterFallSound = "water-fall.mp3"
  const property wonSound = "won.mp3"
  const property pointsCounterBadge = "points-badge.png"
  
  method lifeCounterImages() {
    const dic = new Dictionary()
    dic.put(3, "frog-life-3-2.png")
    dic.put(2, "frog-life-2.png")
    dic.put(1, "frog-life-1.png")
    return dic
  }

  method levelCounterImages() {
    const dic = new Dictionary()
    dic.put(1, "level-1.png")
    dic.put(2, "level-2.png")
    dic.put(3, "level-3.png")
    return dic
  }
}