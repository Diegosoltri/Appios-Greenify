//
//  ResiduosViewController.swift
//  Greenify
//
//  Created by Jose Galindo on 14/11/24.
//

import UIKit

let accionesResiduos = [
    "4.1 En recipientes o cajas de cartón, organiza para separar los desechos inorgánicos en 4 categorías: a) Papel, cartón y tetrapack, b) Vidrio, c) Latas y aluminio, d) Plásticos.",
    "4.2 Lleva tus residuos separados y limpios a las estaciones de reciclaje ubicadas en algunas plazas comerciales de la ciudad y parques.",
    "4.3 Separa los residuos electrónicos tales como electrodomésticos, computadoras, pilas o accesorios de teléfonos móviles y llévalos al centro de reciclaje especializado; nunca los arrojes a la basura.",
    "4.4 Antes de tirar algún artículo, evalúa si su estado permite ser reparado, regalado o donado. Es mejor optar por un segundo uso que arrojarlo a la basura, donde puede tardar años en degradarse.",
    "4.5 Lava y reutiliza los empaques de plástico y vidrio que puedan servir como tuppers. Si no te sirven, puedes regalarlos a quienes sí los utilicen, así damos uso a envases que podrían quedarse en la basura.",
    "4.6 Si cuentas con ropa en buen estado que ya no usarás, regálala a conocidos o dónala a albergues o a personas que la necesiten.",
    "4.7 Al hervir tus alimentos, conserva el agua. Déjala enfriar y úsala para regar tus plantas o el pasto.",
    "4.8 Para tirar tus focos a la basura, ya sean tradicionales, ahorradores o LED, colócalos en una bolsa con cierre hermético o en dos bolsas de plástico bien cerradas.",
    "4.9 Infórmate sobre actividades locales de reciclaje en tu comunidad, como campañas de reciclaje.",
    "4.10 Identifica centros de acopio o unidades de reciclaje donde puedas llevar tus residuos, debidamente separados y limpios.",
    "4.11 Muchos de los materiales que tiramos a la basura pueden tener un segundo uso. Revisa si las cajas, envases, botellas, bases de madera, bolsas u otros artículos son útiles.",
    "4.12 Tirar las pilas directamente a la basura genera una gran contaminación del suelo. Identifica los contenedores especiales para el desecho de pilas ubicados en farmacias o tiendas de autoservicio de tu ciudad.",
    "4.13 Los artículos electrónicos son peligrosos porque contienen sustancias químicas contaminantes; infórmate sobre los centros de reciclaje especializados para este tipo de materiales. No los tires directamente en la basura.",
    "4.14 Convoca a una colecta general de materiales comunes como papel, cartón y PET; comparte información a tus familiares, vecinos y conocidos sobre los centros de reciclaje donde puedan llevar sus residuos.",
    "4.15 El vidrio es un elemento que puede reciclarse al 100%; por ello, es preferible adquirir productos envasados con este material. Lava tus botellas y resguárdalas en una caja para depositarlas en los contenedores especiales, procurando que no se rompan.",
    "4.16 Los medicamentos caducos pueden ser peligrosos al contacto con el suelo. Separa las cajas de papel y junta las pastillas o cápsulas en una sola bolsa. Revisa en las farmacias cercanas si cuentan con un contenedor especial, ya que las autoridades sanitarias son las responsables de recolectar este tipo de residuos.",
    "4.17 A lo largo del año, junta bolsas o empaques que puedan ser útiles para envolver regalos.",
    "4.18 Si cuentas con residuos de fierro, contacta a las empresas especializadas en su reciclaje; por lo general, compran estos materiales a un bajo costo y se encargan de llevarlo a sus bodegas.",
    "4.19 Para recoger las heces de tus perros, compra bolsas hechas con materiales biodegradables.",
    "4.20 Si tienes gatos, consulta la información del empaque y compra arenas o aserrines amigables con el medio ambiente.",
    "4.21 Algunas frutas o verduras en los supermercados vienen envasadas en plástico. Opta por alimentos que no contengan empaques y lleva tus propias bolsas para envolverlos durante el traslado a casa.",
    "4.22 Las latas de aluminio son otro artículo que puede reciclarse como materia prima para otros productos como utensilios de cocina o contenedores; sepáralas y llévalas a los contenedores.",
    "4.23 Algunos artículos de limpieza cuentan con piezas reemplazables, tales como escobas o mechudos. Conserva los mangos y adquiere únicamente lo necesario en vez de comprar un artículo totalmente nuevo.",
    "4.24 Los artículos líquidos como jabones, detergentes o shampoos cuentan con versiones rellenables; estas opciones generan menos residuos y son más económicas.",
    "4.25 Separa tu basura en desechos orgánicos (frutas, verduras, alimentos) e inorgánicos (papel, PET, latas, vidrio, cartón y/o tetrapack). Si no te es posible reciclar estos residuos, no los mezcles con los desechos naturales. Para los pepenadores de basura es útil encontrar bolsas que contengan un solo material."
]


class ResiduosViewController: UIViewController {

    @IBOutlet weak var ConsejoResiduos: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Establecer un texto inicial para el label (opcional)
        ConsejoResiduos.text = "Presiona el botón para obtener un consejo"
    }

    @IBAction func consejoBotonPresionado(_ sender: UIButton) {
        // Obtener un índice aleatorio
        let indiceAleatorio = Int.random(in: 0..<accionesResiduos.count)
        // Obtener la acción correspondiente
        let accionAleatoria = accionesResiduos[indiceAleatorio]
        // Actualizar el texto del label
        ConsejoResiduos.text = accionAleatoria
    }
    


}
