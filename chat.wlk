/*
Contacto: Sí! Se pueden enviar usuarios como contenido de los mensajes. Se debe saber qué usuario se envía y el peso de estos contenidos es siempre 3 KB.
Chateando
En nuestro servicio de mensajería, existen chats, y se pueden enviar los mensajes a esos chats. Pero ojo, no se puede enviar un mensaje a cualquier chat. El emisor del mensaje debe estar entre los participantes del chat. Además, los usuarios tienen una memoria que se va llenando con cada mensaje, y al enviar un mensaje a un chat es necesario que cada participante tenga espacio libre suficiente para almacenarlo.

Chats premium
Además de los chats clásicos, se pueden tener chats premium para tener otro control sobre el envío de mensajes. Además de las restricciones de los chats clásicos, se agrega una restricción adicional:

Difusión: solamente el creador del chat premium puede enviar mensajes.
Restringido: determina un límite de mensajes que puede tener el chat, una vez llegada a esa cantidad no deja enviar más mensajes.
Ahorro: todos los integrantes pueden enviar solamente mensajes que no superen un peso máximo determinado.
Tanto esta restricción adicional como los integrantes de un chat premium pueden ser modificados en cualquier momento.

*/

class Notificacion {
	const property chat
	var property leida = false
	
	method leer() { leida = true }
}

class Chat {
	const property mensajes = []
	const participantes = []
	
	method espacioOcupado() = mensajes.sum {mensaje => mensaje.peso()}
	
	//
	method enviar(mensaje) {
		self.validarEnvio(mensaje)
		mensajes.add(mensaje)
		self.notificar()
	}
	
	method validarEnvio(mensaje){
		if (not self.puedeEnviar(mensaje)) {
			self.error("No se puede enviar el mensaje")
		}
	}
	
	method puedeEnviar(mensaje) = participantes.contains(mensaje.emisor())
		and participantes.all({usuario => usuario.espacioSuficientePara(mensaje)})
	

	//
	method mensajeMasPesado() = mensajes.max({m => m.peso()})
	
	//
	method notificar() {
		participantes.forEach({usuario => usuario.recibirNotificacion(new Notificacion(chat = self))})
	}
	
	//
	method contiene(texto) = mensajes.any({m => m.contiene(texto)})



}

class ChatPremium inherits Chat {
	const creador
	const permiso
	
	override method puedeEnviar(mensaje) = super(mensaje) && permiso.puedeEnviar(mensaje, creador)
}

object difusion {
	method puedeEnviar(mensaje, creador) = mensaje.emisor() == creador 
}

object reunion {
	method puedeEnviar(mensaje, creador) = true 
}

class Ahorro {
	const pesoMaximo
	
	method puedeEnviar(mensaje, creador) = mensaje.peso() < pesoMaximo 
}