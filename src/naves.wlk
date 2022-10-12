class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
	method acelerar(cuanto) {
		velocidad = (velocidad + cuanto).min(100000)
	}
	method desacelerar(cuanto) { velocidad = 0.max(velocidad - cuanto) }
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol() { direccion = 10.min(direccion +1) }
	method alejarseUnPocoDelSol() { direccion = -10.max(direccion - 1)}
	
	method prepararViaje() {
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	
	method cargarCombustible(cuanto) {combustible += cuanto}
	method descargarCombustible(cuanto) {combustible = 0.max(combustible -cuanto)}
	
	method adicionalTranquilidad()
	method estaTranquila() = 
		combustible >= 4000 && velocidad <= 12000 && self.adicionalTranquilidad()

}


class NaveBaliza inherits NaveEspacial {
	var baliza = "verde"
	method baliza() = baliza
	method cambiarColorDeBaliza(colorNuevo) {baliza=colorNuevo}
	override method prepararViaje() {
		super()
		baliza = "verde"
		self.ponerseParaleloAlSol()
	}
	override method adicionalTranquilidad() = baliza != "rojo"

}

class NaveDePasajeros inherits NaveEspacial {
	var property pasajeros = 0
	var property racionesDeComida = 0
	var property racionesDeBebida = 0
	
	override method prepararViaje() {
		super()
		racionesDeComida += 4 * pasajeros
		racionesDeBebida += 6 * pasajeros
		self.acercarseUnPocoAlSol()
	}
	
	override method adicionalTranquilidad() = true
}

class NaveDeCombate inherits NaveEspacial {
	var estaInvisible = false
	var misilesDesplegados = false
	const mensajesEmitidos = []
	
	method estaInvisible() = estaInvisible
	method ponerseVisible() {estaInvisible = false}
	method ponerseInvisible() {estaInvisible = true}
	method desplegarMisiles() {misilesDesplegados = true}
	method replegarMisiles() { misilesDesplegados = false}
	method misilesDesplegados() = misilesDesplegados
	method emitirMensaje(mensaje) {mensajesEmitidos.add(mensaje)}
	method mensajesEmitidos() = mensajesEmitidos
	method primerMensajeEmitido() {
		if(mensajesEmitidos.isEmpty()) self.error("la lista de mensajes esta vacia")
		return mensajesEmitidos.first()
	} 
		
	method ultimoMensajeEmitido() {
		if(mensajesEmitidos.isEmpty()) self.error("la lista de mensajes esta vacia")
		return mensajesEmitidos.last()
	} 
	method esEscueta() = mensajesEmitidos.all({m=>m.size() < 30})

	override method prepararViaje() {
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Salir en mision")
	}
	
	override method adicionalTranquilidad() = !misilesDesplegados
	
}

class NaveHospital inherits NaveDePasajeros {
	var property quirofanosPreparados = false
	
	override method adicionalTranquilidad() = !quirofanosPreparados
}

class NaveSigilosa inherits NaveDeCombate {
	
	override method adicionalTranquilidad() = super() && !self.estaInvisible()
}