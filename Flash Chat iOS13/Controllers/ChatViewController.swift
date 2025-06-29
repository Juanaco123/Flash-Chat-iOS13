//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  let db = Firestore.firestore()
  
  var messages: [Message] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor(named: "BrandPurple")
    self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    tableView.dataSource = self
    title = K.appName
    navigationItem.hidesBackButton = true
    
    tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    
    loadMessages()
  }
  
  func loadMessages() {
    
    db.collection(K.FStore.collectionName)
      .order(by: K.FStore.dateField)
      .addSnapshotListener { querySnapshot, error in
        self.messages = []
        
        if let error = error {
          print("🛑 There was an error retrieving data from Firestore \(error)")
        } else {
          guard let snapshot = querySnapshot?.documents else { return }
          for document in snapshot {
            let userData = document.data()
            if let sender = userData[K.FStore.senderField] as? String,
               let message = userData[K.FStore.bodyField] as? String {
              
              let newMessage: Message = Message(sender: sender, body: message)
              self.messages.append(newMessage)
              
              DispatchQueue.main.async {
                self.tableView.reloadData()
              }
            }
          }
        }
      }
  }
  
  @IBAction func sendPressed(_ sender: UIButton) {
    guard let messageBody: String = messageTextfield.text,
          let messageSender: String = Auth.auth().currentUser?.email else { return }
    
    db.collection(K.FStore.collectionName).addDocument(
      data: [
        K.FStore.senderField: messageSender,
        K.FStore.bodyField: messageBody,
        K.FStore.dateField: Date().timeIntervalSince1970
      ]) { error in
        if let error = error {
          print("There was an issue saving data to firestore: \(error)")
        } else {
          print("Successfully saved data.")
        }
      }
    messageTextfield.text = nil
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

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
    
    cell.label.text = messages[indexPath.row].body
    return cell
  }
}
