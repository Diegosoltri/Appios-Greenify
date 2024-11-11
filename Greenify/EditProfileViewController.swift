//
//  EditProfileViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 10/11/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

// Define el protocolo para el delegado
protocol EditProfileViewControllerDelegate: AnyObject {
    func didUpdateProfileData()
}

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var instagramTextField: UITextField!
    
    weak var delegate: EditProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfileData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveProfileData()
    }
    
    private func loadProfileData() {
        // Referencia a Firestore
        let db = Firestore.firestore()

        // Asegurarse de que userId no sea nil
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: Usuario no autenticado")
            return
        }

        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.usernameTextField.text = data?["username"] as? String ?? ""
                self.locationTextField.text = data?["location"] as? String ?? ""
                self.instagramTextField.text = data?["instagram"] as? String ?? ""
            } else {
                print("Documento no encontrado o error: \(String(describing: error))")
            }
        }
    }

    private func saveProfileData() {
        // Referencia a Firestore
        let db = Firestore.firestore()
        // Asegurarse de que userId no sea nil
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: Usuario no autenticado")
            return
        }
        
        // Datos a guardar
        let profileData: [String: Any] = [
            "username": usernameTextField.text ?? "",
            "location": locationTextField.text ?? "",
            "instagram": instagramTextField.text ?? ""
        ]
        
        // Guardar los datos en Firestore
        db.collection("users").document(userId).setData(profileData) { error in
            if let error = error {
                print("Error al guardar los datos: \(error.localizedDescription)")
            } else {
                print("Datos guardados correctamente")
                // Puedes añadir una notificación de éxito
                self.delegate?.didUpdateProfileData()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
