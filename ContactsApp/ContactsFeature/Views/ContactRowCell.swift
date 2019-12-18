//
//  ContactRowTableViewCell.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class ContactRowCell: UITableViewCell {
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isFavouriteImageView: UIImageView!
    var profilePicUrl : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValues(contact : Contact) {
        nameLabel.text = "\(contact.first_name) \(contact.last_name)"
        isFavouriteImageView.image = contact.favorite ? UIImage(named: "home_favourite") : nil
        self.profilePicUrl = contact.profile_pic
        self.profilePicImageView.image = UIImage(named: "placeholder_photo")
        if let urlString = contact.profile_pic {
            ImageDownloader.downloadImage(urlString: urlString) { [weak self] (result) in
                switch result {
                case .success(let image):
                    if (urlString == self?.profilePicUrl) { self?.profilePicImageView.image = image }
                case .failure(_):
                    break
                }
            }
        }
        
    }

}
