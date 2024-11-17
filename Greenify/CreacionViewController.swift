//
//  CreacionViewController.swift
//  Greenify
//
//  Created by Diego Soltri on 08/10/24.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class CreacionViewController: UIViewController {
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        
        // Agregar gesto para ocultar teclado
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
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
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        confirmPasswordTextField.inputAccessoryView = toolbar
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, password == confirmPassword, let usuario = usuarioTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password){
                (result, error) in
                if let result = result, error == nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let registroViewController = storyboard.instantiateViewController(withIdentifier: "RegistroViewController") as? RegistroViewController {
                        self.navigationController?.pushViewController(registroViewController, animated: true)
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
                if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                       // Reemplazar la raíz de la ventana con el Tab Bar Controller
                        window.rootViewController = tabBarController
                        window.makeKeyAndVisible()
                    }
                    }
                }
            }
    }
    
    

}
