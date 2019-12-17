//
//  ImageDownloader.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

struct CAError : Error {
    let message : String
}

class ImageDownloader {
    
    func downloadImage(urlString : String , onCompletion : ((UIImage) -> Void)?, onFailure : ((Error) -> Void)?) {
        guard let url = URL(string : urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                onFailure?(error)
            } else if let data = data {
                guard let image = UIImage(data: data) else {
                    onFailure?(CAError(message: "not able to parse data"))
                    return
                }
                onCompletion?(image)
            } else {
                print(response as Any)
            }
        }.resume()
        
    }
}
