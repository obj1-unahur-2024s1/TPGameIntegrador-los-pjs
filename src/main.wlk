import wollok.game.*
import pantallas.*
import niveles.*
import objetos.*


object juego{ //Configurar el tablero y agregar todos los objetos visuales + hacer que interactuen

	var property vidas
	
	var property maximoDeMoscas = 0
	
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
	  	keyboard.enter().onPressDo{modoNormal.configurar()}
	  	keyboard.i().onPressDo{pantallaInstrucciones.mostrar()}
	  	keyboard.p().onPressDo{modoDificil.configurar()}
	}
	
	method gameOver(){ // Si las vidas llegan a 0 sale la pantalla de derrota
		self.restarVida()
		game.say(sapo, sapo.textoDanio())
        if(self.vidas() == 0){
            pantallaDerrota.mostrar()
        }
        
    }
    
    method victoria(){ // Si el contador de moscas llega a x cantidad sale la pantalla de victoria
		self.sumarMoscaConseguida()
        if(self.contadorDeMoscas() == (maximoDeMoscas+1)){
            pantallaVictoria.mostrar()
        }
        
    }
     
    method verificarColision(){ // Verifica la colision con los distintos objetos
        game.onCollideDo(sapo, { x => x.colisionConRana() })
    }
	
	method agregarMosca(){ // Crea la mosca y agrega el visual al tablero
		mosca.reaparecerAlAzar()
		game.addVisual(mosca)
	}
	method agregarCorona(){ // Agrega el visual de la corona al tablero
		game.addVisual(corona)
	}
}