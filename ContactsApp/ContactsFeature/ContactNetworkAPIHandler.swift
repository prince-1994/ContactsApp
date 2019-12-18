//
//  RestAPIManager.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation

class ContactNetworkAPIHandler : ContactsAppNetworkAPIHandler {
    
    let contactsEndpoint = "/contacts"
    let dotJson = ".json"
    let baseURL = "https://gojek-contacts-app.herokuapp.com"
    
    
    func getAllContacts(onCompletion : @escaping ((Result<[Contact],ContactsAppError>) -> Void)) {
        let urlString : String = baseURL + contactsEndpoint + dotJson
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        makeAPICall(with: request, onCompletion: onCompletion)
            
    }
    
    func getContact(for id: Int, onCompletion : @escaping ((Result<Contact,ContactsAppError>) -> Void)) {
        let urlString : String = baseURL + contactsEndpoint + "/\(id)" + dotJson
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        makeAPICall(with: request, onCompletion: onCompletion)
    }
    
    func createContact(with data : Data , onCompletion : @escaping ((Result<Contact,ContactsAppError>) -> Void)) {
        let urlString : String = baseURL + contactsEndpoint + dotJson
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = data
        makeAPICall(with: request, onCompletion: onCompletion)
    }
    
    func updateContact(with data : Data, for id : Int, onCompletion : @escaping ((Result<Contact,ContactsAppError>) -> Void)) {
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
