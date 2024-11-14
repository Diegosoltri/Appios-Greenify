//
//  ConsejoViewController.swift
//  Greenify
//
//  Created by Jose Galindo on 14/11/24.
//

import UIKit

class ConsejoViewController: UIViewController {
    
    @IBOutlet weak var Movilidad: UIView!
    @IBOutlet weak var Energia: UIView!
    @IBOutlet weak var Consumo: UIView!
    @IBOutlet weak var Residuos: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
            if sender.selectedSegmentIndex == 0 {
                Movilidad.alpha = 1
                Energia.alpha = 0
                Consumo.alpha = 0
                Residuos.alpha = 0
            } else if sender.selectedSegmentIndex == 1{
                Movilidad.alpha = 0
                Energia.alpha = 1
                Consumo.alpha = 0
                Residuos.alpha = 0
            } else if sender.selectedSegmentIndex == 2{
                Movilidad.alpha = 0
                Energia.alpha = 0
                Consumo.alpha = 1
                Residuos.alpha = 0
            } else if sender.selectedSegmentIndex == 3{
                Movilidad.alpha = 0
                Energia.alpha = 0
                Consumo.alpha = 0
                Residuos.alpha = 1
            }
        }
}
