//
//  ContactEditVC.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ContactEditVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var firstNameTextField: ContactInfoTextField!
    @IBOutlet weak var lastNameTextField: ContactInfoTextField!
    @IBOutlet weak var mobileTextField: ContactInfoTextField!
    @IBOutlet weak var emailTextField: ContactInfoTextField!
    
    private var contact : Contact!
    private var contactsProvider = ContactsProvider.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureAllTextField()
        configureNavigationBar()
        configureTopView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setValuesForAllTextFields(contact: contact)
        profilePicImageView.setImageURL(string: contact.profile_pic, placeholder: UIImage(named: PLACEHOLDER_PHOTO))
    }
    
    // MARK: View configuration methods
    
    func configureNavigationBar() {
        self.title = ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: DONE_BAR_BUTTON_TEXT, style: .plain, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: CANCLE_BAR_BUTTON_TEXT, style: .plain, target: self, action: #selector(cancleButtonTapped))
        self.navigationController?.navigationBar.backgroundColor = AppTheme.BASE_COLOR_2
    }
    
    func configureAllTextField() {
        let textFields = [firstNameTextField,lastNameTextField,mobileTextField,emailTextField]
        for textField in textFields {
            textField?.valueTextField.delegate = self
        }
    }
    
    func configureTopView() {
        topView.applyGradient(colours: [AppTheme.BASE_COLOR_2,AppTheme.BASE_COLOR_1], locations: [0.0,1.0])
    }
    
    // MARK: UITextField Delegate methods
    
    // MARK: Helper methods
    
    @objc func doneButtonTapped() {
        do {
            try validateAllTextFields()
        } catch {
            print(error.localizedDescription)
            return 
        }
        
        updateContactModel()
        let completionHandler : (Result<Contact,AppError>) -> Void = {[weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                switch error {
                case .miscellaneous(let message):
                    print(message)
                case .networkError(let code, let message):
                    print(code, message)
                case .parsingError(let message):
                    print(message)
                case .unknown(let message):
                    print(message)
                }
            }
        }
        if let id = contact.id {
            contactsProvider.updateContact(for: id, contact: contact, onCompletion: completionHandler)
        } else {
            contactsProvider.addNewContact(contact: contact, onCompletion: completionHandler)
        }
        
    }
    
    public func updateContactModel() {
        contact.first_name = firstNameTextField.text ?? ""
        contact.last_name = lastNameTextField.text ?? ""
        contact.phone_number = mobileTextField.text ?? ""
        contact.email = emailTextField.text ?? ""
    }
    
    @objc func cancleButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateAllTextFields() throws {
        let textFields = [firstNameTextField,lastNameTextField,mobileTextField,emailTextField]
        for textField in textFields {
            if let valueTextfield = textField?.valueTextField {
                if valueTextfield.text == nil || valueTextfield.text == "" {
                    throw AppError.miscellaneous(message: "TextField is empty")
                }
            }
        }
    }
    
    func set(contact : Contact) {
        self.contact = contact
    }
    
    func setValuesForAllTextFields(contact : Contact) {
        firstNameTextField.setValues(name: EDIT_TEXTFIELD_FIRST_NAME, value: contact.first_name)
        lastNameTextField.setValues(name: EDIT_TEXTFIELD_LAST_NAME, value: contact.last_name)
        mobileTextField.setValues(name: EDIT_TEXTFIELD_MOBILE, value: contact.phone_number ?? "")
        emailTextField.setValues(name: EDIT_TEXTFIELD_EMAIL, value: contact.email ?? "")
    }

}
