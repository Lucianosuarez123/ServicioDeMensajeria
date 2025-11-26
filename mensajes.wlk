// Puntos de entrada
// Punto 1: 
// Punto 2: 
// Punto 3: 
// Punto 4: 
// Punto 5: 
// Punto 6: 

class Mensaje {
	const contenido
	var property emisor
	
	method peso() = 5 + contenido.peso() * 1.3
	
	method contiene(texto) = emisor.contiene(texto) or contenido.contiene(texto)
}

/***** Contenidos ******/

class Texto {
	const elTexto
	method peso() = elTexto.size()
	method contiene(texto) = elTexto.contains(texto)
}

class Audio {
	const duracion
	method peso() = duracion * 1.2
	method contiene(texto) = false
}

class Contacto {
	const usuario
	method peso() = 3
	method contiene(texto) = usuario.contiene(texto)
}

class Imagen {
	const alto
	const ancho
	const compresion = original
	method peso() = compresion.pixelesAEnviar(ancho * alto) * 2
	method contiene(texto) = false
}

object original {
	method pixelesAEnviar(cant) = cant
}

class Variable {
	const porcentaje
	method pixelesAEnviar(cant) = cant * porcentaje
}

object maxima {
	method pixelesAEnviar(cant) = cant.min(10000)
}

class GIF inherits Imagen {
	const cantCuadros
	override method peso() = super() * cantCuadros
}