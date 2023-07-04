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
    private var completion: (() -> Void)?
    
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
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(mainImageViewTaped))
        recognizer.cancelsTouchesInView = true
        mainImageView.addGestureRecognizer(recognizer)
        mainImageView.isUserInteractionEnabled = true
        mainImageView.becomeFirstResponder()
    }
    
    override func prepareForReuse() {
        mainImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        completion = nil
    }
    
    func configure(image: UIImage?, name: String?, description: String?) {
        mainImageView.image = image
        nameLabel.text = name
        descriptionLabel.text = description
    }
    
    func configure(friend: Friend, completion: @escaping () -> Void) {
        nameLabel.text = friend.name
        mainImageView.image = UIImage(named: friend.avatar)
        descriptionLabel.text = String()
        self.completion = completion
    }
    
    func configure(group: Group, completion: @escaping () -> Void) {
        mainImageView.image = UIImage(named: group.avatar)
        nameLabel.text = group.name
        descriptionLabel.text = group.description
        self.completion = completion
    }
    
    @objc private func mainImageViewTaped() {
        print("mainImageViewTaped")
        let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
        mainImageView.transform = scale
        shadowView.transform = scale
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 50,
                       initialSpringVelocity: 30,
                       //options: nil, //[.autoreverse],
                       animations: {[weak self] in
            self?.mainImageView.transform = .identity
            self?.shadowView.transform = .identity
        },
                       completion: {[weak self] _ in
            self?.completion?()
        })
    }
}
