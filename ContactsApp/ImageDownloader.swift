//
//  ImageDownloader.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    func downloadImage(urlString : String , onCompletion : @escaping (Result<UIImage,ContactsAppError>) -> Void) {
        guard let url = URL(string : urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let result = self?.parseResponse(data : data, response : response, error : error) else { return }
            onCompletion(result)
        }.resume()
        
    }
    
    func parseResponse(data : Data?, response :  URLResponse?, error : Error?) -> Result<UIImage,ContactsAppError> {
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
            if let image = UIImage(data : data) {
                return .success(image)
            } else {
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
