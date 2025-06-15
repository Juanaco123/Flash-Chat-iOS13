//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextfield: UITextField!
  @IBOutlet weak var passwordTextfield: UITextField!
  
  @IBAction func loginPressed(_ sender: UIButton) {
    if let email: String = emailTextfield.text,
       let password: String = passwordTextfield.text {
      let authentication: Auth = Auth.auth()
      
      authentication.signIn(withEmail: email, password: password) { [weak self] authResult, error in
        guard let self = self else { return }
        
        if error != nil {
          let alert: UIAlertController = UIAlertController(title: "Invalid credentials", message: "Please check your credentials.", preferredStyle: .alert)
          self.present(alert, animated: true)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
          self.performSegue(withIdentifier: "LoginToChat", sender: self)
        }
      }
    }
  }
}
