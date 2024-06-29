import wollok.game.*
import main.*
import pantallas.*
import obstaculos.*


class Nivel{
	method configurar(){
		game.clear()
		game.height(18)
	  	game.width(14)
	}
}

class NivelConfig inherits Nivel{
	
	var property cantVidas
	var property reinicioContadorMetas = 0
	
	override method configurar(){
		game.clear()
		game.height(18)
	  	game.width(14)
		juego.agregarMosca()
		game.addVisualCharacter(sapo)
		juego.agregarVehiculos()
		juego.agregarCocodrilos()
		juego.verificarColision()
		juego.vidas(cantVidas)
		juego.contadorDeMoscas(reinicioContadorMetas)
		
	}
}

const nivelUno = new NivelConfig(cantVidas = 3)

const nivelDos = new NivelConfig(cantVidas = 1)