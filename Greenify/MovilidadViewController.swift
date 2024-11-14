//
//  MovilidadViewController.swift
//  Greenify
//
//  Created by Jose Galindo on 14/11/24.
//

import UIKit

let accionesMovilidad = [
    "1.1 Desplázate a pie o en bicicleta en distancias cortas (menores a 1 kilómetro), no utilices el automóvil.",
    "1.2 Al iniciar la semana, planea y optimiza tus rutas en el auto según tus actividades laborales y personales, con ello no solo ahorrarás combustible sino también tiempo.",
    "1.3 Organízate en familia o con los amigos para utilizar un solo auto, cuando las actividades o lugares de visita sean las mismas.",
    "1.4 Verifica tu auto o motocicleta y cumple en tiempo y forma con las regulaciones ambientales.",
    "1.5 Mantén las llantas de tu vehículo con la presión adecuada, una presión inferior puede consumir más combustible.",
    "1.6 Utiliza el aire acondicionado solo cuando sea indispensable; circulando dentro de la ciudad a una velocidad moderada, abrir las ventanillas evitará consumir más combustible.",
    "1.7 Al adquirir un nuevo auto, considera el nivel de consumo de gasolina, prefiere vehículos que optimicen el uso del combustible.",
    "1.8 Si vas a realizar un viaje fuera de la ciudad, planea con tiempo tus traslados, revisando las distancias y el transporte disponible y más conveniente.",
    "1.9 Revisa si en tu ciudad o los destinos que visites existe algún programa de micromovilidad: bicicletas, scooters o patines disponibles para su uso en cortas distancias y en vías seguras.",
    "1.10 Mantente informado sobre las contingencias ambientales y respeta los lineamientos de las autoridades locales sobre las restricciones de uso de transporte privado.",
    "1.11 Si acudes a eventos masivos o a zonas de alto flujo vehicular, el uso de transporte público puede ser una alternativa para evitar la búsqueda intensiva de estacionamiento en tu automóvil particular.",
    "1.12 Realiza una evaluación personal del uso que haces del automóvil semanalmente. Planea un día sin utilizarlo. Puedes comenzar con esta auto-restricción una vez al mes.",
    "1.13 En caso de hacer un viaje de turismo lejano, investiga qué medio de transporte es el más sustentable, en ocasiones es mejor trasladarse por tierra que asumir el costo ambiental y económico de un traslado en avión.",
    "1.14 Al utilizar bicicleta para transportarte, asegúrate de que las llantas cuenten con suficiente aire y que los frenos funcionen bien; lleva contigo hidratación y nunca salgas sin casco.",
    "1.15 Si te transportas en automóvil particular, cuida la velocidad a la que circulas, a mayor velocidad, más gasto de combustible.",
    "1.16 Para realizar tus compras de abastecimiento y otros servicios, elige comercios cercanos a tu hogar y cercanos entre ellos, con el objetivo de recorrer menores distancias para varias actividades en una sola vuelta.",
    "1.17 Si vas a reunirte con alguien, elijan un punto intermedio entre la ubicación de ambos, evitando que se desplacen por mayor distancia.",
    "1.18 En caso de desplazarte a pie, revisa anticipadamente la ruta por donde caminarás, considerando que sea segura (bien iluminada, libre de autos) y utiliza siempre los puentes peatonales. Considera llevar hidratación en tiempos calurosos.",
    "1.19 Si tu medio de transporte es la motocicleta, revisa frecuentemente que se encuentre en buen estado, recuerda que es fundamental para tu seguridad circular con casco (tú y tus acompañantes).",
    "1.20 Sea cual sea tu medio de transporte, mantente siempre atento y con precaución para evitar accidentes. Las emergencias implican movilización de unidades de auxilio (aseguradoras, ambulancias).",
    "1.21 Si te desplazas en automóvil, da preferencia y respeta los carriles ciclistas. En la medida en que las personas se sientan seguras de utilizar las ciclovías o trasladarse en bicicleta, el incremento de este transporte será mayor.",
    "1.22 El uso de medios alternativos al automóvil no tiene que ser definitivo. Según tu ubicación y tus posibilidades, puedes planear tus recorridos semanales alternando el uso de auto propio, auto compartido, motocicleta, bicicleta o a pie.",
    "1.23 Si no cuentas con una bicicleta propia, revisa los planes gubernamentales de tu ciudad; muchos municipios cuentan con unidades de uso público sin costo.",
    "1.24 En tu lugar de residencia o al viajar a otras ciudades o zonas, investiga si existe la opción de utilizar transporte público alternativo, tales como transporte eléctrico (trolebuses), mototaxis o cualquier unidad que no sea el automóvil o camiones tradicionales.",
    "1.25 Haz una evaluación personal sobre el tipo de transporte que utilizas a diario y sobre los viajes que realizas. Establece cómo podrías hacer más sustentables tus traslados y comprométete a implementar acciones personales que inspiren a otras personas."
]


class MovilidadViewController: UIViewController {

    @IBOutlet weak var ConsejoBoton: UIButton!
    @IBOutlet weak var ConsejoMovilidad: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Establecer un texto inicial para el label (opcional)
        ConsejoMovilidad.text = "Presiona el botón para obtener un consejo"
    }

    @IBAction func consejoBotonPresionado(_ sender: UIButton) {
        // Obtener un índice aleatorio
        let indiceAleatorio = Int.random(in: 0..<accionesMovilidad.count)
        // Obtener la acción correspondiente
        let accionAleatoria = accionesMovilidad[indiceAleatorio]
        // Actualizar el texto del label
        ConsejoMovilidad.text = accionAleatoria
    }

    

}
