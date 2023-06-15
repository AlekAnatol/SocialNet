//
//  CustomCollectionViewCell.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 01.06.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    
    static let customCollectionViewCellReuseIdentifier = "customCollectionViewCellReuseIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        mainImageView.image = nil
    }
    
    func configure(image: String) {
        let image = UIImage(named: image)
        mainImageView.image = image
    }
}
