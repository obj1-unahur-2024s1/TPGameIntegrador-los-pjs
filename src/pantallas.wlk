import wollok.game.*
import main.*

class Pantalla{
	
	var property image
	var property position
}

const menu = new Pantalla(image="menu.png", position=game.origin())
const pantallaInstrucciones =  new Pantalla(image="instrucciones.png", position=game.origin())
const pantallaVictoria =  new Pantalla(image="victoria.png", position=game.origin())
const pantallaDerrota =  new Pantalla(image="derrota.png", position=game.origin())

object instruccionesPantalla{
	
	method mostrar(){
		game.clear()
		game.height(18)
	  	game.width(14)
		game.addVisual(pantallaInstrucciones)
		keyboard.m().onPressDo{juego.ejecutar()}
	}
}

object derrotaPantalla{
	
	method mostrar(){
		game.clear()
		game.height(18)
	  	game.width(14)
		game.addVisual(pantallaDerrota)
		keyboard.enter().onPressDo{juego.ejecutar()}
	}
}

object victoriaPantalla{
	
	method mostrar(){
		game.clear()
		game.height(18)
	  	game.width(14)
		game.addVisual(pantallaVictoria)
		keyboard.enter().onPressDo{juego.ejecutar()}
	}
}
