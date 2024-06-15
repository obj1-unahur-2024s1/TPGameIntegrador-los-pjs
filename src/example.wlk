import wollok.game.*

object juego{//Configurar el tablero y agregar todos los objetos visuales + hacer que interactuen
	method dibujarMeta(){
		const lineaDeMeta = [new LineaDeMeta(position =  game.at(0,13)),
						     new LineaDeMeta(position =  game.at(1,13)),
						     new LineaDeMeta(position =  game.at(2,13)),
						     new LineaDeMeta(position =  game.at(3,13)),
						     new LineaDeMeta(position =  game.at(4,13)),
						     new LineaDeMeta(position =  game.at(5,13)),
						     new LineaDeMeta(position =  game.at(6,13)),
						     new LineaDeMeta(position =  game.at(7,13)),
						     new LineaDeMeta(position =  game.at(8,13)),
						     new LineaDeMeta(position =  game.at(9,13))]
		lineaDeMeta.forEach { vehiculo => game.addVisual(vehiculo)}
	}
	
	method agregarVehiculos(){
		const vehiculos = [new Auto(position = game.at(0,4),estaEnLadoIzq = true),
						   new Auto(position = game.at(8,6),estaEnLadoIzq = false)]
		vehiculos.forEach { vehiculo => 
		game.addVisual(vehiculo)
		game.onTick(1000, "mov", {vehiculo.moverse()})
		}	
	}	
	
	method configurar(){
		game.height(14)
	  	game.width(10)
	  	game.cellSize(50)
	  	game.title("Juego") 	
	  	game.boardGround("fondo.jpg")	
	  	game.addVisualCharacter(sapo)  //Para que se pueda mover con las flechas	
	  	self.dibujarMeta() //Dibuja la meta final
	  	self.agregarVehiculos()	//Agrega los vehiculos al escenario
	  	game.onCollideDo(sapo, {meta => meta.reiniciarPosicionDelSapo()}) //Llegar a la meta
	}
}

class ObjetoVisual{	//Objetos que van a aparecer en la pantalla
	var property position
	method image()
}

class ObjetoMovible inherits ObjetoVisual{ //Objetos de la pantalla que se van a mover solos
	const estaEnLadoIzq
	
	method moverse() = if(estaEnLadoIzq) game.onTick(2000, "moverDer", position = position.right(1))
	else game.onTick(2000, "moverIzq", position = position.left(1))
		
	
}

object sapo inherits ObjetoVisual(position = game.at(5,0)){//Personaje del jugador
  override method image() = "wollok.png"
}

class LineaDeMeta inherits ObjetoVisual{//Meta final
	override method image() = "meta.png"
	
	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  }
}

class Auto inherits ObjetoMovible{//Obstaculos 
	override method image() = "auto.png"	
	
	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
 	}
}