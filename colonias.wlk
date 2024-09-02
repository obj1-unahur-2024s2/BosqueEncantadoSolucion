import criaturas.*
import areas.*
class Colonia {
    const property criaturas = []
    method poderOfensivo() {
        return criaturas.sum {criatura=>criatura.poderOfensivo()}
    }

    method conquistar(unArea) {
        if(self.poderOfensivo() > unArea.poderDefensivo())
            unArea.esUsurpada(self)
        else
            criaturas.forEach {
                criatura => criatura.poder(criatura.poder()*0.85)
            }

    }

    method cantidadDeCriaturasFormidables() {
        return criaturas.count { criatura => criatura.esFormidable()}
    }
}