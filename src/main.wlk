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
    
    /*method verificarSiLlegaAMeta(){ 
        game.onCollideDo(sapo, { x =>
        	if(x.esMeta()){
        		self.victoria()
            	x.reiniciarPosicionDelSapo()
            	game.removeVisual(x)
            }
       	})
    }*/
     
    method verificarSiChoco(){
        game.onCollideDo(sapo, { x =>
        	if(x.esMeta()){
        		game.removeVisual(x)
        		self.victoria()
            	x.reiniciarPosicionDelSapo()
            	
            }
        	
            if(x.esAuto() or x.esAgua()){
            	x.reiniciarPosicionDelSapo()
                self.gameOver()
            }
            
          })
    }
    
    method agregarTroncos(){
		const troncos =[new Tronco(position = game.at(2,11), estaEnLadoIzq = true),
						new Tronco(position = game.at(3,11), estaEnLadoIzq = true),
						new Tronco(position = game.at(4,11), estaEnLadoIzq = true),
						new Tronco(position = game.at(0,12), estaEnLadoIzq = false),
						new Tronco(position = game.at(1,12), estaEnLadoIzq = false),
                        new Tronco(position = game.at(2,12), estaEnLadoIzq = false)]

    	troncos.forEach({o =>
    		if(o.estaEnLadoIzq()){
    			game.addVisual(o)
        		game.onTick(500, "arrastrar", {o.arrastrarIzquierda()})
        		game.onTick(500, "x", {o.desplazarAIzquierda()})
        		game.onTick(500, "z", {o.verificarSiLlegoAlBorde()})
    		}
    		else{
    			game.addVisual(o)
        		game.onTick(500, "arrastrar", {o.arrastrarDerecha()})
        		game.onTick(500, "a", {o.desplazarADerecha()})
        		game.onTick(500, "s", {o.verificarSiLlegoAlBorde()})
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
        		game.onTick(500, "mov", {vehiculo.desplazarAIzquierda()})
        		game.onTick(500, "verificacion", {vehiculo.verificarSiLlegoAlBorde()})
    		}
    		else{
    			game.addVisual(vehiculo)
        		game.onTick(500, "mov", {vehiculo.desplazarADerecha()})
        		game.onTick(500, "verificacion", {vehiculo .verificarSiLlegoAlBorde()})
    		} 
        
        })					   
	}
	
	method agregarMetas(){
		const lineaDeMeta = [new Meta(position =  game.at(2,13)),
						     new Meta(position =  game.at(5,13)),
						     new Meta(position =  game.at(8,13))]

		lineaDeMeta.forEach { meta => game.addVisual(meta)}
	}
	
	method agregarAgua(){
        const aguas =[new Agua(position = game.at(0,11), estaEnLadoIzq = true),
                      new Agua(position = game.at(1,11), estaEnLadoIzq = true),
                      new Agua(position = game.at(5,11), estaEnLadoIzq = true),
                      new Agua(position = game.at(6,11), estaEnLadoIzq = true),
                      new Agua(position = game.at(7,11), estaEnLadoIzq = true),
                      new Agua(position = game.at(8,11), estaEnLadoIzq = true),
                      new Agua(position = game.at(9,11), estaEnLadoIzq = true),
                      new Agua(position = game.at(10,11), estaEnLadoIzq = true),
                      new Agua(position = game.at(3,12), estaEnLadoIzq = false),
                      new Agua(position = game.at(4,12), estaEnLadoIzq = false),
                      new Agua(position = game.at(5,12), estaEnLadoIzq = false),
                      new Agua(position = game.at(6,12), estaEnLadoIzq = false),
                      new Agua(position = game.at(7,12), estaEnLadoIzq = false),
                      new Agua(position = game.at(8,12), estaEnLadoIzq = false),
                      new Agua(position = game.at(9,12), estaEnLadoIzq = false),
                      new Agua(position = game.at(10,12), estaEnLadoIzq = false)]
        aguas.forEach({a => 
            if(a.estaEnLadoIzq()){
    			game.addVisual(a)
        		game.onTick(495, "x", {a.desplazarAIzquierda()})
        		game.onTick(495, "a", {a.verificarSiLlegoAlBorde()})
    		}
    		else{
    			game.addVisual(a)
        		game.onTick(495, "z", {a.desplazarADerecha()})
        		game.onTick(495, "d", {a .verificarSiLlegoAlBorde()})
    		} 
        })
    }
}