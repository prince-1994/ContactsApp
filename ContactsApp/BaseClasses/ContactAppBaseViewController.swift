//
//  CABaseViewController.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ContactAppBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showToast(image : UIImage?, title : String?,body : String?) {
        DispatchQueue.main.async { [weak self] in
            guard let view = self?.view else { return }
            let toast = CAModalToastView.getStatusView(image: image , title: title, body: body, frame: nil)
            toast.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(toast)
            toast.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            toast.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                toast.removeFromSuperview()
            }
        }
    }

}
