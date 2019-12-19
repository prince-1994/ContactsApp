//
//  CommunicationHandler.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 19/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation
import UIKit

class CommunicationHandler {
    static let shared = CommunicationHandler()
    private init() { }
    
    func makeAPhoneCall(to number : String) throws {
        guard Utility.isValidPhoneNumber(string : number) else { return }
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func writeTextMessage(to number : String) throws {
        guard Utility.isValidPhoneNumber(string : number) else { return }
        if let url = URL(string: "sms:\(number)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func writeAnEmail(to email : String) throws {
        guard Utility.isValidEmail(string: email) else { return }
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
