//
//  ContactCallToActionImageButton.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ContactCallToActionImageButton: NibView {
    @IBOutlet weak var ctaImageView: UIImageView!
    @IBOutlet weak var ctaNameLabel: UILabel!
    
    var action : (() -> Void)?
    
    override func xibSetup() {
        super.xibSetup()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(callToAction))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func callToAction() {
        action?()
    }
    
    func set(name : String, image : UIImage) {
        ctaNameLabel.text = name
        ctaImageView.image = image
    }
}
