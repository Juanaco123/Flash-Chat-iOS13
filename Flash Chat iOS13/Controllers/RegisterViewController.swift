//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
  
  @IBOutlet weak var emailTextfield: UITextField!
  @IBOutlet weak var passwordTextfield: UITextField!
  
  @IBAction func registerPressed(_ sender: UIButton) {
    if let email: String = emailTextfield.text,
       let password: String = passwordTextfield.text {
      let authentication: Auth = Auth.auth()
      
      authentication.createUser(withEmail: email, password: password) { authResult, error in
        if error != nil {
          let alert: UIAlertController = UIAlertController(title: "Weak Password", message: "Your password must be longer than 6 characters.", preferredStyle: .alert)
          self.present(alert, animated: true)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
          self.performSegue(withIdentifier: "RegisterToChat", sender: self)
        }
      }
    }
  }
}
