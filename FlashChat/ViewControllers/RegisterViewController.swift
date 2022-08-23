//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by McKenzie Macdonald on 8/22/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.alpha = 0
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        // TODO: Make a function in a model to verify the email is in email format else return nil and error
        // TODO: Make a function in a model to verify the password is complicated enough else return nil and error
        
        if let cleanedEmail = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let cleanedPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            Auth.auth().createUser(withEmail: cleanedEmail, password: cleanedPassword) { dataResult, error in
                
                guard error == nil else {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                    print(error!.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
                
                
            }
        }
        
        
        
        
    }
    
    // MARK: - Navigation

}
