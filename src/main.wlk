import wollok.game.*
import pantallas.*
import niveles.*
import obstaculos.*


object juego{ //Configurar el tablero y agregar todos los objetos visuales + hacer que interactuen

	var property vidas
	
	var property contadorDeMoscas = 0
	
	method restarVida(){ // Disminuye en 1 las vidas
		vidas -= 1
	}
	
	method sumarMoscaConseguida(){ // Incrementa en 1 el contador de moscas
		contadorDeMoscas += 1
	}
	
	method ejecutar(){ // Ejecuta el juego
		game.clear()
		game.height(18)
	  	game.width(14)
	  	game.title("Frogger")
	  	game.boardGround("fondo.png")
	  	game.addVisual(menu)
	  	keyboard.enter().onPressDo{nivelUno.configurar()}
	  	keyboard.i().onPressDo{instruccionesPantalla.mostrar()}
	  	keyboard.p().onPressDo{nivelDos.configurar()}
	}
	
	method gameOver(){ // Si las vidas llegan a 0 sale la pantalla de derrota
		self.restarVida()
        if(self.vidas() == 0){
            derrotaPantalla.mostrar()
        }
        
    }
    
    method victoria(){ // Si el contador de moscas llega a x cantidad sale la pantalla de victoria
		self.sumarMoscaConseguida()
        if(self.contadorDeMoscas() == 100){
            victoriaPantalla.mostrar()
        }
        
    }
     
    method verificarColision(){ // Verifica la colision con los distintos objetos
        game.onCollideDo(sapo, { x =>
            if(x.esMosca()){
                self.victoria()
                x.reaparecerAlAzar()
            }
            if(x.esObstaculo()){             
                self.gameOver()
            }
            x.reiniciarPosicionDelSapo()
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
						   new Auto(position = game.at(5,9),estaEnLadoIzq = true, image = "autoNegro.png"),
						   new Auto(position = game.at(5,10),estaEnLadoIzq = false, image = "autoRojoInvertido.png")]
						   
    	vehiculos.forEach({vehiculo =>
    		if(vehiculo.estaEnLadoIzq()){
        		game.onTick(300, "mov", {vehiculo.desplazarAIzquierda()})
    		}
    		else{    			
        		game.onTick(300, "mov", {vehiculo.desplazarADerecha()})        		
    		}
    		game.addVisual(vehiculo)
    		game.onTick(300, "verificacion", {vehiculo .verificarSiLlegoAlBorde()})        
        })					   
	}
	
	method agregarCocodrilos(){ // Crea los cocodrilos y agrega el visual al tablero
		const cocodrilos =[new Cocodrilo(position = game.at(0,12),estaEnLadoIzq = true, image = "autoRojo.png"),
			new Cocodrilo(position = game.at(1,13),estaEnLadoIzq = true, image = "autoRojo.png"),
			new Cocodrilo(position = game.at(2,14),estaEnLadoIzq = true, image = "autoRojo.png"),
			new Cocodrilo(position = game.at(3,15),estaEnLadoIzq = true, image = "autoRojo.png"),
			new Cocodrilo(position = game.at(4,16),estaEnLadoIzq = true, image = "autoRojo.png")]
						   
    	cocodrilos.forEach({cocodrilo =>
    		if(cocodrilo.estaEnLadoIzq()){
        		game.onTick(300, "mov", {cocodrilo.desplazarAIzquierda()})
    		}
    		else{    			
        		game.onTick(300, "mov", {cocodrilo.desplazarADerecha()})        		
    		}
    		game.addVisual(cocodrilo)
    		game.onTick(300, "verificacion", {cocodrilo .verificarSiLlegoAlBorde()})        
        })					   
	}
	
	method agregarMosca(){ // Crea la mosca y agrega el visual al tablero
		const mosca = new Mosca(position =  game.center())
		mosca.reaparecerAlAzar()
		game.addVisual(mosca)
	}
}