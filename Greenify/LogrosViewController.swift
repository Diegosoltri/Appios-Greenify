//
//  LogrosViewController.swift
//  Greenify
//          
//  Created by Jose Galindo on 04/11/24.
//

import UIKit

class LogrosViewController: UIViewController {
    
    @IBOutlet weak var LogrosDesbloqueados: UIView!
    @IBOutlet weak var LogrosTodos: UIView!
    @IBOutlet weak var LogrosProximos: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var logrosDesbloqueadosVC: LogrosDesbloqueadosViewController?
    private var logrosTodosVC: LogrosTodosViewController?
    private var logrosProximosVC: LogrosProximosViewController?
    
    private let logrosService = LogrosService() // Crear la instancia del servicio aquí
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Verificar y crear logros iniciales si no existen
        logrosService.crearLogrosInicialesSiNoExisten { [weak self] error in
            if let error = error {
                print("Error al crear logros iniciales: \(error.localizedDescription)")
                return
            }
            // Una vez que los logros están creados o verificados, inicializar las vistas
            self?.inicializarControladoresDeVista()
        }
    }
    
    private func inicializarControladoresDeVista() {
        // Inicializar los controladores de cada vista desde el Storyboard
        logrosDesbloqueadosVC = storyboard?.instantiateViewController(withIdentifier: "LogrosDesbloqueadosViewController") as? LogrosDesbloqueadosViewController
        logrosTodosVC = storyboard?.instantiateViewController(withIdentifier: "LogrosTodosViewController") as? LogrosTodosViewController
        logrosProximosVC = storyboard?.instantiateViewController(withIdentifier: "LogrosProximosViewController") as? LogrosProximosViewController
        
        // Agregar las vistas de los controladores como hijos
        if let logrosDesbloqueadosVC = logrosDesbloqueadosVC, let logrosTodosVC = logrosTodosVC, let logrosProximosVC = logrosProximosVC {
            addChild(logrosDesbloqueadosVC, toContainer: LogrosDesbloqueados)
            addChild(logrosTodosVC, toContainer: LogrosTodos)
            addChild(logrosProximosVC, toContainer: LogrosProximos)
        }
        
        // Seleccionar por defecto la pestaña "Todos"
        //segmentedControl.selectedSegmentIndex = 1
        switchViews(segmentedControl)
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            LogrosDesbloqueados.isHidden = false
            LogrosTodos.isHidden = true
            LogrosProximos.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            LogrosDesbloqueados.isHidden = true
            LogrosTodos.isHidden = false
            LogrosProximos.isHidden = true
            logrosTodosVC?.tableView.reloadData()
        } else if sender.selectedSegmentIndex == 2 {
            LogrosDesbloqueados.isHidden = true
            LogrosTodos.isHidden = true
            LogrosProximos.isHidden = false
        }
    }
    
    private func addChild(_ childController: UIViewController?, toContainer container: UIView) {
        guard let childController = childController else { return }
        addChild(childController)
        container.addSubview(childController.view)
        childController.view.frame = container.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childController.didMove(toParent: self)
    }
}
