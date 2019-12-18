//
//  ContactsProvider.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation

class ContactsProvider {
    
    static let shared = ContactsProvider()
    
    private var contacts = [Contact]()
    let networkAPIHandler = ContactNetworkAPIHandler()
    
    init() {
        networkAPIHandler.getAllContacts {[weak self] (result) in
            switch result {
            case .success(let allContacts):
                self?.contacts = allContacts
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: CONTACTS_LOADED_SUCCESSFULLY), object: self)
            case .failure(_) :
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: CONTACTS_LOADING_FAILED), object: self)
                break
            }
        }
        
    }
    
    func getAllContacts() -> [Contact] {
        return contacts
    }
    
    func addNewContact(contact : Contact) {
        networkAPIHandler.createContact(with: contact) { [weak self] (result) in
            switch result {
            case .success(let contact):
                self?.contacts.append(contact)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NEW_CONTACT_CREATED), object: self)
            case .failure(_) :
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NEW_CONTACT_CREATION_FAILED), object: self)
                break
            }
        }
    }
    
    func updateContact(for id : Int, contact : Contact) {
        networkAPIHandler.updateContact(for: id, with: contact) { [weak self] (result) in
            switch result {
            case .success(let contact):
                if let index = self?.contacts.firstIndex(where : { $0.id == id }) {
                    self?.contacts[index] = contact
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: CONTACT_UPDATED_SUCCESSFULLY), object: self)
            case .failure(_):
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: CONTACT_UPDATE_FAILED), object: self)
                break
            }
        }
    }
    
}