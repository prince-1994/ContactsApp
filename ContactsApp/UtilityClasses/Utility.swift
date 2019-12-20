//
//  Utility.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 19/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

class Utility {
    static func binarySearch<T> (_ arr : [T],_ item : T, by comparison : (T,T) -> Int ) -> Int {
        var start = 0, end = arr.count-1
        var mid = 0
        while (start <= end) {
            mid = start + (end - start)/2
            if comparison(arr[mid], item) == 0 { return mid }
            else if comparison(arr[mid], item) < 0 { start = mid + 1 }
            else { end = mid - 1 }
        }
        return end + 1
    }
    
    static func isValidPhoneNumber(string : String) -> Bool {
        return true
    }
    
    static func isValidEmail(string : String) -> Bool {
        return true
    }
}
