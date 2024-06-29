import wollok.game.*
import main.*
import pantallas.*
import niveles.*

object sapo {
    var property position = game.at(5,0)

    var property image = "rana.png"    
}

class Obstaculo{
	
	var property position
	
	const property estaEnLadoIzq
	
    method esObstaculo()
    
    method esMosca()
    
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
	
	var property image
    
    override method esObstaculo()= true
    
    override method esMosca()= false
}

class Cocodrilo inherits Obstaculo{
	
	var property image
    
	override method esObstaculo()= true
    
    override method esMosca()= false
}

class Mosca { //Meta final

	var property position
	
	var property image = "mosca.png"
	
	method esObstaculo() = false
    
    method esMosca()= true

	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  	}
  	
  	method reaparecerAlAzar() {
        const x = 1.randomUpTo(game.width()-1).truncate(0)
        const y = 4.randomUpTo(game.height()-1).truncate(0)
        position = game.at(x,y)
    }
}