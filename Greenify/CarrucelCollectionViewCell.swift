//
//  CarrucelCollectionViewCell.swift
//  Greenify
//
//  Created by Diego Soltri on 21/10/24.
//

import UIKit

class CarrucelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonView: UIButton!
    
    
    func setup(with actividades: Actividades){
        buttonView.setTitle(actividades.tittle, for: .normal)
    }
}
