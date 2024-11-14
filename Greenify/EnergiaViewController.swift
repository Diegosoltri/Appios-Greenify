//
//  EnergiaViewController.swift
//  Greenify
//
//  Created by Jose Galindo on 14/11/24.
//



import UIKit

let accionesEnergia = [
    "2.1 Apaga los focos que no estén en uso, revisa periódicamente las habitaciones en casa y el trabajo y conviértelo en un hábito.",
    "2.2 Al usar la lavadora, evita el ciclo con agua caliente y procura realizar cargas llenas; esto optimiza el gasto de energía en vez de utilizar cargas pequeñas varias veces.",
    "2.3 En temporadas calurosas, para mantener fresca tu casa, abre puertas y ventanas, evitando el uso del aire acondicionado.",
    "2.4 En temporadas frías, para mantener tu casa caliente, cierra puertas y ventanas, evitando el uso de calentadores.",
    "2.5 Si trabajas o estudias en casa, elige un lugar bien iluminado y ventilado; la luz natural es mejor que la iluminación artificial.",
    "2.6 Desconecta los electrodomésticos y aparatos del hogar que no estén en uso; simplemente por estar conectados consumen energía.",
    "2.7 Realiza la carga de la pila de tus aparatos electrónicos (celular, laptop, audífonos, tabletas, etc.) al 100%; evita hacer cargas parciales, ya que dañan la pila y reducen el tiempo de vida del dispositivo.",
    "2.8 Ajusta el brillo de las pantallas de tus dispositivos a un porcentaje menor al 100%, ya que consume más energía cuando está al máximo.",
    "2.9 Evita las acciones 'multiscreen', esto es, tener activos varios dispositivos a la vez (por ejemplo, tener prendida la laptop mientras ves la televisión y ocupas el celular).",
    "2.10 Reemplaza tus focos tradicionales por focos LED; asegúrate de no comprar ‘focos ahorradores’, ya que contienen sustancias dañinas para el medio ambiente.",
    "2.11 Compra pilas recargables; su duración es mucho más prolongada y evitas la compra y el desecho constante.",
    "2.12 Ajusta la temperatura de tu calentador; una temperatura muy elevada incrementa el consumo de gas.",
    "2.13 Evita duchas con agua muy caliente; además de ser dañino para el cuerpo, se consume una gran cantidad de gas. Toma baños cortos.",
    "2.14 Al cocinar o calentar alimentos en la estufa, utiliza tapas para concentrar el calor y reducir el tiempo de encendido.",
    "2.15 Evita el uso de la secadora para la ropa; el ambiente exterior es una forma natural y sin uso de energía para el secado.",
    "2.16 En la compra de gasolina para tu auto, identifica las sucursales que te proporcionen la mejor relación calidad-precio.",
    "2.17 Utiliza los utensilios de cocina específicos para cada tipo de preparación o alimento; estos están diseñados específicamente para una cocción más rápida y mejor.",
    "2.18 Repara cualquier problema eléctrico en el hogar; si tus equipos eléctricos funcionan eficientemente se optimiza el uso de energía.",
    "2.19 Si necesitas reemplazar aparatos viejos, invierte en electrodomésticos de bajo consumo.",
    "2.20 La mayoría de los cargadores continúan consumiendo energía incluso cuando no están cargando un dispositivo; desenchúfalos en cuanto desconectes tus dispositivos.",
    "2.21 Si trabajas en laptop o tablet, no dejes el equipo en modo suspender. Es mejor apagar por completo los dispositivos que dejarlos por varias horas desactivados y consumiendo energía. No olvides desenchufarlos.",
    "2.22 El mayor consumo de energía de la plancha se produce cuando se enchufa hasta que alcanza la temperatura óptima, por ello no es recomendable planchar una sola prenda, sino la mayor cantidad posible.",
    "2.23 Utiliza el agua caliente en tu lavabo solo cuando sea necesario; el lavado de manos o de dientes no requiere una temperatura cálida.",
    "2.24 Algunos dispositivos y electrodomésticos cuentan con el modo ‘ahorro de energía’. Revisa si tienes esta opción y actívala.",
    "2.25 Cuida lo que comes. Los alimentos son el combustible que permite a tu cuerpo funcionar; nútrelo para que tengas un mejor desempeño."
]


class EnergiaViewController: UIViewController {

    @IBOutlet weak var ConsejoEnergia: UILabel!
    @IBOutlet weak var ConsejoBotonEnergia: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Establecer un texto inicial para el label (opcional)
        ConsejoEnergia.text = "Presiona el botón para obtener un consejo"
    }

    @IBAction func consejoBotonPresionado(_ sender: UIButton) {
        // Obtener un índice aleatorio
        let indiceAleatorio = Int.random(in: 0..<accionesEnergia.count)
        // Obtener la acción correspondiente
        let accionAleatoria = accionesEnergia[indiceAleatorio]
        // Actualizar el texto del label
        ConsejoEnergia.text = accionAleatoria
    }
    

}
