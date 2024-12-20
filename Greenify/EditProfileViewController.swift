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
    private var selectedImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfileData()
        configureTextFields()
        
        // Agregar gesto para ocultar teclado
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func configureTextFields() {
        // Configurar el toolbar con el botón "Listo"
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(hideKeyboard))
        toolbar.items = [flexSpace, doneButton]
        
        // Asignar el toolbar a los textFields
        usernameTextField.inputAccessoryView = toolbar
        locationTextField.inputAccessoryView = toolbar
        instagramTextField.inputAccessoryView = toolbar
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveProfileData()
    }
    
    
    @IBAction func changeImageButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let imageSelectorVC = storyboard.instantiateViewController(withIdentifier: "ImageSelectorViewController") as? ImageSelectorViewController {
            imageSelectorVC.delegate = self // Asigna el delegado
            present(imageSelectorVC, animated: true, completion: nil)
        }
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
                if let profileImageName = data?["profileImage"] as? String {
                    self.selectedImageName = profileImageName
                }
            } else {
                print("Documento no encontrado o error: \(String(describing: error))")
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    private func saveProfileData() {
        
        // Validar campos obligatorios
        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: "Por favor, ingresa un nombre de usuario.")
            return
        }
        
        guard let location = locationTextField.text, !location.isEmpty else {
            showAlert(message: "Por favor, ingresa una ubicación.")
            return
        }
        
        guard let instagram = instagramTextField.text, !instagram.isEmpty else {
            showAlert(message: "Por favor, ingresa un enlace de Instagram.")
            return
        }
        
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: Usuario no autenticado")
            return
        }
        
        // Usar un nombre que identifique el ícono predeterminado, como "person.fill"
        let profileImageToSave = selectedImageName ?? "person.fill"
        let profileData: [String: Any] = [
            "username": usernameTextField.text ?? "",
            "location": locationTextField.text ?? "",
            "instagram": instagramTextField.text ?? "",
            "profileImage": profileImageToSave
        ]
        
        db.collection("users").document(userId).setData(profileData) { error in
            if let error = error {
                print("Error al guardar los datos: \(error.localizedDescription)")
            } else {
                print("Datos guardados correctamente")
                NotificationCenter.default.post(name: .profileImageUpdated, object: nil, userInfo: ["imageName": profileImageToSave])
                self.delegate?.didUpdateProfileData()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}

extension EditProfileViewController: ImageSelectorDelegate {
    func didSelectImage(named imageName: String) {
        selectedImageName = imageName
    }
}

extension Notification.Name {
    static let profileImageUpdated = Notification.Name("profileImageUpdated")
}
