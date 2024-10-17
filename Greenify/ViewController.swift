//
//  ViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 02/09/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            performSegue(withIdentifier: "Camino1", sender: self)
        }
    }
    
}

