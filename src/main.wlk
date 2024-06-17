import wollok.game.*
import pantallas.*
import niveles.*

object juego{//Configurar el tablero y agregar todos los objetos visuales + hacer que interactuen

	var property vidas
	
	method restarVida(){
		vidas -= 1
	}
	
	method ejecutar(){
		game.clear()
		game.height(14)
	  	game.width(10)
	  	game.title("Frogger")
	  	game.boardGround("fondo2.png")
	  	game.addVisual(menu)
	  	keyboard.enter().onPressDo{nivelUno.configurar()}
	  	keyboard.i().onPressDo{instruccionesPantalla.mostrar()}
	  	
	}

	method dibujarMeta(){
		const lineaDeMeta = [new LineaDeMeta(position =  game.at(2,13)),
						     new LineaDeMeta(position =  game.at(5,13)),
						     new LineaDeMeta(position =  game.at(8,13))]

		lineaDeMeta.forEach { vehiculo => game.addVisual(vehiculo)}
	}
	
	method agregarVehiculos(){
		const vehiculos = [new Auto(position = game.at(4,4),estaEnLadoIzq = true),
						   new Auto(position = game.at(7,6),estaEnLadoIzq = false)]
		vehiculos.forEach { vehiculo => 
		game.addVisual(vehiculo)
		game.onTick(1000, "mov", {vehiculo.moverse()})
		game.onTick(1000, "verificacion", {vehiculo.verificarSiLlegoAlBorde()})
		}	
	}
	
	method gameOver(){
		self.restarVida()
        if(self.vidas() == 0){
            derrotaPantalla.mostrar()
        }
        
    }	
	
	method verificarSiChoco(){
        game.onCollideDo(sapo, { x =>
              x.reiniciarPosicionDelSapo()
            if(x.esAuto()){
                self.gameOver()
            }
          })
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
  override method image() = "rana.png"
}

class LineaDeMeta inherits ObjetoVisual{//Meta final
	override method image() = "meta.png"
	
	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  }
  

  
}

class Auto inherits ObjetoMovible{//Obstaculos 
	override method image() = "autoAzul.png"	
	
	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
 	}
 	method verificarSiLlegoAlBorde(){
         if(self.position().x() == -1){
             position = game.at(game.width() - 1,self.position().y())
         }if(self.position().x() >= game.width()){
             position = game.at(0,self.position().y())
         }
     }
     
     method esAuto() = true
 	
 	//method gameOver(){juego.restarVida() if (juego.vidas() == 0) derrotaPantalla.mostrar()} // Cambiar el game.clear por un posible metodo irAMenu()
}
