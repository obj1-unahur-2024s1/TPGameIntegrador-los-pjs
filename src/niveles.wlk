import wollok.game.*
import main.*
import pantallas.*
import obstaculos.*


class Nivel{
	method configurar(){
		game.clear()
		game.height(14)
		game.width(10)
	}
}

class NivelConfig inherits Nivel{
	
	var property cantVidas
	var property contadorMetas
	
	override method configurar(){
		game.clear()
		game.height(14)
		game.width(10)
		juego.agregarMetas()
		game.addVisualCharacter(sapo)
		juego.agregarTroncos()
		juego.agregarVehiculos()
		juego.verificarSiChoco()
		juego.verificarSiLlegaAMeta()
		juego.vidas(cantVidas)
		juego.metasCompletadas(contadorMetas)
		
	}
}

const nivelUno = new NivelConfig(cantVidas = 3, contadorMetas= 0)

const nivelDos = new NivelConfig(cantVidas = 1, contadorMetas= 0)