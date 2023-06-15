//
//  LikesCounterControlView.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 14.06.2023.
//

import UIKit

@IBDesignable class LikesCounterControlView: UIView {
    
    //MARK: - Outlets
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    //MARK: - Private properties
    
    private var view: UIView! // основная view, на которую добавляются все остальные элементы
    private var isSelected: Bool = false
    
    //MARK: - Open roperties
    
    var likesCounter: Int = 0
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Private functions
    
    private func setup() {
        self.view = loadFromNib()
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(self.view)
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LikesCounterControlView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self).first as? UIView else { return UIView() }
        return view
    }
    
    private func heartButtonAnimate(image: UIImage?) {
        UIView.transition(with: heartButton,
                          duration: 1,
                          options: [.transitionFlipFromLeft], animations: {
            self.heartButton.setImage(image, for: .normal)
        },
                          completion: nil)
    }
    
    private func countLabelAnimate() {
        UIView.transition(with: countLabel,
                          duration: 1,
                          options: [.transitionFlipFromLeft], animations: {
            self.countLabel.text = String(self.likesCounter)
        },
                          completion: nil)
    }
    
    //MARK: - Open functions
    
    func configure(likeCount: Int) {
        self.likesCounter = likeCount
        countLabel.text = String(likesCounter)
    }
    
    //MARK: -  Actions
    
    @IBAction func heartButtonPressed(_ sender: Any) {
        print("heartButtonPressed")
        var image: UIImage?
        if isSelected {
            image = UIImage(systemName: "heart")
            likesCounter -= 1
        } else {
            image = UIImage(systemName: "heart.fill")
            likesCounter += 1
        }
        isSelected.toggle()
        countLabelAnimate()
        heartButtonAnimate(image: image)
    }
}

