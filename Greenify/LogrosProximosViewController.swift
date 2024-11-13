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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    
    private func actualizarUI() {
        tableView.reloadData() // Recargar la tabla para reflejar los logros próximos
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
    
    // MARK: - UITableViewDelegate (opcional)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Agregar acción al seleccionar un logro, si es necesario
    }
}
