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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            LogrosDesbloqueados.alpha = 1
            LogrosProximos.alpha = 0
            LogrosTodos.alpha = 0
        } else if sender.selectedSegmentIndex == 1 {
            LogrosDesbloqueados.alpha = 0
            LogrosProximos.alpha = 1
            LogrosTodos.alpha = 0
        }else if sender.selectedSegmentIndex == 2{
            LogrosDesbloqueados.alpha = 0
            LogrosProximos.alpha = 0
            LogrosTodos.alpha = 1
        }
    }
}
