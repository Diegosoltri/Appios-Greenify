//
//  HomeViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 08/10/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var MaincollectionView: UICollectionView!
    
    
       
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MaincollectionView.dataSource = self
        MaincollectionView.delegate = self
        
        // Configurar el layout para MaincollectionView en dos columnas
        let mainLayout = UICollectionViewFlowLayout()
        mainLayout.scrollDirection = .vertical
        mainLayout.minimumLineSpacing = 10 // Espacio entre filas
        mainLayout.minimumInteritemSpacing = 10 // Espacio entre elementos en la misma fila
        MaincollectionView.collectionViewLayout = mainLayout

        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Configurar el layout para desplazamiento horizontal en collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == MaincollectionView {
            return imageactividades.count
        }
        return actividades.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == MaincollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
            cell.setup(with: imageactividades[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarrucelCollectionViewCell", for: indexPath) as! CarrucelCollectionViewCell
            cell.setup(with: actividades[indexPath.row])
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == MaincollectionView {
            let padding: CGFloat = 10 // Ajusta este valor según el espaciado deseado
            let cellWidth = (MaincollectionView.bounds.width - padding) / 2 // Dividir el ancho entre dos columnas
            return CGSize(width: cellWidth, height: 300) // Ajusta la altura según lo necesites
        } else {
            return CGSize(width: 120, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == MaincollectionView {
            return 20
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == MaincollectionView {
            return 5
        }
        return 0
    }
}

