//
//  Contact.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

struct Contact : Codable, Hashable {
    var id: Int?
    var first_name : String
    var last_name : String
    var phone_number : String?
    var email : String?
    var profile_pic : String?
    var favorite : Bool
    var url : String
}
