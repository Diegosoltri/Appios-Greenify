//
//  ConsumoViewController.swift
//  Greenify
//
//  Created by Jose Galindo on 14/11/24.
//

import UIKit

let accionesConsumo = [
    "3.1 Báñate en 5 minutos, cierra la llave cuando te estés enjabonando.",
    "3.2 Al lavar los trastes, evita el uso innecesario de agua caliente y no dejes correr el agua si no la estás utilizando.",
    "3.3 Dobla y lleva contigo siempre (en el auto o en tu bolso o mochila) una bolsa de tela grande, te servirá cuando realices compras sin planear y evitarás utilizar bolsas de plástico.",
    "3.4 Evita los plásticos de un solo uso. Son artículos de un ciclo de vida corto y hechos de materiales altamente dañinos para el medio ambiente: envases de unicel, popotes, cubiertos desechables, botellas de plástico para bebidas.",
    "3.5 Lleva siempre contigo un termo con agua en vez de comprar botellas de PET y también lleva un termo para el café, evitarás el uso de envases difíciles de degradar como el unicel.",
    "3.6 Realiza la compra de tus alimentos (frutas, vegetales, granos) en mercados locales; además de estimular la economía de pequeños productores, estos artículos realizan un viaje más corto y consumen menos energía que los productos que encontramos en los supermercados.",
    "3.7 Comprar ropa de segunda mano otorga una oportunidad para utilizar vestimenta en buen estado; hoy día existen pequeños bazares y particulares que ofertan mercancía a precios más bajos. También puedes optar por donar ropa en buen estado en vez de tirarla a la basura.",
    "3.8 Tras comprar algún artículo, conserva las bolsas, empaques y envases que puedas reutilizar o darles un segundo uso, en vez de arrojarlos a la basura.",
    "3.9 No dejes tu laptop prendida o en modo suspensión; es mejor dejar que el equipo se apague por completo y deje de consumir energía.",
    "3.10 Si recibes algún regalo, ábrelo con cuidado y conserva la bolsa o el empaque, con el objetivo de que puedas utilizarlo para otros usos.",
    "3.11 Evita el desperdicio de alimentos; al hacer tu despensa, compra solo lo necesario y planea tu consumo diario, semanal o quincenal.",
    "3.12 Implementa en tu semana un día sin carne roja, ya que es la que mayor energía requiere para ser producida; además de ser más difícil de procesar, para alimentar a los animales se requiere una mayor cantidad de granos.",
    "3.13 Cuando compres comida para llevar, lleva tus propios tuppers o envases, esto evitará utilizar y tirar envases de materiales que no se degradan con facilidad, como el unicel.",
    "3.14 Si utilizas rastrillo, compra uno de metal en vez de los desechables de plástico; deberás cambiar únicamente las hojas en vez de desechar todo el artículo continuamente.",
    "3.15 Para tus artículos de uso personal (desodorante, crema, shampoo, pasta de dientes, jabón), opta por las opciones sólidas; además de contener menos químicos, no se presentan en envases de plástico, al ser compras continuas, disminuyes considerablemente la cantidad de basura.",
    "3.16 El vidrio es un material 100% reciclable; prefiere productos envasados de este tipo en vez de plástico.",
    "3.17 Festeja sin plásticos ni unicel. Elige envases de papel o, en su defecto, biodegradables. Aunque lo ideal es lavar los trastes y evitar contaminación en grandes cantidades.",
    "3.18 Siembra hierbas de olor para cocinar (romero, albahaca, perejil); es muy práctico y sencillo.",
    "3.19 Compra tus botanas o frutos secos a granel; es mucho más económico y puedes llevar tus envases de vidrio o plástico cada vez que compres.",
    "3.20 Evita regalar cosas innecesarias y hechas de plástico. Existen miles de artículos poco útiles, de bajo costo y de alta contaminación.",
    "3.21 Si compras juguetes, revisa sus materiales. Algunos juguetes de plástico como las pelotas, muñecos, casas o coches son difíciles de desechar y no son reciclables.",
    "3.22 Revisa y repara de inmediato cualquier gotera que pudieras tener en casa. En su defecto, coloca una cubeta para recolectar el agua que se escapa de la llave y úsala para limpiar, lavar o regar las plantas.",
    "3.23 Come despacio. La sensación de masticar lento causa sensación de saciedad y disminuye la ansiedad por consumir más alimento.",
    "3.24 Para cualquier compra, elige empaques que sean reutilizables, reciclables o compostables, esto te dará una visión distinta sobre los desechos que se generan en cada artículo o comida que adquieres.",
    "3.25 Evita el uso de mangueras para lavar el auto o quitar residuos de polvo en pisos; aunque es más fácil, el consumo de agua es 5 veces mayor de lo que podrías gastar con una sola cubeta."
]


class ConsumoViewController: UIViewController {

    @IBOutlet weak var ConsejoConsumo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Establecer un texto inicial para el label (opcional)
        ConsejoConsumo.text = "Presiona el botón para obtener un consejo"
    }

    @IBAction func consejoBotonPresionado(_ sender: UIButton) {
        // Obtener un índice aleatorio
        let indiceAleatorio = Int.random(in: 0..<accionesConsumo.count)
        // Obtener la acción correspondiente
        let accionAleatoria = accionesConsumo[indiceAleatorio]
        // Actualizar el texto del label
        ConsejoConsumo.text = accionAleatoria
    }
    


}
