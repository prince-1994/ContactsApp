//
//  URLSessionProtocol.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 20/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}
