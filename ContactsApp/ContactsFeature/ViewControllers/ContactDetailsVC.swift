//
//  ContactDetailsVC.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ContactDetailsVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var callToActionButtonStack: UIStackView!
    @IBOutlet weak var ContactInfoTextViewStack: UIStackView!
    @IBOutlet weak var messageCTAButton: ContactCallToActionImageButton!
    @IBOutlet weak var callCTAButton: ContactCallToActionImageButton!
    @IBOutlet weak var emailCTAButton: ContactCallToActionImageButton!
    @IBOutlet weak var favoriteCTAButton: ContactCallToActionImageButton!
    @IBOutlet weak var emailTextView: ContactInfoTextField!
    @IBOutlet weak var mobileTextView: ContactInfoTextField!
    
    private var contact : Contact!
    private var contactsProvider = ContactsProvider.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(updateContactModel), name: NSNotification.Name(rawValue: CONTACT_UPDATED_SUCCESSFULLY), object: nil)
        configureNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateAllDynamicUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTopView()
    }
    
    // MARK: Configuration methods
    
    func configureNavigationBar() {
        self.title = ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: EDIT_BAR_BUTTON_TEXT, style: .plain, target: self, action: #selector(editButtonTapped))
    }
    
    func configureTopView() {
        topView.applyGradient(colours: [AppTheme.BASE_COLOR_2,AppTheme.BASE_COLOR_1], locations: [0.0,1.0])
    }
    
    // MARK: Helper Methods
    
    @objc func updateContactModel(notification : Notification) {
        guard let userInfo = notification.userInfo, let contact = try? JSONDecoder().decode(Contact.self, from: JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)) else { return }
        self.contact = contact
        DispatchQueue.main.async { [weak self] in
            self?.updateAllDynamicUI()
        }
    }
    
    func set(contact : Contact) {
        self.contact = contact
        guard let id = contact.id else { return }
        contactsProvider.getContact(for: id) {[weak self] (result) in
            switch result {
            case .success(let contact):
                self?.contact = contact
                DispatchQueue.main.async {
                    self?.updateAllDynamicUI()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setValuesForAllTextViews(contact : Contact) {
        emailTextView.setValues(name: EDIT_TEXTFIELD_EMAIL, value: contact.email ?? "", isEditable: false)
        mobileTextView.setValues(name: EDIT_TEXTFIELD_MOBILE, value: contact.phone_number ?? "", isEditable: false)
    }
    
    func setValuesForAllCTAButtons(contact : Contact) {
        messageCTAButton.set(name: MESSAGE_CTA_TEXT, image: UIImage(named: MESSAGE_BUTTON_PHOTO)!)
        callCTAButton.set(name: CALL_CTA_TEXT, image: UIImage(named: CALL_BUTTON_PHOTO)!)
        emailCTAButton.set(name: EMAIL_CTA_TEXT, image: UIImage(named: EMAIL_BUTTON_PHOTO)!)
        favoriteCTAButton.set(name: FAVORITE_CTA_TEXT, image: contact.favorite ? UIImage(named: FAVORITE_SELECTED_BUTTON_PHOTO)! : UIImage(named: FAVORITE_BUTTON_PHOTO)!)
    }
    
    func updateAllDynamicUI() {
        setValuesForAllTextViews(contact: contact)
        setValuesForAllCTAButtons(contact: contact)
        profilePicImageView.setImageURL(string: contact.profile_pic, placeholder: UIImage(named: PLACEHOLDER_PHOTO))
        nameLabel.text = "\(contact.first_name) \(contact.last_name)"
    }
    
    @objc func editButtonTapped() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "ContactEditVC") as! ContactEditVC
        vc.set(contact: contact)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
