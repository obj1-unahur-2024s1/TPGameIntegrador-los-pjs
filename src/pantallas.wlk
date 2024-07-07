import wollok.game.*
import main.*

class Pantalla{
	
	var property image
	var property position
	
	method mostrar(){
		game.clear()
		game.height(18)
	  	game.width(14)
		game.addVisual(self)		
	}
	
}

class InstruccionesPantalla inherits Pantalla{
	
	override method mostrar(){
		super()
		keyboard.m().onPressDo{juego.ejecutar()}
	}
}

class FinDePartidaPantalla inherits Pantalla{
	
	override method mostrar(){
		super()
		keyboard.enter().onPressDo{juego.ejecutar()}
	}
}

const menu = new Pantalla(image="menu.png", position=game.origin())
const pantallaInstrucciones =  new InstruccionesPantalla(image="instrucciones.png", position=game.origin())
const pantallaVictoria =  new FinDePartidaPantalla(image="victoria.png", position=game.origin())
const pantallaDerrota =  new FinDePartidaPantalla(image="derrota.png", position=game.origin())

/*object instruccionesPantalla{
	
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
}*/
