//
//  ContactInfoTextField.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ContactInfoTextField: NibView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    var text : String? {
        get {
            self.valueTextField.text
        }
        set {
            self.valueTextField.text = newValue
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setValues(name : String, value : String) {
        self.nameLabel.text = name
        self.valueTextField.text = value
    }
}
