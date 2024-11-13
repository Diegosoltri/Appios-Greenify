//
//  Recompensas.swift
//  Greenify
//
//  Created by Diego Soltri on 10/11/24.
//
import UIKit

struct Logro {
    let titulo: String
    let imagenNombre: String
    let estrellasPorActividad: Int // Estrellas que se obtienen cada vez que se completa la actividad
    let estrellasRequeridas: Int   // Estrellas necesarias para desbloquear el logro
    var estrellasActuales: Int = 0 // Progreso actual de estrellas
    
    var estaDesbloqueado: Bool {
        return estrellasActuales >= estrellasRequeridas
    }
    
    // Método para aumentar el progreso
    mutating func incrementarProgreso() {
        estrellasActuales += estrellasPorActividad
        if estrellasActuales > estrellasRequeridas {
            estrellasActuales = estrellasRequeridas // Limitar al máximo de estrellas requeridas
        }
    }
    // Obtener la imagen correspondiente al nombre
    func obtenerImagen() -> UIImage? {
        return UIImage(named: imagenNombre)
    }
}

let logros: [Logro] = [
    Logro(titulo: "Usa la bicicleta para llegar al TEC", imagenNombre: "bicicleta", estrellasPorActividad: 20, estrellasRequeridas: 200),
    Logro(titulo: "Camina 3 KM", imagenNombre: "camina", estrellasPorActividad: 20, estrellasRequeridas: 200),
    Logro(titulo: "Comparte automóvil con un compañero", imagenNombre: "carro", estrellasPorActividad: 10, estrellasRequeridas: 100),
    Logro(titulo: "Ve al taller de composta", imagenNombre: "composta", estrellasPorActividad: 15, estrellasRequeridas: 150),
    Logro(titulo: "Asiste al centro de reciclado", imagenNombre: "reciclado", estrellasPorActividad: 10, estrellasRequeridas: 100),
    Logro(titulo: "Ve al taller sobre los desechos", imagenNombre: "desechos", estrellasPorActividad: 10, estrellasRequeridas: 100),
    Logro(titulo: "Aprende a cuidar la energía", imagenNombre: "energia", estrellasPorActividad: 10, estrellasRequeridas: 100),
    Logro(titulo: "Conoce la flora del vivero TEC", imagenNombre: "flora", estrellasPorActividad: 5, estrellasRequeridas: 50),
    Logro(titulo: "Riega el vivero TEC", imagenNombre: "regar", estrellasPorActividad: 5, estrellasRequeridas: 50),
    Logro(titulo: "Trae tu propio termo", imagenNombre: "thermo", estrellasPorActividad: 5, estrellasRequeridas: 50),
    Logro(titulo: "Aprende a separar tus residuos", imagenNombre: "residuos", estrellasPorActividad: 5, estrellasRequeridas: 50)
]



