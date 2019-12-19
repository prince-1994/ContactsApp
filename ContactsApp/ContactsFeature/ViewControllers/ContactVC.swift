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
   
    var chars = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    var contactsProvider = ContactsProvider.shared
    var contactModels = [[Contact]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureTableView()
        configureAlphabetPageControl()
        configureNavigatioBar()
        configureForNotifications()
        if (contactModels == [[]]) { updateContacts() }
    }
    
    // MARK: Configuration methods
    
    func configureForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateContacts), name: NSNotification.Name(rawValue: CONTACTS_LOADED_SUCCESSFULLY), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(updateContacts), name: NSNotification.Name(rawValue: NEW_CONTACT_CREATED), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(updateContacts), name: NSNotification.Name(rawValue: CONTACT_UPDATED_SUCCESSFULLY), object: nil)
    }
    
    func configureActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.sectionHeaderHeight = 40 // UITableView.automaticDimension
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude

    }
    
    func configureAlphabetPageControl() {
        alphabetPageControl.addAphabets(chars: chars)
        alphabetPageControl.selectedIndex = 0
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // MARK: tableview delegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "ContactDetailsVC") as! ContactDetailsVC
        vc.set(contact: contactModels[indexPath.section][indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if tableView == scrollView {
            updateAlphabetPageControl()
        }
    }
    
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
            self?.contactModels.removeAll()
            for char in chars {
                self?.contactModels.append(dict[char]?.sorted(by: { (contact1, contact2) -> Bool in
                    contact1.first_name+contact1.last_name < contact2.first_name+contact2.last_name
                }) ?? [Contact]())
            }
            DispatchQueue.main.async {
                self?.updateCompleteUI()
            }
            
        }
    }
    
    @objc func addNewContact(notification : Notification) {
        guard let userInfo = notification.userInfo, let contact = try? JSONDecoder().decode(Contact.self, from: JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)) else { return }
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.insertNewContactIntoContactModels(contact: contact)
            DispatchQueue.main.async {
                self?.updateCompleteUI()
            }
        }
        
        
    }
    
    @objc func updateExistingContact(notification : Notification) {
        guard let userInfo = notification.userInfo, let contact = try? JSONDecoder().decode(Contact.self, from: JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)) else { return }
        guard let id = contact.id else { return }
        removeContactFromContactModels(contactId: id)
        insertNewContactIntoContactModels(contact: contact)
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.insertNewContactIntoContactModels(contact: contact)
            DispatchQueue.main.async {
                self?.updateCompleteUI()
            }
        }
    }
    
    func insertNewContactIntoContactModels(contact : Contact) {
        guard let firstChar = contact.first_name.first, let index = chars.firstIndex (where : { $0 == firstChar }) else { return }
        let insertionIndex = Utility.binarySearch(contactModels[index], contact) { (contact1, contact2) -> Int in
            let str1 = contact1.first_name + contact1.last_name
            let str2 = contact2.first_name + contact2.last_name
            if str1 < str2 { return -1 }
            else if str1 == str2 { return 0 }
            else { return 1 }
        }
        contactModels[index].insert(contact, at: insertionIndex)
    }
    
    func removeContactFromContactModels(contactId id : Int) {
        for i in 0..<contactModels.count {
            if let index = contactModels[i].firstIndex(where: { $0.id == id }) {
                contactModels[i].remove(at: index)
                break
            }
        }
    }
    
    @objc func openContactEditView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "ContactEditVC") as! ContactEditVC
        vc.set(contact: Contact(id: nil, first_name: "", last_name: "", phone_number: nil, email: nil, profile_pic: nil, favorite: false, url: ""))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateAlphabetPageControl() {
        if let cell = tableView.visibleCells.first, let indexPath = tableView.indexPath(for: cell) {
            alphabetPageControl.selectedIndex = indexPath.section
        }
    }
    
    func updateCompleteUI() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}
