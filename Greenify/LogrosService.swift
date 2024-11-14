//
//  LogrosService.swift
//  Greenify
//
//  Created by Diego Soltri on 10/11/24.
//

import FirebaseFirestore
import FirebaseAuth
import UIKit

class LogrosService {
    private let db = Firestore.firestore()
    
    func crearLogrosInicialesSiNoExisten(completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: Usuario no autenticado")
            completion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Usuario no autenticado"]))
            return
        }
        
        let logrosReferencia = db.collection("users").document(userId).collection("logros")
        
        
        let logrosIniciales = [
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
            // Agrega otros logros aquí
        ]
        
        let dispatchGroup = DispatchGroup()
        
        for logro in logrosIniciales {
            let logroDocRef = logrosReferencia.document(logro.titulo)
            
            dispatchGroup.enter()
            logroDocRef.getDocument { (document, error) in
                if let error = error {
                    print("Error al verificar logro \(logro.titulo): \(error.localizedDescription)")
                    dispatchGroup.leave()
                    return
                }
                
                if let document = document, document.exists {
                    print("Logro \(logro.titulo) ya existe, no se crea nuevamente")
                    dispatchGroup.leave()
                } else {
                    
                    let datosLogro: [String: Any] = [
                        "titulo": logro.titulo,
                        "estrellasActuales": logro.estrellasActuales,
                        "estrellasRequeridas": logro.estrellasRequeridas,
                        "estrellasPorActividad": logro.estrellasPorActividad,
                        "imagenNombre": logro.imagenNombre
                    ]
                    logroDocRef.setData(datosLogro) { error in
                        if let error = error {
                            print("Error al crear logro \(logro.titulo): \(error.localizedDescription)")
                        } else {
                            print("Logro \(logro.titulo) creado exitosamente")
                        }
                        dispatchGroup.leave()
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(nil)
        }
    }
    
    // Función para obtener todos los logros del usuario
    func obtenerLogros(completion: @escaping ([Logro]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: Usuario no autenticado")
            completion([])
            return
        }
        
        db.collection("users").document(userId).collection("logros").getDocuments { snapshot, error in
            var logros: [Logro] = []
            if let documents = snapshot?.documents {
                for document in documents {
                    let data = document.data()
                    if let titulo = data["titulo"] as? String,
                       let estrellasActuales = data["estrellasActuales"] as? Int,
                       let estrellasRequeridas = data["estrellasRequeridas"] as? Int,
                       let estrellasPorActividad = data["estrellasPorActividad"] as? Int,
                       let imagenNombre = data["imagenNombre"] as? String {
                        
                        let logro = Logro(
                            titulo: titulo,
                            imagenNombre: imagenNombre,
                            estrellasPorActividad: estrellasPorActividad,
                            estrellasRequeridas: estrellasRequeridas,
                            estrellasActuales: estrellasActuales
                        )
                        
                        logros.append(logro)
                    }
                }
            } else if let error = error {
                print("Error al obtener logros: \(error.localizedDescription)")
            }
            completion(logros)
        }
    }
    
    // Función para actualizar un logro específico en Firebase
    func actualizarLogroEnFirebase(logro: Logro) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: Usuario no autenticado")
            return
        }

        let logroRef = db.collection("users").document(userId).collection("logros").document(logro.titulo)
        logroRef.updateData([
            "estrellasActuales": logro.estrellasActuales
        ]) { error in
            if let error = error {
                print("Error al actualizar logro en Firebase: \(error.localizedDescription)")
            } else {
                print("Logro actualizado en Firebase: \(logro.titulo)")
            }
        }
    }
    
    
    
    
    
    
}
