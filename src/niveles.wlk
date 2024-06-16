import wollok.game.*
import main.*
import pantallas.*


class Nivel{
	method configurar(){
		game.clear()
		game.height(14)
		game.width(10)
		juego.dibujarMeta()
	}
}

class NivelConfig inherits Nivel{
	
	override method configurar(){
		game.clear()
		game.height(14)
		game.width(10)
		juego.dibujarMeta()
		game.addVisualCharacter(sapo)
		juego.agregarVehiculos()
		juego.vidas(3)
		game.onCollideDo(sapo, { x =>
	  		
	  		x.gameOver()
	  		x.reiniciarPosicionDelSapo()

	  	})
	}
}

const nivelUno = new NivelConfig()