//
//  RegistoViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 07/10/24.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class RegistroViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var iniciarButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func iniciarButtonAction(_ sender: Any) {
    
        if let email = emailTextField.text, let password = passwordTextField.text{
            
            Auth.auth().signIn(withEmail: email, password: password){
                (result, error) in
                if let result = result, error == nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                        self.navigationController?.pushViewController(homeViewController, animated: true)
                    }
                                        
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    @IBAction func googleButtonAction(_ sender: UIButton) {
        
        // Obtener el clientID desde Firebase
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Crear la configuración de Google Sign In
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        // Iniciar el flujo de inicio de sesión con Google
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            
            // Manejar el error
            guard error == nil else {
                print("Error en Google Sign-In: \(error!.localizedDescription)")
                return
            }

            // Verificar que el usuario y los tokens sean válidos
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                print("Error: No se pudieron obtener las credenciales de Google.")
                return
            }

            // Crear las credenciales de Firebase usando el token de Google
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            // Autenticar en Firebase con las credenciales de Google
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error al autenticar con Firebase: \(error.localizedDescription)")
                    return
                }
                    
                // Usuario autenticado correctamente, redirigir a la pantalla principal
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                    }
                }
            }
        }
}
    

