import wollok.game.*
import pantallas.*
import niveles.*
import obstaculos.*


object juego{//Configurar el tablero y agregar todos los objetos visuales + hacer que interactuen

	var property vidas
	
	var property metasCompletadas = 0
	
	method restarVida(){
		vidas -= 1
	}
	
	method sumarMetaConseguida(){
		metasCompletadas += 1
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
	  	keyboard.p().onPressDo{nivelDos.configurar()}
	}
	
	method gameOver(){
		self.restarVida()
        if(self.vidas() == 0){
            derrotaPantalla.mostrar()
        }
        
    }
    
    method victoria(){
		self.sumarMetaConseguida()
        if(self.metasCompletadas() == 3){
            victoriaPantalla.mostrar()
        }
        
    }
    
    method verificarSiLlegaAMeta(){ 
        game.onCollideDo(sapo, { x =>
        	if(x.esMeta()){
        		self.victoria()
            	x.reiniciarPosicionDelSapo()
            	game.removeVisual(x)
            }
       	})
    }
     
    method verificarSiChoco(){
        game.onCollideDo(sapo, { x => 
            if(x.esAuto()){
            	x.reiniciarPosicionDelSapo()
                self.gameOver()
            }
        })
    }
    
    method agregarTroncos(){
		const obstucalos = [new Tronco(position = game.at(3,11)),
                        	new Tronco(position = game.at(0,12))]

    	obstucalos.forEach({o => 
        game.addVisual(o)
        game.onTick(1000, "sx", {o.arrastrar()})
        game.onTick(1000, "xx", {o.desplazarADerecha()})
        game.onTick(1000, "verificacion", {o.verificarSiLlegoAlBorde()})
        })
	}
	
	method agregarVehiculos(){
		const vehiculos = [new Auto(position = game.at(0,1),estaEnLadoIzq = true),
						   new Auto(position = game.at(6,2),estaEnLadoIzq = false),
						   new Auto(position = game.at(9,3),estaEnLadoIzq = true),
						   new Auto(position = game.at(3,4),estaEnLadoIzq = false),
						   new Auto(position = game.at(8,5),estaEnLadoIzq = true),
						   new Auto(position = game.at(2,6),estaEnLadoIzq = false),
						   new Auto(position = game.at(4,7),estaEnLadoIzq = true),
						   new Auto(position = game.at(1,8),estaEnLadoIzq = false),
						   new Auto(position = game.at(5,9),estaEnLadoIzq = true)]
		vehiculos.forEach { vehiculo => 
		game.addVisual(vehiculo)
		game.onTick(1000, "mov", {vehiculo.moverse()})
		game.onTick(1000, "verificacion", {vehiculo.verificarSiLlegoAlBorde()})
		}	
	}
	
	method agregarMetas(){
		const lineaDeMeta = [new Meta(position =  game.at(2,13)),
						     new Meta(position =  game.at(5,13)),
						     new Meta(position =  game.at(8,13))]

		lineaDeMeta.forEach { meta => game.addVisual(meta)}
	}
}