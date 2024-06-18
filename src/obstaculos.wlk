import wollok.game.*
import main.*
import pantallas.*
import niveles.*

object sapo {
    var property position = game.origin()

    method image() = "rana.png"

    method desplazarADerecha(){
        self.position(self.position().right(1))
    }
    
}

class Tronco{
    var property position

    method image() = "tronco.png"

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

    method image() = "autoAzul.png"

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
	method image() = "meta.png"

	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  }
}









































/*class ObjetoVisual{	//Objetos que van a aparecer en la pantalla
	var property position
	method image()
}

object sapo inherits ObjetoVisual(position = game.at(5,0)){//Personaje del jugador
  override method image() = "rana.png"
  
  method desplazarADerecha(){
        self.position(self.position().right(1))
    }
}

class ObjetoMovible inherits ObjetoVisual{ //Objetos de la pantalla que se van a mover solos
	const estaEnLadoIzq
	
	method moverse() = if(estaEnLadoIzq) game.onTick(2000, "moverDer", position = position.right(1))
	else game.onTick(2000, "moverIzq", position = position.left(1))
}

class Auto inherits ObjetoMovible{	//Obstaculo 
	override method image() = "autoAzul.png"	
	
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

class Tronco inherits ObjetoMovible{
	override method image() = "tronco.png"

 	method verificarSiLlegoAlBorde(){
         if(self.position().x() == -1){
             position = game.at(game.width() - 1,self.position().y())
         }if(self.position().x() >= game.width()){
             position = game.at(0,self.position().y())
         }
     }
	
	method arrastrar(){
        if(self.position() == sapo.position() and sapo.position().y() == self.position().y()){
            //game.onTick(1000, "asdads", {wollok.desplazarADerecha()})
            sapo.desplazarADerecha()
            }
    }
}

class Metas inherits ObjetoVisual{//Meta final
	override method image() = "meta.png"
	
	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  } 
}
*/