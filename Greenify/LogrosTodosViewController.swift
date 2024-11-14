//
//  LogrosTodosViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 10/11/24.
//

import UIKit

class LogrosTodosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var logros: [Logro] = []
    private let logrosService = LogrosService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Observar la notificación de actualización de logros
        NotificationCenter.default.addObserver(self, selector: #selector(cargarTodosLosLogros), name: .logrosActualizados, object: nil)
        
        print("View did load - iniciando carga de logros")
        cargarTodosLosLogros()
    }
    
    @objc private func cargarTodosLosLogros() {
        logrosService.obtenerLogros { [weak self] logros in
            DispatchQueue.main.async {
                print("Logros obtenidos desde el servicio: \(logros.count) logros encontrados.")
                for (index, logro) in logros.enumerated() {
                    print("Logro \(index):")
                    print("Título: \(logro.titulo)")
                    print("Estrellas actuales: \(logro.estrellasActuales)")
                    print("Estrellas requeridas: \(logro.estrellasRequeridas)")
                    print("Nombre de imagen: \(logro.imagenNombre)")
                }
                
                self?.logros = logros
                self?.actualizarUI()
            }
        }
    }
    
    private func actualizarUI() {
        print("Actualizando UI - recargando datos en la tabla.")
        tableView.reloadData()
    }
    deinit {
        // Remover la observación de la notificación
        NotificationCenter.default.removeObserver(self, name: .logrosActualizados, object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Número de filas en la sección \(section): \(logros.count)")
        return logros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogroCell", for: indexPath) as? LogroCell else {
            print("Error: No se pudo dequeuer una celda LogroCell.")
            return UITableViewCell()
        }
        
        let logro = logros[indexPath.row]
        print("Configurando celda para el logro en índice \(indexPath.row):")
        print("Título: \(logro.titulo)")
        print("Estrellas actuales: \(logro.estrellasActuales)")
        print("Estrellas requeridas: \(logro.estrellasRequeridas)")
        cell.configurarCon(logro: logro)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate (Opcional)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Celda seleccionada en el índice \(indexPath.row)")
        // Puedes agregar una acción para la celda seleccionada aquí, si es necesario
    }
}
