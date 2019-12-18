//
//  ImageDownloader.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    func downloadImage(urlString : String , onCompletion : @escaping (Result<UIImage,AppError>) -> Void) {
        guard let url = URL(string : urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let result = self?.parseResponse(data : data, response : response, error : error) else { return }
            onCompletion(result)
        }.resume()
        
    }
    
    func parseResponse(data : Data?, response :  URLResponse?, error : Error?) -> Result<UIImage,AppError> {
        if let error = error {
            if let response = response as? HTTPURLResponse {
                return .failure(.networkError(code: response.statusCode, message: error.localizedDescription))
            } else {
                return .failure(.miscellaneous(message: "not a http response"))
            }
        } else if let data = data {
            if let image = UIImage(data : data) {
                return .success(image)
            } else {
                return .failure(.parsingError(message: "Not able to parse data"))
            }
        } else if let response = response {
            if let httpResponse = response as? HTTPURLResponse {
                return .failure(.networkError(code: httpResponse.statusCode, message: "Data not received"))
            } else {
                return .failure(.miscellaneous(message: "not a http response"))
            }
        } else {
            return .failure(.unknown(message: "no response, no data, no error recieved"))
        }
    }
}
