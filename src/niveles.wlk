import wollok.game.*
import main.*
import pantallas.*
import objetos.*


class NivelConfig{
	
	var property maxDeMoscas
	var property cantVidas
	var property velocidadObstaculos
	const property reinicioContadorMetas = 0
	
	method configurar(){
        game.clear()
		game.height(18)
	  	game.width(14)
        juego.vidas(cantVidas)
        juego.maximoDeMoscas(maxDeMoscas)
        juego.contadorDeMoscas(reinicioContadorMetas)
        sapo.position(game.at(6,0))
        game.addVisualCharacter(sapo)
        game.addVisual(visualVida)
        game.addVisual(moscasRestantes)
        
        
                
        juego.agregarMosca()
        self.agregarVehiculos(velocidadObstaculos)
        self.agregarCocodrilos(velocidadObstaculos)
        
        
        juego.verificarColision()
    }
    
    method agregarCocodrilos(velocidad){}
    
    method agregarVehiculos(velocidad){ // "autoRojo.png" "autoAzul.png" "autoNegro.png"
		const vehiculos = [new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),1), color = "Rojo"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),2), color = "Azul"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),3), color = "Negro"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),4), color = "Rojo"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),5), color = "Azul"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),6), color = "Negro"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),7), color = "Rojo"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),8), color = "Azul"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),9), color = "Negro"),
						   new Auto(posicionInicial = game.at(0.randomUpTo(game.width()).truncate(0),10), color = "Rojo")]						   
    	vehiculos.forEach({vehiculo =>
    		game.addVisual(vehiculo)
    		game.onTick(velocidad,"recorrido", {vehiculo.recorrer()})
    		game.onTick(velocidad, "verificacion", {vehiculo .verificarSiLlegoAlBorde()})        
        })					   
	}
}

class ConfigModoNormal inherits NivelConfig{
	
	override method agregarCocodrilos(velocidad){
	
		const cocodrilos =
			[new Cocodrilo(posicionInicial = game.at(0,12)),
			new Cocodrilo(posicionInicial = game.at(1,13)),
			new Cocodrilo(posicionInicial = game.at(2,14)),
			new Cocodrilo(posicionInicial = game.at(3,15)),
			new Cocodrilo(posicionInicial = game.at(4,16)),
			
			new Cocodrilo(posicionInicial = game.at(7,12)),
			new Cocodrilo(posicionInicial = game.at(8,13)),
			new Cocodrilo(posicionInicial = game.at(9,14)),
			new Cocodrilo(posicionInicial = game.at(10,15)),
			new Cocodrilo(posicionInicial = game.at(11,16))]
									   
    	cocodrilos.forEach({c =>
    		game.addVisual(c)
    		game.onTick(velocidad,"recorrido", {c.recorrer()})
    		game.onTick(velocidad, "verificacion", {c .verificarSiLlegoAlBorde()})        
        })					   
	}
}

class ConfigModoDificil inherits NivelConfig{
	
	override method agregarCocodrilos(velocidad){
	
		const cocodrilos =
			[new Cocodrilo(posicionInicial = game.at(2,12)),
			new Cocodrilo(posicionInicial = game.at(3,13)),
			new Cocodrilo(posicionInicial = game.at(4,14)),
			new Cocodrilo(posicionInicial = game.at(5,15)),
			new Cocodrilo(posicionInicial = game.at(6,16)),
			
			new Cocodrilo(posicionInicial = game.at(11,12)),
			new Cocodrilo(posicionInicial = game.at(10,13)),
			new Cocodrilo(posicionInicial = game.at(9,14)),
			new Cocodrilo(posicionInicial = game.at(8,15)),
			new Cocodrilo(posicionInicial = game.at(7,16))]
									   
    	cocodrilos.forEach({c =>
    		game.addVisual(c)
    		game.onTick(velocidad,"recorrido", {c.recorrer()})
    		game.onTick(velocidad, "verificacion", {c .verificarSiLlegoAlBorde()})        
        })					   
	}
}

const modoNormal = new ConfigModoNormal(cantVidas = 3, maxDeMoscas = 5, velocidadObstaculos = 300)

const modoDificil = new ConfigModoDificil(cantVidas = 1, maxDeMoscas = 10, velocidadObstaculos = 200)