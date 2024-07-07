import wollok.game.*
import main.*
import pantallas.*
import niveles.*

object sapo {
    var property position = game.at(6,0)

    method image() = "rana.png"
    
    method textoDanio(){
    	return "Ouch!"
    }    
}

class Obstaculo{
	
	const property posicionInicial
	
	var property position = posicionInicial

	method image()
    
    method desplazarADerecha(){
        self.position(self.position().right(1))
    }
    
    method desplazarAIzquierda(){
        self.position(self.position().left(1))
    }
    
    method recorrer(){
         if(self.posicionInicial().x() < game.width() / 2){
             self.desplazarADerecha()
         }else{
             self.desplazarAIzquierda()
         }
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
     
     method colisionConRana(){
     	juego.gameOver()
     	self.reiniciarPosicionDelSapo()
     }
    
}

class Auto inherits Obstaculo{
	
	var property color	
    
    override method image()=
    if(self.posicionInicial().x() < game.width() / 2){
             "auto"+ self.color() +"Invertido.png"
         }else{
             "auto"+ self.color() +".png"
         }
     
}

class Cocodrilo inherits Obstaculo{
	
	override method image()=
    if(self.posicionInicial().x() < game.width() / 2){
             "cocodriloInvertido.png"
         }else{
             "cocodrilo.png"
         }

}

object mosca {

	var property position
	
	method image() = "mosca.png"

	method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  	}
  	
  	method reaparecerAlAzar() {
        const x = 1.randomUpTo(game.width()-1).truncate(0)
        const y = 4.randomUpTo(game.height()-1).truncate(0)
        position = game.at(x,y)
    }
    
    method colisionConRana(){
     	juego.victoria()
        if (juego.contadorDeMoscas() == juego.maximoDeMoscas()){
        	self.reiniciarPosicionDelSapo() game.removeVisual(self) juego.agregarCorona()
        }
        if (juego.contadorDeMoscas() != juego.maximoDeMoscas()){
        	self.reaparecerAlAzar() self.reiniciarPosicionDelSapo()
        } 
     }
}

object corona {

	var property position =  game.at(7,17)
	
	method image() = "corona.png"
    
    method reiniciarPosicionDelSapo(){
  		sapo.position(game.at(5,0))  
  	}
  	
  	method colisionConRana(){
     	juego.victoria()
        if (juego.contadorDeMoscas() == juego.maximoDeMoscas()){
        	self.reiniciarPosicionDelSapo() game.removeVisual(mosca) juego.agregarCorona()
        }
        if ((juego.contadorDeMoscas() < juego.maximoDeMoscas()) and (juego.maximoDeMoscas() > juego.contadorDeMoscas())){
        	mosca.reaparecerAlAzar() self.reiniciarPosicionDelSapo()
        } 
     }
}

class Estadisticas{
	
    method position()

	method colisionConRana(){}
}

object visualVida inherits Estadisticas{
    method image()= "vidas_" + juego.vidas() +".png"

    override method position() = game.at(0,17)
    
}

object moscasRestantes inherits Estadisticas{
    override method position() = game.at(2,17)

    method text() = "Moscas restantes: " + (juego.maximoDeMoscas() - juego.contadorDeMoscas())

    method textColor() = "fc00ff"
}