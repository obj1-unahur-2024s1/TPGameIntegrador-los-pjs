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
	
	override method configurar(){
		game.clear()
		game.height(14)
		game.width(10)
		juego.dibujarMeta()
		game.addVisualCharacter(sapo)
		juego.agregarTroncos()
		juego.agregarVehiculos()
		juego.verificarSiChoco()
		juego.vidas(cantVidas)
	}
}

const nivelUno = new NivelConfig(cantVidas = 3)

const nivelDos = new NivelConfig(cantVidas = 1)