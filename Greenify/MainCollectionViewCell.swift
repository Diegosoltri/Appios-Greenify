//
//  MainCollectionViewCell.swift
//  Greenify
//
//  Created by Diego Soltri on 04/11/24.
//

import UIKit

// Definir el protocolo del delegado
protocol MainCollectionViewCellDelegate: AnyObject {
    func didTapInfoButton(for actividad: Imageactividades)
}

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var mainButton: UIButton!
    
    weak var delegate: MainCollectionViewCellDelegate? // Delegado para notificar el toque del botón
    private var actividad: Imageactividades? // Almacenar la actividad actual
    
    func setup(with imageactividades: Imageactividades){
        self.actividad = imageactividades
        mainImageView.image = imageactividades.image
        mainLabel.text = imageactividades.tittle
    }
    
    @IBAction func mainButtonTapped(_ sender: UIButton) {
    // Llamar al delegado cuando se presione el botón
        if let actividad = actividad {
            delegate?.didTapInfoButton(for: actividad)
        }
    }
    
}
