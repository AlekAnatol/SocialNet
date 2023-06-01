//
//  CustomTableViewCell.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 21.05.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let customTableViewCellReuseIdentifier = "customTableViewCellReuseIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        mainImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func configure(image: UIImage?, name: String?, description: String?) {
        mainImageView.image = image
        nameLabel.text = name
        descriptionLabel.text = description
    }
    
    func configure(friend: Friend) {
        nameLabel.text = friend.name
        mainImageView.image = UIImage(named: friend.avatar)
        descriptionLabel.text = String()
    }
    
    func configure(group: Group) {
        mainImageView.image = UIImage(named: group.avatar)
        nameLabel.text = group.name
        descriptionLabel.text = group.description
    }
}
