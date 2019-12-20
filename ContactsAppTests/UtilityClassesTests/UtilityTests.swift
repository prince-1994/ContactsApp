//
//  UtilityTests.swift
//  ContactsAppTests
//
//  Created by Yuvraj Sahu on 20/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import XCTest
@testable import ContactsApp

class UTilityTests : XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBinarySearch() {
        let arr = [1,2,3,4,5]
        XCTAssertEqual(Utility.binarySearch(arr, 3) { $0 < $1 ? -1 : ($0 == $1 ? 0 : 1) }, 2, "incorrect location")
        XCTAssertEqual(Utility.binarySearch(arr, 0) { $0 < $1 ? -1 : ($0 == $1 ? 0 : 1) }, 0, "incorrect location")
        XCTAssertEqual(Utility.binarySearch(arr, 6) { $0 < $1 ? -1 : ($0 == $1 ? 0 : 1) }, 5, "incorrect location")
        let arr1 : [Int] = []
        XCTAssertEqual(Utility.binarySearch(arr1, 3) { $0 < $1 ? -1 : ($0 == $1 ? 0 : 1) }, 0, "incorrect location")
        XCTAssertEqual(Utility.binarySearch(arr1, 0) { $0 < $1 ? -1 : ($0 == $1 ? 0 : 1) }, 0, "incorrect location")
        XCTAssertEqual(Utility.binarySearch(arr1, 6) { $0 < $1 ? -1 : ($0 == $1 ? 0 : 1) }, 0, "incorrect location")
    }
    
//    func testPhoneNumberValidation() {
//        XCTAssertTrue(Utility.isValidPhoneNumber(string: "+919999999999"),"false negative phone number validation")
//        XCTAssertFalse(Utility.isValidPhoneNumber(string: "+919hsh"), "false positive phone number validation")
//        XCTAssertFalse(Utility.isValidPhoneNumber(string: "+91983938292829289228981291829383938932898292"), "false positive phone number validation")
//    }
//    
//    func testEmailValidation() {
//        XCTAssertTrue(Utility.isValidEmail(string: "ajsj@ajs.com"),"false negative phone number validation")
//        XCTAssertFalse(Utility.isValidEmail(string: "+919"), "false positive phone number validation")
//        XCTAssertFalse(Utility.isValidEmail(string: "sjdadj@jdj"), "false positive phone number validation")
//    }
}
