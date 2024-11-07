//
//  MainCollectionViewCell.swift
//  Greenify
//
//  Created by Diego Soltri on 04/11/24.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    func setup(with imageactividades: Imageactividades){
        mainImageView.image = imageactividades.image
        mainLabel.text = imageactividades.tittle
    }
    
}
