//
//  PerfilViewController.swift
//  Greenify
//
//  Created by Jose Galindo on 04/11/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PerfilViewController: UIViewController, EditProfileViewControllerDelegate {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var instagramButton: UIButton!
    
    private var instagramURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfileData()
        
        // Configurar el menú
        let editInfoAction = UIAction(title: "Edita tu información", image: UIImage(systemName: "pencil")) { [weak self] _ in
            self?.performSegue(withIdentifier: "editProfileSegue", sender: nil)
        }
        let logoutAction = UIAction(title: "Cerrar sesión", image: UIImage(systemName: "arrowshape.turn.up.left")) { _ in
            // Aquí puedes añadir la funcionalidad para cerrar sesión
            print("Cerrar sesión")
        }
        
        let menu = UIMenu(title: "Opciones", children: [editInfoAction, logoutAction])
        
        // Asignar el menú al botón del Storyboard
        profileButton.menu = menu
        profileButton.showsMenuAsPrimaryAction = true
        
    }
    
    func didUpdateProfileData() {
        loadProfileData() // Recargar los datos del perfil desde Firestore
    }
    
    private func loadProfileData() {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid ?? ""
        
        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.nameLabel.text = data?["username"] as? String ?? "Sin nombre"
                self.locationLabel.text = data?["location"] as? String ?? "Sin ubicación"
                
                // Configurar el enlace de Instagram
                self.instagramURL = data?["instagram"] as? String ?? ""
                //self.instagramButton.setTitle("Abrir Instagram", for: .normal)
            } else {
                print("Documento no encontrado o error: \(String(describing: error))")
            }
        }
    }
    
    
    @IBAction func openInstagram(_ sender: UIButton) {
        guard let urlString = instagramURL, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            print("URL inválida o no se puede abrir")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editProfileSegue" {
            // Configurar el `ViewController` de destino si es necesario
            let editProfileVC = segue.destination as? EditProfileViewController
            // Puedes pasar datos al `EditProfileViewController` aquí si lo necesitas
            editProfileVC?.delegate = self // Asigna el delegado
        }
    }

}
