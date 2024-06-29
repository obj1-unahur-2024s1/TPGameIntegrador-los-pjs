import wollok.game.*
import main.*
import pantallas.*
import objetos.*


class Nivel{
	method configurar(){
		game.clear()
		game.height(18)
	  	game.width(14)
	}
}

class NivelConfig inherits Nivel{
	
	var property maxDeMoscas
	var property cantVidas
	var property velocidadObstaculos
	var property modoDificil
	const property reinicioContadorMetas = 0
	
	override method configurar(){
        game.clear()
        game.height(18)
        game.width(14)
        sapo.position(game.at(6,0))
        game.addVisualCharacter(sapo)
        visualVida.actualizarVisual()
        game.addVisual(visualVida)
        game.addVisual(moscasRestantes)
        juego.vidas(cantVidas)
        juego.maximoDeMoscas(maxDeMoscas)
        juego.contadorDeMoscas(reinicioContadorMetas)
        juego.agregarMosca()
        juego.agregarVehiculos(velocidadObstaculos)
        juego.agregarCocodrilos(velocidadObstaculos, modoDificil)
        juego.verificarColision()
    }
}

const nivelUno = new NivelConfig(cantVidas = 3, maxDeMoscas = 5, velocidadObstaculos = 300, modoDificil = false)

const nivelDos = new NivelConfig(cantVidas = 1, maxDeMoscas = 10, velocidadObstaculos = 200, modoDificil = true)