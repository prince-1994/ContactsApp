//
//  CAModalToastView.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 22/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class CAModalToastView : NibView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    static func getStatusView(image : UIImage?, title : String? , body : String?, frame : CGRect? = nil) -> UIView {
        let newFrame = frame ?? CGRect(x: 0, y: 0, width: 200, height: 300)
        let view = CAModalToastView(frame: newFrame)
        addBlurBackground(view: view)
        view.imageView.image = image
        view.headingLabel.text = title
        view.bodyLabel.text = body
        view.layer.cornerRadius = 25.0
        view.clipsToBounds = true
        return view
    }
    
    private static func addBlurBackground(view : UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
    }
    
}
