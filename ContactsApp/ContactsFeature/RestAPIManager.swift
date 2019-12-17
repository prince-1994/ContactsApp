//
//  RestAPIManager.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation

class ContactNetworkAPIHandler {
    
    let contactsEndpoint = "/contacts"
    let dotJson = ".json"
    let baseURL = "https://gojek-contacts-app.herokuapp.com"
    
    
    func getAllContacts(onSuccess : (([Contact]) -> Void)?, onFailure : ((CAError) -> Void)?) {
        let url : String = baseURL + contactsEndpoint + dotJson
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data,response,error) in
            
        }
        task.resume()
    }
    
    func getContact(for id: Int, onSuccess : ((Contact) -> Void)?, onFailure : ((CAError) -> Void)?) {
        let url : String = baseURL + contactsEndpoint + "/\(id)" + dotJson
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data,response,error) in
            
        }
        task.resume()
    }
    
    func createContact(with data : Data , onSuccess : ((Contact) -> Void)?, onFailure : ((CAError) -> Void)?) {
        let url : String = baseURL + contactsEndpoint + dotJson
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = data
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data,response,error) in
            
        }
        task.resume()
    }
    
    func updateContact(with data : Data, for id : Int, onSuccess : ((Contact) -> Void)?, onFailure : ((CAError) -> Void)?) {
        let url : String = baseURL + contactsEndpoint + "/\(id)" +  dotJson
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = data
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data,response,error) in
            
        }
        task.resume()
    }
}
