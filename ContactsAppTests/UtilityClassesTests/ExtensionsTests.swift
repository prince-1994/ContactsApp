//
//  ExtensionsTests.swift
//  ContactsAppTests
//
//  Created by Yuvraj Sahu on 20/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ExtensionsTests : XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testColorsExtention() {
        XCTAssertEqual(UIColor(hex : 0xF0F0F0), UIColor(red: 240, green: 240, blue: 240, alpha: 1.0))
        XCTAssertEqual(UIColor(hex : 0xF0F0F0, alpha: 0.5), UIColor(red: 240, green: 240, blue: 240, alpha: 0.5))
    }
    
    func testEncodableDictionary() {
        let contact = Contact(id: 1, first_name: "first", last_name: "name", phone_number: "+919999999999", email: "ask@ask.com", profile_pic: "arbit.jpg", favorite: true, url: "https://www.google.com")
        let dict = contact.dictionary
        XCTAssertEqual(dict["id"] as? Int, contact.id, "Dictionary id value wrong")
        XCTAssertEqual(dict["first_name"] as? String, contact.first_name, "Dictionary first_name value wrong")
        XCTAssertEqual(dict["last_name"] as? String, contact.last_name, "Dictionary last_name value wrong")
        XCTAssertEqual(dict["phone_number"] as? String, contact.phone_number, "Dictionary phone_number value wrong")
        XCTAssertEqual(dict["email"] as? String, contact.email, "Dictionary email value wrong")
        XCTAssertEqual(dict["profile_pic"] as? String, contact.profile_pic, "Dictionary profile_pic value wrong")
        XCTAssertEqual(dict["favorite"] as? Bool, contact.favorite, "Dictionary favorite value wrong")
        XCTAssertEqual(dict["url"] as? String, contact.url, "Dictionary favorite value wrong")
    }
    
    func testEncodableExtensions() {
        
    }
}
