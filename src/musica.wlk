import wollok.game.*

object musica{
	
	const musica=game.sound("ChaozFantasy.mp3")
	
	method reproducir(){
		musica.volume(0.1)
		musica.shouldLoop(true)
		game.schedule(500,{musica.play()})
	}	
}
