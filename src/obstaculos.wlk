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
    
}

class Tronco{
    var property position

    var property image = "tronco.png"

    method desplazarADerecha(){
        self.position(self.position().right(1))
    }
    
    method verificarSiLlegoAlBorde(){
         if(self.position().x() == -1){
             position = game.at(game.width() - 1,self.position().y())
         }if(self.position().x() >= game.width()){
             position = game.at(0,self.position().y())
         }
     }

    method arrastrar(){
        if(self.position() == sapo.position() and sapo.position().y() == self.position().y()){
            sapo.desplazarADerecha()
        }
    }
}

class Auto{
	
    var property position
    const estaEnLadoIzq

    var property image = "autoAzul.png"

    method moverse() = if(estaEnLadoIzq) game.onTick(2000, "moverDer", position = position.right(1))
	else game.onTick(2000, "moverIzq", position = position.left(1))
	
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
}

class Meta{//Meta final
	var property position
	var property image = "metaDesactivada.png"

	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  	}
  	
  	method esMeta()= true
}