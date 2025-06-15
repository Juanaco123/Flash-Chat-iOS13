//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "⚡️FlashChat"
    navigationItem.hidesBackButton = true
  }
  
  @IBAction func sendPressed(_ sender: UIButton) {
  }
  
  @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
    let authentication: Auth = Auth.auth()
    if let navController = navigationController {
      navController.popToRootViewController(animated: true)
    }
    do {
      try authentication.signOut()
      
    } catch {
      print("🛑 Failed to logout: %@ \(error)")
    }
  }
  
}
