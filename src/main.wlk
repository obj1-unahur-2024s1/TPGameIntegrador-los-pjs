import wollok.game.*
import pantallas.*
import niveles.*
import objetos.*


object juego{ //Configurar el tablero y agregar todos los objetos visuales + hacer que interactuen

	var property vidas
	
	var property maximoDeMoscas
	
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
		visualVida.actualizarVisual()
		game.say(sapo, sapo.textoDanio())
        if(self.vidas() == 0){
            derrotaPantalla.mostrar()
        }
        
    }
    
    method victoria(){ // Si el contador de moscas llega a x cantidad sale la pantalla de victoria
		self.sumarMoscaConseguida()
        if(self.contadorDeMoscas() == (maximoDeMoscas+1)){
            victoriaPantalla.mostrar()
        }
        
    }
     
    method verificarColision(){ // Verifica la colision con los distintos objetos
        game.onCollideDo(sapo, { x =>
            if(x.esMosca() or x.esCorona()){
                self.victoria()
                if (contadorDeMoscas == maximoDeMoscas){ x.reiniciarPosicionDelSapo() game.removeVisual(mosca) self.agregarCorona()}
                if(contadorDeMoscas < maximoDeMoscas and maximoDeMoscas > contadorDeMoscas){x.reaparecerAlAzar() x.reiniciarPosicionDelSapo()}  
            }
            if(x.esObstaculo()){self.gameOver() x.reiniciarPosicionDelSapo()}
          })
    }
	
	method agregarVehiculos(velocidad){ // "autoRojo.png" "autoAzul.png" "autoNegro.png"
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
        		game.onTick(velocidad, "mov", {vehiculo.desplazarAIzquierda()})
    		}
    		else{    			
        		game.onTick(velocidad, "mov", {vehiculo.desplazarADerecha()})        		
    		}
    		game.addVisual(vehiculo)
    		game.onTick(velocidad, "verificacion", {vehiculo .verificarSiLlegoAlBorde()})        
        })					   
	}
	
	method agregarCocodrilos(velocidad, dificil){ // Crea los cocodrilos y agrega el visual al tablero
		 
		if(not dificil){ 
		const cocodrilos =
			[new Cocodrilo(position = game.at(0,12),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(1,13),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(2,14),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(3,15),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(4,16),estaEnLadoIzq = true, image = "cocodrilo.png"),
			
			new Cocodrilo(position = game.at(7,12),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(8,13),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(9,14),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(10,15),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(11,16),estaEnLadoIzq = true, image = "cocodrilo.png")]
						   
    	cocodrilos.forEach({cocodrilo =>
    		if(cocodrilo.estaEnLadoIzq()){
        		game.onTick(velocidad, "mov", {cocodrilo.desplazarAIzquierda()})
    		}
    		else{    			
        		game.onTick(velocidad, "mov", {cocodrilo.desplazarADerecha()})        		
    		}
    		game.addVisual(cocodrilo)
    		game.onTick(velocidad, "verificacion", {cocodrilo .verificarSiLlegoAlBorde()})        
        })
        }else{
		const cocodrilos =
			[new Cocodrilo(position = game.at(0,12),estaEnLadoIzq = false, image = "cocodriloInvertido.png"),
			new Cocodrilo(position = game.at(1,13),estaEnLadoIzq = false, image = "cocodriloInvertido.png"),
			new Cocodrilo(position = game.at(2,14),estaEnLadoIzq = false, image = "cocodriloInvertido.png"),
			new Cocodrilo(position = game.at(3,15),estaEnLadoIzq = false, image = "cocodriloInvertido.png"),
			new Cocodrilo(position = game.at(4,16),estaEnLadoIzq = false, image = "cocodriloInvertido.png"),
			
			new Cocodrilo(position = game.at(9,12),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(8,13),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(7,14),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(6,15),estaEnLadoIzq = true, image = "cocodrilo.png"),
			new Cocodrilo(position = game.at(5,16),estaEnLadoIzq = true, image = "cocodrilo.png")]
						   
    	cocodrilos.forEach({cocodrilo =>
    		if(cocodrilo.estaEnLadoIzq()){
        		game.onTick(velocidad, "mov", {cocodrilo.desplazarAIzquierda()})
    		}
    		else{    			
        		game.onTick(velocidad, "mov", {cocodrilo.desplazarADerecha()})        		
    		}
    		game.addVisual(cocodrilo)
    		game.onTick(velocidad, "verificacion", {cocodrilo .verificarSiLlegoAlBorde()})        
        })        	
        }					   
	}
	
	method agregarMosca(){ // Crea la mosca y agrega el visual al tablero
		mosca.reaparecerAlAzar()
		game.addVisual(mosca)
	}
	method agregarCorona(){ // Agrega el visual de la corona al tablero
		game.addVisual(corona)
	}
}