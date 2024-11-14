//
//  ImageSelectorViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 13/11/24.
//
import FirebaseFirestore
import FirebaseAuth
import UIKit

protocol ImageSelectorDelegate: AnyObject {
    func didSelectImage(named imageName: String)
}

class ImageSelectorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    weak var delegate: ImageSelectorDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var availableImages: [String] = [] // Lista de nombres de imágenes
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadAvailableImages()
    }
    
    private func loadAvailableImages() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userId).collection("logros")
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error al cargar imágenes: \(error.localizedDescription)")
                    return
                }
                // Filtrar logros con estrellasActuales == estrellasRequeridas
                self?.availableImages = snapshot?.documents.compactMap { document in
                    let data = document.data()
                    guard let estrellasActuales = data["estrellasActuales"] as? Int,
                          let estrellasRequeridas = data["estrellasRequeridas"] as? Int,
                          estrellasActuales == estrellasRequeridas else { return nil }
                    return data["imagenNombre"] as? String
                } ?? []
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let imageName = availableImages[indexPath.row]
        // Cargar la imagen
        cell.configure(with: UIImage(named: imageName))
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = availableImages[indexPath.row]
        print("Imagen seleccionada: \(selectedImage)")
        // Notificar al delegado
        delegate?.didSelectImage(named: selectedImage)
        
        // Cerrar el modal
        dismiss(animated: true, completion: nil)
    }
}
