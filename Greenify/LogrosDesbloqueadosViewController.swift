//
//  LogrosDesbloqueadosViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 10/11/24.
//

import UIKit

class LogrosDesbloqueadosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var logros: [Logro] = []
    private let logrosService = LogrosService()
    
    private let mensajeVacioLabel: UILabel = {
        let label = UILabel()
        label.text = "No tienes logros desbloqueados todavía."
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
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLogrosDesbloqueados), name: .logrosActualizados, object: nil)
        
        // Agregar el mensaje de "no hay logros" si la lista está vacía
        view.addSubview(mensajeVacioLabel)
        mensajeVacioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mensajeVacioLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        cargarLogrosDesbloqueados()
    }
    
    @objc private func cargarLogrosDesbloqueados() {
        logrosService.obtenerLogros { [weak self] logros in
            DispatchQueue.main.async {
                // Filtrar solo los logros que están completamente desbloqueados
                self?.logros = logros.filter { $0.estrellasActuales >= $0.estrellasRequeridas }
                self?.actualizarUI()
            }
        }
    }
    
    private func actualizarUI() {
        // Mostrar u ocultar el mensaje de "no hay logros" basado en si la lista está vacía o no
        mensajeVacioLabel.isHidden = !logros.isEmpty
        tableView.reloadData()
    }
    deinit {
        // Remover la observación de la notificación
        NotificationCenter.default.removeObserver(self, name: .logrosActualizados, object: nil)
    }
    
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
}
