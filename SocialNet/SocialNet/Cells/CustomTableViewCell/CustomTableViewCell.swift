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
    @IBOutlet weak var shadowView: UIView!
    
    static let customTableViewCellReuseIdentifier = "customTableViewCellReuseIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.layer.borderWidth = 2
        mainImageView.layer.borderColor = UIColor.systemBlue.cgColor
        mainImageView.layer.cornerRadius = mainImageView.frame.width/3
        shadowView.layer.cornerRadius = mainImageView.frame.width/3
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
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