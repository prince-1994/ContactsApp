//
//  ContactEditVC.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ContactEditVC: UIViewController {
    
    var contact : Contact!
    var contactsProvider = ContactsProvider.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func configureNavigationBar() {
        self.title = ""
        
    }

}
