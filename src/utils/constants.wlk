/**
* Holds constant configuration values and resources used throughout the game,
* such as game dimensions, asset filenames, sound files, and messages.
*/
object constants {
  // === Game Behavior Settings ===
  const property alwaysWin = false
  const property white = "ffffffff"

  // === Display and Layout ===
  const property gameTitle = "Frogger: Cross the river"
  const gameWidthPx = 1600
  const gameHeightPx = 720
  const property baseGameWidth = 20
  const property baseGameHeight = 9
  const property gameCellSize = 10
  const property scaleFactor = 80 / gameCellSize
  const property gameWidth = gameWidthPx / gameCellSize
  const property gameHeight = gameHeightPx / gameCellSize
  const property logWidthInCells = 8
  const property logHeightInCells = 8

  // === Board and Visual Resources ===
  const property boardGround = "bg-river.png"
  const property welcomeScreen = "welcome6.png"
  const property wonScreen = "won.png"
  const property loseScreen = "lose.png"
  const property pauseScreen = "pausa2.png"
  const property frogImage = "frog3.png"
  const property logLongImage = "log1-1.png"
  const property logShortImage = "log2.png"
  const property pointsCounterBadge = "points-badge.png"

  // === HUD Base Positions (in grid units) ===
  const property baseLevelCounterX = 0
  const property basePointsCounterX = 2
  const property baseLifeCounterX = baseGameWidth - 2 
  const property baseHudY = baseGameHeight - 1         

  // === HUD Scaled Positions (in grid units after applying scaleFactor) ===
  const property levelCounterX = baseLevelCounterX * scaleFactor
  const property pointsCounterX = basePointsCounterX * scaleFactor
  const property lifeCounterX = baseLifeCounterX * scaleFactor
  const property hudY = baseHudY * scaleFactor

  // === Audio Resources ===
  const property riverSound = "river-sound.mp3"
  const property croackSound = "croack1.mp3"
  const property loseSound = "lose1.mp3"
  const property nextLevelSound = "next-level.mp3"
  const property waterFallSound = "water-fall.mp3"
  const property wonSound = "won.mp3"
  const property welcomeMusic = "welcome.mp3"

  // === Bonus Logs Resources ===
  const property bonusLogFitoImage = "fito.png"
  const property bonusLogFitoSound = "fito.mp3"
  const property bonusLogDogImage = "perro.png"
  const property bonusLogDogSound = "perro.mp3"
  const property bonusLogCfImage = "cf-log.png"
  const property bonusLogCfSound = "cf-1.mp3"

  // === Timers and Tick Intervals (in ms) ===
  const property checkFrogTickInterval = 150 
  const property moveLogsTickInterval = 80 
  const property waterFallTtl = 4000
  const property nextLevelTtl = 1500
  const property croackTtl = 1500

  // === Level and Gameplay Configuration ===
  const property maxLevel = 3
  const property baseLogRow1 = 6
  const property baseLogRow2 = 4
  const property baseLogRow3 = 2
  
  // === Helper Methods for Scaling ===
  method scaledRow(row) = row * scaleFactor
  method scaledX(x) = x * scaleFactor  

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