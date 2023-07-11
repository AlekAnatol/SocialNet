//
//  CustomCollectionViewCell.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 01.06.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var likesCounterControlView: LikesCounterControlView!
    
    static let customCollectionViewCellReuseIdentifier = "customCollectionViewCellReuseIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        mainImageView.image = nil
    }
    
    func configure(image: String, likeCount: Int) {
        let image = UIImage(named: image)
        mainImageView.image = image
        likesCounterControlView.configure(likeCount: likeCount)
    }
}
