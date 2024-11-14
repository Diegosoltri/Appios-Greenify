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
    @IBOutlet weak var userImage: UIImageView!
    
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
            self.logOut()
        }
        
        let menu = UIMenu(title: "Opciones", children: [editInfoAction, logoutAction])
        
        // Asignar el menú al botón del Storyboard
        profileButton.menu = menu
        profileButton.showsMenuAsPrimaryAction = true
        // Observar la notificación de actualización de imagen de perfil
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfileImage(_:)), name: .profileImageUpdated, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .profileImageUpdated, object: nil)
    }
    
    func didUpdateProfileData() {
        loadProfileData() // Recargar los datos del perfil desde Firestore
    }
    
    private func loadProfileData() {
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: Usuario no autenticado")
            return
        }

        db.collection("users").document(userId).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let document = document, document.exists {
                let data = document.data()
                self.nameLabel.text = data?["username"] as? String ?? "Sin nombre"
                self.locationLabel.text = data?["location"] as? String ?? "Sin ubicación"
                self.instagramURL = data?["instagram"] as? String ?? ""

                // Validar y cargar la imagen de perfil
                if let profileImageName = data?["profileImage"] as? String, !profileImageName.isEmpty {
                    if profileImageName == "person.fill" {
                        // Mostrar el ícono de SF Symbols
                        self.userImage.image = UIImage(systemName: "person.fill")
                        self.userImage.tintColor = .gray // Cambia el color si lo deseas
                    } else {
                        // Mostrar una imagen personalizada
                        self.userImage.image = UIImage(named: profileImageName)
                    }
                } else {
                    // Si no hay imagen, asignar el ícono predeterminado
                    self.userImage.image = UIImage(systemName: "person.fill")
                    self.userImage.tintColor = .gray
                }
            } else {
                print("Documento no encontrado o error: \(String(describing: error))")
            }
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let screenshot = takeScreenshot() else {
            print("No se pudo tomar la captura de pantalla")
            return
        }
        shareImage(screenshot)
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
    @objc private func updateProfileImage(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let imageName = userInfo["imageName"] as? String else {
            return
        }
        // Actualizar la imagen del perfil en tiempo real
        userImage.image = UIImage(named: imageName)
    }
    
    // Método para tomar la captura de pantalla
    private func takeScreenshot() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        return renderer.image { context in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
    
    // Método para abrir el menú de compartir
    private func shareImage(_ image: UIImage) {
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view // Para iPads
        present(activityController, animated: true, completion: nil)
    }
    
    // Método para cerrar sesión
    private func logOut() {
        do {
            try Auth.auth().signOut()
            print("Sesión cerrada correctamente")
            navigateToLogin()
        } catch let error {
            print("Error al cerrar sesión: \(error.localizedDescription)")
            showAlert(message: "No se pudo cerrar la sesión. Inténtalo de nuevo.")
        }
    }
    
    private func navigateToLogin() {
        // Asegúrate de que el ViewController tiene el Storyboard ID configurado
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            loginVC.modalPresentationStyle = .fullScreen // Mostrar en pantalla completa
            present(loginVC, animated: true, completion: nil)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

