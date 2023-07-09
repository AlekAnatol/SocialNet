//
//  PhotoControllerViewController.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 01.06.2023.
//

import UIKit

class PhotoController: UIViewController {

    //MARK: - Private properties
    
    private var images = [UIImage]()
    private var currentIndex = 0
    private var galleryHorizontalView = GalleryHorizontalView()
    
   //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    //MARK: - Open methods
    
    func configure(images: [UIImage], index: Int) {
        let galleryHorizontalView = GalleryHorizontalView(frame: CGRect(x: 0,
                                                  y: (self.view.bounds.height - self.view.bounds.width)/2  - 75,
                                                  width: self.view.bounds.width,
                                                  height: self.view.bounds.width))
        galleryHorizontalView.configure(images: images, index: index)
        self.view.addSubview(galleryHorizontalView)
    }
}
