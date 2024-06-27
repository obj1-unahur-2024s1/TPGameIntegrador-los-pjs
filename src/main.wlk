import wollok.game.*
import pantallas.*
import niveles.*
import obstaculos.*


object juego{//Configurar el tablero y agregar todos los objetos visuales + hacer que interactuen

	var property vidas
	
	var property metasContador = 0
	
	method restarVida(){
		vidas -= 1
	}
	
	method sumarMetaConseguida(){
		metasContador += 1
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
        if(self.metasContador() == 3){
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
		const troncos = [new Tronco(position = game.at(2,11), estaEnLadoIzq = true),
							new Tronco(position = game.at(3,11), estaEnLadoIzq = true),
							new Tronco(position = game.at(4,11), estaEnLadoIzq = true),
							new Tronco(position = game.at(0,12), estaEnLadoIzq = false),
							new Tronco(position = game.at(1,12), estaEnLadoIzq = false),
                        	new Tronco(position = game.at(2,12), estaEnLadoIzq = false)]

    	troncos.forEach({o =>
    		if(o.estaEnLadoIzq()){
    			game.addVisual(o)
        		game.onTick(1000, "arrastrar", {o.arrastrarIzquierda()})
        		game.onTick(1000, "mov", {o.desplazarAIzquierda()})
        		game.onTick(1000, "verificacion", {o.verificarSiLlegoAlBorde()})
    		}
    		else{
    			game.addVisual(o)
        		game.onTick(1000, "arrastrar", {o.arrastrarDerecha()})
        		game.onTick(1000, "mov", {o.desplazarADerecha()})
        		game.onTick(1000, "verificacion", {o.verificarSiLlegoAlBorde()})
    		} 
        
        })
	}
	
	method agregarVehiculos(){ // "autoRojo.png" "autoAzul.png" "autoNegro.png"
		const vehiculos = [new Auto(position = game.at(0,1),estaEnLadoIzq = true, image = "autoRojo.png"),
						   new Auto(position = game.at(6,2),estaEnLadoIzq = false, image = "autoAzulInvertido.png"),
						   new Auto(position = game.at(9,3),estaEnLadoIzq = true, image = "autoNegro.png"),
						   new Auto(position = game.at(3,4),estaEnLadoIzq = false, image = "autoRojoInvertido.png"),
						   new Auto(position = game.at(8,5),estaEnLadoIzq = true, image = "autoAzul.png"),
						   new Auto(position = game.at(2,6),estaEnLadoIzq = false, image = "autoNegroInvertido.png"),
						   new Auto(position = game.at(4,7),estaEnLadoIzq = true, image = "autoRojo.png"),
						   new Auto(position = game.at(1,8),estaEnLadoIzq = false, image = "autoAzulInvertido.png"),
						   new Auto(position = game.at(5,9),estaEnLadoIzq = true, image = "autoNegro.png")]
						   
    	vehiculos.forEach({vehiculo =>
    		if(vehiculo.estaEnLadoIzq()){
    			game.addVisual(vehiculo)
        		game.onTick(1000, "mov", {vehiculo.desplazarAIzquierda()})
        		game.onTick(1000, "verificacion", {vehiculo.verificarSiLlegoAlBorde()})
    		}
    		else{
    			game.addVisual(vehiculo)
        		game.onTick(1000, "mov", {vehiculo.desplazarADerecha()})
        		game.onTick(1000, "verificacion", {vehiculo .verificarSiLlegoAlBorde()})
    		} 
        
        })					   
	}
	
	method agregarMetas(){
		const lineaDeMeta = [new Meta(position =  game.at(2,13)),
						     new Meta(position =  game.at(5,13)),
						     new Meta(position =  game.at(8,13))]

		lineaDeMeta.forEach { meta => game.addVisual(meta)}
	}
}