//
//  IntroViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 07/10/24.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Swipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            performSegue(withIdentifier: "Camino2", sender: self)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
