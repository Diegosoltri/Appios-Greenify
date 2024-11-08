//
//  HomeViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 08/10/24.
//

import UIKit

class HomeViewController: UIViewController, CarrucelCollectionViewCellDelegate, MainCollectionViewCellDelegate {
    
    @IBOutlet weak var MaincollectionView: UICollectionView!
    
    
       
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Variable para almacenar las imágenes filtradas
    var filteredImageActividades: [Imageactividades] = imageactividades
    
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
    // Método delegado que recibe la categoría seleccionada
    func didTapButton(with actividad: Actividades) {
        filterImages(for: actividad.tittle)
    }
    
    // Método delegado para mostrar el modal con la información de actividad
    func didTapInfoButton(for actividad: Imageactividades) {
        // Crear una instancia de la vista de detalles y pasar la actividad
        let detailVC = ActivityDetailViewController()
        detailVC.actividad = actividad
        present(detailVC, animated: true, completion: nil)
    }
    
    // Filtra las imágenes según la categoría seleccionada
    private func filterImages(for category: String) {
        switch category {
        case "Todos":
            filteredImageActividades = imageactividades
        case "Transporte":
            filteredImageActividades = imageactividades.filter { $0.tittle.contains("bicicleta") || $0.tittle.contains("Camina") || $0.tittle.contains("automóvil") }
        case "Energía":
            filteredImageActividades = imageactividades.filter { $0.tittle.contains("energía") }
        case "Consumo":
            filteredImageActividades = imageactividades.filter { $0.tittle.contains("reciclado") || $0.tittle.contains("termo") || $0.tittle.contains("vivero") }
        case "Desechos":
            filteredImageActividades = imageactividades.filter { $0.tittle.contains("desechos") || $0.tittle.contains("residuos") || $0.tittle.contains("composta") }
        default:
            filteredImageActividades = imageactividades
        }
        MaincollectionView.reloadData() // Recargar MainCollectionView con los datos filtrados
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == MaincollectionView {
            return filteredImageActividades.count
        }
        return actividades.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == MaincollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
            cell.setup(with: filteredImageActividades[indexPath.row])
            cell.delegate = self // Asigna el delegado
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarrucelCollectionViewCell", for: indexPath) as! CarrucelCollectionViewCell
            cell.setup(with: actividades[indexPath.row])
            cell.delegate = self // Asigna el delegado
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == MaincollectionView {
            let padding: CGFloat = 10 // Ajusta este valor según el espaciado deseado
            let cellWidth = (MaincollectionView.bounds.width - padding) / 2 // Dividir el ancho entre dos columnas
            return CGSize(width: cellWidth, height: 250) // Ajusta la altura según lo necesites
        } else {
            let numberOfItemsPerRow: CGFloat = 3 // Número de celdas que deseas en la fila
            let padding: CGFloat = 10 * (numberOfItemsPerRow - 1)
            let cellWidth = (collectionView.bounds.width - padding) / numberOfItemsPerRow
            return CGSize(width: cellWidth, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == MaincollectionView {
            return 40
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

