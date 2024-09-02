class Criatura {
    var property astucia
    var property poder
    var property rol
    method poderOfensivo() = 10 * poder +  rol.poderOfensivo() 
    method esFormidable() = self.esAstuta() or self.esExtraordinaria()
    method esAstuta()
    method esExtraordinaria() = rol.extraordinario(self)
    method ritual() {
        rol = rol.cambiarDeRol()
    }
}

class Duende inherits Criatura {
    override method poderOfensivo() = super() * 1.1
    override method esAstuta() = false

}

class Hada inherits Criatura {
    var kilometrosPuedeVolar = 2
    method kilometrosPuedeVolar(unValor) {
        kilometrosPuedeVolar = 20.min(kilometrosPuedeVolar + unValor)
    }
    override method esAstuta() = astucia >= 50
    override method esExtraordinaria() = super() and kilometrosPuedeVolar >=10
}

object guardian {
    method poderOfensivo() = 100
    method extraordinario(criatura) = criatura.poder() > 50
    method cambiarDeRol() = new Domador(mascotas=[new Mascota(edad=1, tieneCuernos=false)])
}

object hechicero {
    method poderOfensivo() = 0
    method extraordinario(criatura) = true
    method cambiarDeRol() = guardian
}

class Domador {
    var property mascotas=[]

    method poderOfensivo() {
        return 150 * mascotas.count {mascota =>  mascota.tieneCuernos()}
    }
    method extraordinario(criatura) = criatura.poder() >=10
    and  self.todasMascotasVeteranas() 

    method todasMascotasVeteranas() {
        return mascotas.all { mascota => mascota.esVeterana()}
    }

    method cambiarDeRol() {
        if (! self.alMenosUnaMascotaConCuernos())
            self.error("No pude cambiar de Rol")
        return hechicero
    }

    method alMenosUnaMascotaConCuernos() {
        return mascotas.any { mascota => mascota.tieneCuernos()}
    }
}

class Mascota {
    var property edad
    var property tieneCuernos = true
    method esVeterana() = edad >= 10
}

