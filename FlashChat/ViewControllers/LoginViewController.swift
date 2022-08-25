//
//  LoginViewController.swift
//  FlashChat
//
//  Created by McKenzie Macdonald on 8/22/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        errorLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        loginUser()
    
    }
    
    func loginUser() {
        errorLabel.alpha = 0
        
        if let cleanedEmail = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let cleanedPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            Auth.auth().signIn(withEmail: cleanedEmail, password: cleanedPassword) { dataResult, error in
                
                guard error == nil else {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                    return
                }
                
                self.performSegue(withIdentifier: K.loginSegue, sender: self)
                
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginUser()
        }
        return true
    }
    
}
