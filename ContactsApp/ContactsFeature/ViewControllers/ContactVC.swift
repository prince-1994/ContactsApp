//
//  ContactVC.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ContactVC: ContactAppBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alphabetPageControl: AlphabetPageControl!
   
    var chars = Array("ABCDEFGHIJKLMNOPQRSTUVXYZ")
    
    var contactsProvider = ContactsProvider.shared
    var contactModels = [[Contact]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateContacts), name: NSNotification.Name(rawValue: CONTACTS_LOADED_SUCCESSFULLY), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateContacts), name: NSNotification.Name(rawValue: NEW_CONTACT_CREATED), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateContacts), name: NSNotification.Name(rawValue: CONTACT_UPDATED_SUCCESSFULLY), object: nil)
        // Do any additional setup after loading the view.
        configureTableView()
        configureAlphabetPageControl()
        configureNavigatioBar()
        if (contactModels == [[]]) { updateContacts() }
    }
    
    func configureActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    func configureAlphabetPageControl() {
        alphabetPageControl.addAphabets(chars: chars)
    }
    
    func configureNavigatioBar() {
        self.title = CONTACT_SCREEN_TITLE
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(openContactEditView))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Groups", style: .plain, target: self, action: nil)
    }
    
    // MARK: tableview datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactRowCell") as! ContactRowCell
        cell.setValues(contact: contactModels[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: "ContactHeaderCell") as! ContactHeaderCell
        view.set(header: String(chars[section]))
        return view
    }
    
    // MARK: tableview delegate methods
    
    // MARK: helper methods
    
    @objc func updateContacts() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let allContacts = self?.contactsProvider.getAllContacts() else { return }
            var dict = [Character : [Contact]]()
            for contact in allContacts {
                if let firstChar = contact.first_name.first {
                    if dict[firstChar] == nil { dict[firstChar] = [Contact]() }
                    dict[firstChar]?.append(contact)
                }
            }
            guard let chars = self?.chars else { return }
            for char in chars {
                self?.contactModels.append(dict[char]?.sorted(by: { (contact1, contact2) -> Bool in
                    contact1.first_name+contact1.last_name < contact2.first_name+contact2.last_name
                }) ?? [Contact]())
            }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.75) {
                    self?.tableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
                
            }
        }
    }
    
    @objc func openContactEditView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "ContactEditVC") as! ContactEditVC
        vc.contact = Contact(id: nil, first_name: "", last_name: "", phone_number: nil, email: nil, profile_pic: nil, favorite: false, url: "")
        vc.contactsProvider = contactsProvider
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
