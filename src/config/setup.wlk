import src.service.GameService.*
import wollok.game.*
import src.config.appConfig.*
import stateConfig.*


object setup {
  const gameService = new GameService()

  method main() {
    appConfig.initialize()
    stateConfig.startMenu()      // Arranca en menú
    gameService.showMenu()       // Muestra pantalla de menú
  }
}