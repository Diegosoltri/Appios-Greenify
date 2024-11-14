//
//  ImageCell.swift
//  Greenify
//
//  Created by Diego Soltri on 13/11/24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
    
}
