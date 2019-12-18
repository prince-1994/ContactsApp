//
//  CAError.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

enum AppError : Error {
    case networkError(code : Int, message : String)
    case parsingError(message : String)
    case miscellaneous(message : String)
    case unknown(message : String)
}
