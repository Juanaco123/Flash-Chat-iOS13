//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Juan Camilo Victoria Pacheco on 17/06/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

/* MARK: Unnoficial convention
 Constant = keywords => K
 */

struct K {
  static let appName: String = "⚡️FlashChat"
  static let cellIdentifier: String = "ReusableCell"
  static let cellNibName: String = "MessageCell"
  static let registerSegue: String = "RegisterToChat"
  static let loginSegue: String = "LoginToChat"
  
  struct BrandColors {
    static let purple: String = "BrandPurple"
    static let lightPurple: String = "BrandLightPurple"
    static let blue: String = "BrandBlue"
    static let lighBlue: String = "BrandLightBlue"
  }
  
  struct FStore {
    static let collectionName: String = "messages"
    static let senderField: String = "sender"
    static let bodyField: String = "body"
    static let dateField: String = "date"
  }
}
