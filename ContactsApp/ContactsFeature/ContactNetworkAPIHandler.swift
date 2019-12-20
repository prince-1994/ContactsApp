//
//  RestAPIManager.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation

class ContactNetworkAPIHandler : ContactsAppNetworkAPIHandler, ContactNetworkAPIHandlerProtocol {
    
    private let contactsEndpoint = "/contacts"
    private let dotJson = ".json"
    private let baseURL = "https://gojek-contacts-app.herokuapp.com"
    
    
    func getAllContacts(onCompletion : @escaping ((Result<[Contact],AppError>) -> Void)) {
        let urlString : String = baseURL + contactsEndpoint + dotJson
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        makeAPICall(with: request, onCompletion: onCompletion)
            
    }
    
    func getContact(for id: Int, onCompletion : @escaping ((Result<Contact,AppError>) -> Void)) {
        let urlString : String = baseURL + contactsEndpoint + "/\(id)" + dotJson
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        makeAPICall(with: request, onCompletion: onCompletion)
    }
    
    func createContact(with contact : Contact , onCompletion : @escaping ((Result<Contact,AppError>) -> Void)) {
        guard let data = try? JSONEncoder().encode(contact) else { return }
        let urlString : String = baseURL + contactsEndpoint + dotJson
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = data
        makeAPICall(with: request, onCompletion: onCompletion)
    }
    
    func updateContact(for id : Int, with contact : Contact, onCompletion : @escaping ((Result<Contact,AppError>) -> Void)) {
        guard let data = try? JSONEncoder().encode(contact) else { return }
        let urlString : String = baseURL + contactsEndpoint + "/\(id)" +  dotJson
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = data
        makeAPICall(with: request, onCompletion: onCompletion)
    }
    
}
