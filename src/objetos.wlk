import wollok.game.*
import main.*
import pantallas.*
import niveles.*

object sapo {
    var property position = game.at(6,0)

    var property image = "rana.png"
    
    method textoDanio(){
    	return "Ouch!"
    }    
}

class Obstaculo{
	var property image
	
	var property position
	
	const property estaEnLadoIzq
	
    method esObstaculo()
    
    method esMosca()= false
    
    method esCorona()= false
    
    method desplazarADerecha(){
        self.position(self.position().right(1))
    }
    
    method desplazarAIzquierda(){
        self.position(self.position().left(1))
    }
	
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
    
}

class Auto inherits Obstaculo{	
    
    override method esObstaculo()= true
}

class Cocodrilo inherits Obstaculo{
    
	override method esObstaculo()= true
}

object mosca {

	var property position
	
	var property image = "mosca.png"
	
	method esObstaculo() = false
    
    method esMosca()= true
    
    method esCorona()= false

	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  	}
  	
  	method reaparecerAlAzar() {
        const x = 1.randomUpTo(game.width()-1).truncate(0)
        const y = 4.randomUpTo(game.height()-1).truncate(0)
        position = game.at(x,y)
    }
}

object corona { //Meta final

	var property position =  game.at(7,17)
	
	var property image = "corona.png"
	
	method esObstaculo() = false
    
    method esMosca()= false
    
    method esCorona()= true
    
    method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  	}
}

class Estadisticas{
    method position()

    method esObstaculo() = false

    method esMosca()= false

    method esCorona()= false

}

object visualVida inherits Estadisticas{
    var property image = "vidas_3.png"

    override method position() = game.at(0,17)

    method actualizarVisual(){
        if (juego.vidas()== 3) image = "vidas_3.png"
        if (juego.vidas()== 2) image = "vidas_2.png"
        if (juego.vidas()== 1) image = "vidas_1.png" 
    }
}

object moscasRestantes inherits Estadisticas{
    override method position() = game.at(2,17)

    method text() = "Moscas restantes: " + (juego.maximoDeMoscas() - juego.contadorDeMoscas())

    method textColor() = "fc00ff"

}