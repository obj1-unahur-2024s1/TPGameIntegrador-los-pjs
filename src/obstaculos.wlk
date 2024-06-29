import wollok.game.*
import main.*
import pantallas.*
import niveles.*

object sapo {
    var property position = game.at(5,0)

    var property image = "rana.png"

    method desplazarADerecha(){
        self.position(self.position().right(1))
    }
    
    method desplazarAIzquierda(){
        self.position(self.position().left(1))
    }
    
}

class Obstaculo{
	//var property position
	
	//var property image
	
	method esAuto()
    
    method esMeta()
    
    method esAgua()
    
    method esTronco()
    
}





class Tronco inherits Obstaculo{
	var property position
	
	var property image = "tronco.png"
    
    const property estaEnLadoIzq
    
    override method esAuto() = false
    
    override method esMeta()= false
    
    override method esAgua() = false
    
    override method esTronco() = true

    method desplazarADerecha(){
        self.position(self.position().right(1))
    }
    
    method desplazarAIzquierda(){
        self.position(self.position().left(1))
    }

    method arrastrarDerecha(){ // este
        if(self.position() == sapo.position() /*and sapo.position().y() == self.position().y()*/){
            sapo.desplazarADerecha()
        }
    }
    
    method arrastrarIzquierda(){
        if(self.position() == sapo.position() /*and sapo.position().y() == self.position().y()*/){
            sapo.desplazarAIzquierda()
        }
    }
     
    method verificarSiLlegoAlBorde(){
         if(self.position().x() == -1){
             position = game.at(game.width() - 1,self.position().y())
         }if(self.position().x() >= game.width()){
             position = game.at(0,self.position().y())
         }
     }
     
    // method reiniciarPosicionDelSapo(){}
}

class Auto inherits Obstaculo{
	
	var property position
	
	var property image
    
    const property estaEnLadoIzq
    
    override method esAuto() = true
    
    override method esMeta()= false
    
    override method esAgua() = false
    
    override method esTronco() = false
	
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

class Meta inherits Obstaculo{//Meta final

	var property position
	
	var property image = "metaDesactivada.png"

	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  	}
  	
    override method esAuto() = false
    
    override method esMeta()= true
    
    override method esAgua() = false
    
    override method esTronco() = false
}

class Agua inherits Obstaculo{//Objeto Invisible

	var property position
	
	const property estaEnLadoIzq
    
    override method esAuto() = false
    
    override method esMeta()= false
    
    override method esAgua() = true
    
    override method esTronco() = false
    

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