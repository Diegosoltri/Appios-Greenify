//
//  ActivityDetailViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 08/11/24.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    var actividad: Imageactividades? // Recibir la actividad seleccionada

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Configura aquí los elementos visuales (por ejemplo, etiquetas e imágenes)
        if let actividad = actividad {
            let titleLabel = UILabel()
            titleLabel.text = actividad.tittle
            titleLabel.textAlignment = .center
            titleLabel.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 40)
            view.addSubview(titleLabel)
                    
            let imageView = UIImageView(image: actividad.image)
            imageView.frame = CGRect(x: 20, y: 150, width: view.bounds.width - 40, height: 200)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
        }
        
        // Agregar un botón para cerrar el modal
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Cerrar", for: .normal)
        closeButton.frame = CGRect(x: 20, y: 370, width: view.bounds.width - 40, height: 50)
        closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    @objc private func dismissModal() {
        dismiss(animated: true, completion: nil)
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
