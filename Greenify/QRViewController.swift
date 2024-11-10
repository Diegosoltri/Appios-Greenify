//
//  QRViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 08/11/24.
//

import UIKit

class QRViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func scanQRCode(_ sender: UIButton) {
        // Crear una instancia de QRScannerViewController
        let qrScannerVC = QRScannerViewController()
        // Presentar el escáner QR de manera modal
        present(qrScannerVC, animated: true, completion: nil)
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


