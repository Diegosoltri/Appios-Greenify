//
//  ImageActividades.swift
//  Greenify
//
//  Created by Diego Soltri on 04/11/24.
//

import UIKit

struct Imageactividades{
    let tittle: String
    let image: UIImage
    let description: String
}

let imageactividades: [Imageactividades] = [
    Imageactividades(tittle: "Usa la bicicleta para llegar al TEC", image: #imageLiteral(resourceName: "imgbici"), description: "Promueve el transporte sostenible utilizando tu bicicleta para llegar al campus. Es una excelente manera de reducir emisiones y mejorar tu salud. Aulas II"),
    Imageactividades(tittle: "Camina 3 KM", image: #imageLiteral(resourceName: "imgcamina"), description: "Camina 3 KM: Realiza una caminata de 3 kilómetros, disfrutando del entorno natural y reduciendo tu huella de carbono mientras cuidas tu cuerpo. LIFE"),
    Imageactividades(tittle: "Comparte automóvil con un compañero", image: #imageLiteral(resourceName: "imgauto"), description: "Reduce las emisiones compartiendo tu auto con un compañero. Es una acción sencilla que contribuye a un futuro más sostenible. Estacionamiento"),
    Imageactividades(tittle: "Ve al taller de composta", image: #imageLiteral(resourceName: "imgcomposta"), description: "Participa en este taller para aprender a transformar tus desechos orgánicos en composta y contribuir al cuidado del medio ambiente. Vivero TEC"),
    Imageactividades(tittle: "Asiste al centro de reciclado", image: #imageLiteral(resourceName: "imgreciclado"), description: "Visita el centro de reciclaje para conocer cómo se procesan los materiales reciclables y aprende a integrarlo en tu rutina diaria. Cafetería"),
    Imageactividades(tittle: "Ve al taller sobre los desechos", image: #imageLiteral(resourceName: "imgdesechos"), description: "⁠Conoce el impacto de los desechos y cómo puedes gestionarlos de manera responsable para reducir la contaminación. Aulas IV"),
    Imageactividades(tittle: "Aprende a cuidar la energía", image: #imageLiteral(resourceName: "imgenergia"), description: "Participa en esta actividad para descubrir formas prácticas de ahorrar energía en tu día a día y proteger los recursos naturales. Aulas I"),
    Imageactividades(tittle: "Conoce la flora del vivero TEC", image: #imageLiteral(resourceName: "imgflora"), description: "Explora el vivero del campus y descubre las especies de flora que ayudan a mantener el equilibrio ecológico. Vivero TEC"),
    Imageactividades(tittle: "Riega el vivero TEC", image: #imageLiteral(resourceName: "jardin"), description: "Contribuye al cuidado del vivero regando las plantas y ayudando a mantener este espacio verde lleno de vida. Vivero TEC"),
    Imageactividades(tittle: "Trae tu propio termo", image: #imageLiteral(resourceName: "imgtermo"), description: "Reduce el uso de plásticos al traer tu propio termo para bebidas. Pequeñas acciones generan grandes cambios. Cafetería"),
    Imageactividades(tittle: "Aprende a separar tus residuos", image: #imageLiteral(resourceName: "imgresiduos"), description: "Aprende a separar tus residuos: Familiarízate con las mejores prácticas para separar residuos y contribuir a un reciclaje más efectivo. Cafetería"),
]
