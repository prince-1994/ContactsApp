//
//  ContactNetworkAPIHandlerMock.swift
//  ContactsAppTests
//
//  Created by Yuvraj Sahu on 20/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation
@testable import ContactsApp

class ContactNetworkAPIHandlerMock : ContactNetworkAPIHandlerProtocol {
    
    private var allContacts = [[Contact]]()
    func getAllContacts(onCompletion : @escaping ((Result<[Contact],AppError>) -> Void)) {
        
            
    }
    
    func getContact(for id: Int, onCompletion : @escaping ((Result<Contact,AppError>) -> Void)) {
        
    }
    
    func createContact(with contact : Contact , onCompletion : @escaping ((Result<Contact,AppError>) -> Void)) {
    }
    
    func updateContact(for id : Int, with contact : Contact, onCompletion : @escaping ((Result<Contact,AppError>) -> Void)) {
        
    }
}
