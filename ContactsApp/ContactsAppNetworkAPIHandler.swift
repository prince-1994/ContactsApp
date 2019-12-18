//
//  NetworkAPIHandler.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation

struct ContactAppNetworkError : Error, Codable {
    var code : Int
    var message : String
}

class ContactsAppNetworkAPIHandler {
    private var session = URLSession.shared
    
    func makeAPICall<T : Codable>(with request : URLRequest, onCompletion: @escaping ((Result<T,ContactsAppError>) -> Void), urlSession : URLSession? = nil) {
        let session = urlSession ?? self.session
        session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let result : Result<T,ContactsAppError> = self?.parseResponse(data: data, response: response, error: error) else { return }
            onCompletion(result)
        }.resume()
    }
    
    func makeAPICall(with request : URLRequest, urlSession : URLSession? = nil) {
        let session = urlSession ?? self.session
        session.dataTask(with: request).resume()
    }
    
    func makeAPICall<T : Codable>(with url : URL, onCompletion: @escaping ((Result<T,ContactsAppError>) -> Void), urlSession : URLSession? = nil) {
        let session = urlSession ?? self.session
        session.dataTask(with: url) { [weak self]  (data, response, error) in
            guard let result : Result<T,ContactsAppError> = self?.parseResponse(data: data, response: response, error: error) else { return }
            onCompletion(result)
        }.resume()
    }
    
    func makeAPICall(with url : URL, urlSession : URLSession? = nil) {
        let session = urlSession ?? self.session
        session.dataTask(with: url).resume()
    }
    
    
    func parseResponse<T:Codable>(data : Data?, response :  URLResponse?, error : Error?) -> Result<T,ContactsAppError> {
        if let error = error {
            if let data = data {
                do {
                    let error = try JSONDecoder().decode(ContactAppNetworkError.self, from: data)
                    return .failure(ContactsAppError.networkError(code: error.code, message: error.message))
                } catch {
                    return .failure(ContactsAppError.parsingError(message: "Failed to parse error object"))
                }
            } else if let response = response as? HTTPURLResponse {
                return .failure(ContactsAppError.networkError(code: response.statusCode, message: error.localizedDescription))
            } else {
                return .failure(ContactsAppError.miscellaneous(message: "not a http response"))
            }
        } else if let data = data {
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                return .success(model)
            } catch {
                return .failure(ContactsAppError.parsingError(message: "Not able to parse data"))
            }
        } else if let response = response {
            if let httpResponse = response as? HTTPURLResponse {
                return .failure(ContactsAppError.networkError(code: httpResponse.statusCode, message: "Data not received"))
            } else {
                return .failure(ContactsAppError.miscellaneous(message: "not a http response"))
            }
        } else {
            return .failure(ContactsAppError.unknown(message: "no response, no data, no error recieved"))
        }
    }
    
    
}
