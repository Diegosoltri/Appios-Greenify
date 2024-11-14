//
//  QRScannerViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 08/11/24.
//

import SwiftUI
import UIKit

extension Notification.Name {
    static let logrosActualizados = Notification.Name("logrosActualizados")
}

class QRScannerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar el escáner QR como una vista de SwiftUI en UIKit
        let qrScannerView = SwiftUIView { [weak self] code in
            // Manejar el código escaneado
            print("Código QR escaneado: \(code)")
            DispatchQueue.main.async {
                self?.handleScannedCode(code)
            }
        }

        // Crear el controlador de vista de SwiftUI y añadirlo como hijo
        let hostingController = UIHostingController(rootView: qrScannerView)
        
        // Añadir el `hostingController` como hijo
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        // Configurar las restricciones para que ocupe toda la vista
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        // Agregar el rectángulo de guía para el área de escaneo
        addScanGuideView()
    }
    
    private func handleScannedCode(_ code: String) {
        let logrosService = LogrosService()
        
        // Obtener el logro más reciente de Firebase
        logrosService.obtenerLogros { [weak self] logrosActualizados in
            guard let self = self else { return }
            
            // Buscar el logro correspondiente al título del código QR escaneado
            if let logro = logrosActualizados.first(where: { $0.titulo == code }) {
                
                // Calcular las nuevas estrellas actuales
                let nuevasEstrellas = min(logro.estrellasActuales + logro.estrellasPorActividad, logro.estrellasRequeridas)
                
                // Actualizar el logro en Firebase
                logrosService.actualizarLogroEnFirebase(logro: Logro(
                    titulo: logro.titulo,
                    imagenNombre: logro.imagenNombre,
                    estrellasPorActividad: logro.estrellasPorActividad,
                    estrellasRequeridas: logro.estrellasRequeridas,
                    estrellasActuales: nuevasEstrellas
                ))
                
                // Publicar una notificación de que los logros han cambiado
                NotificationCenter.default.post(name: .logrosActualizados, object: nil)
                
                // Mostrar animación de éxito
                self.showSuccessAnimation {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                // Mostrar animación de error si el QR no es válido
                self.showErrorAnimation {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func addScanGuideView() {
        // Crear una vista con borde para el área de escaneo
        let scanGuideView = UIView()
        scanGuideView.layer.borderColor = UIColor.white.cgColor
        scanGuideView.layer.borderWidth = 2.0
        scanGuideView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scanGuideView)
        
        // Configurar las restricciones para centrar el rectángulo de guía
        NSLayoutConstraint.activate([
            scanGuideView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanGuideView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scanGuideView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6), // Ajusta el tamaño según lo necesites
            scanGuideView.heightAnchor.constraint(equalTo: scanGuideView.widthAnchor) // Cuadrado
        ])
    }
    
    // Función para mostrar la animación de éxito
    private func showSuccessAnimation(completion: @escaping () -> Void) {
        animateSymbol(named: "checkmark.circle.fill", color: .green, completion: completion)
    }
    
    // Función para mostrar la animación de error
    private func showErrorAnimation(completion: @escaping () -> Void) {
        animateSymbol(named: "xmark.circle.fill", color: .red, completion: completion)
    }

    // Función genérica para animar un símbolo en el centro de la pantalla
    private func animateSymbol(named symbolName: String, color: UIColor, completion: @escaping () -> Void) {
        let symbolView = UIImageView(image: UIImage(systemName: symbolName))
        symbolView.tintColor = color
        symbolView.alpha = 0
        symbolView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        symbolView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(symbolView)
        
        // Centrar la animación en la vista principal
        NSLayoutConstraint.activate([
            symbolView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            symbolView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            symbolView.widthAnchor.constraint(equalToConstant: 100),
            symbolView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Animar el símbolo
        UIView.animate(withDuration: 0.3, animations: {
            symbolView.alpha = 1
            symbolView.transform = .identity
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0.5, options: [], animations: {
                symbolView.alpha = 0
            }) { _ in
                symbolView.removeFromSuperview()
                completion() // Llamar al completion handler para cerrar el escáner
            }
        }
    }
}
