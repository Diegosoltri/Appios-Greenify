//
//  LogrosProximosViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 10/11/24.
//

import UIKit

class LogrosProximosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var logros: [Logro] = []
    private let logrosService = LogrosService()
    
    private let mensajeVacioLabel: UILabel = {
        let label = UILabel()
        label.text = "No tienes logros próximos por ahora."
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Observar la notificación de actualización de logros
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLogrosProximos), name: .logrosActualizados, object: nil)
        
        // Agregar el mensaje de "no hay logros próximos" si la lista está vacía
        view.addSubview(mensajeVacioLabel)
        mensajeVacioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mensajeVacioLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        cargarLogrosProximos()
    }
    
    @objc private func cargarLogrosProximos() {
        logrosService.obtenerLogros { [weak self] logros in
            DispatchQueue.main.async {
                // Filtrar logros donde estrellas actuales es diferente de 0 pero no igual a estrellas requeridas
                self?.logros = logros.filter { $0.estrellasActuales > 0 && $0.estrellasActuales < $0.estrellasRequeridas }
                self?.actualizarUI()
            }
        }
    }
    
    private func actualizarUI() {
        // Mostrar u ocultar el mensaje de "no hay logros próximos" basado en si la lista está vacía o no
        mensajeVacioLabel.isHidden = !logros.isEmpty
        tableView.reloadData()
    }
    deinit {
        // Remover la observación de la notificación
        NotificationCenter.default.removeObserver(self, name: .logrosActualizados, object: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogroCell", for: indexPath) as? LogroCell else {
            return UITableViewCell()
        }
        let logro = logros[indexPath.row]
        cell.configurarCon(logro: logro)
        return cell
    }
    
    // MARK: - UITableViewDelegate (opcional)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Agregar acción al seleccionar un logro, si es necesario
    }
}
