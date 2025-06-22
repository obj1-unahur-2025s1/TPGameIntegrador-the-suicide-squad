import src.service.GameService.*
import wollok.game.*
import src.config.appConfig.*

object setup {
  const gameService = new GameService()
  
  method main() {
    appConfig.initialize()
    gameService.mainSetup()
  }
}