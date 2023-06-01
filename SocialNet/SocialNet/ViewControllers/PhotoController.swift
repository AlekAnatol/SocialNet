//
//  PhotoControllerViewController.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 01.06.2023.
//

import UIKit

class PhotoController: UIViewController {
    
    //MARK: - Private properties
    
    private var photoImageView = UIImageView()
    private var photoName = String()

    //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo"
        view.backgroundColor = .white
        setUpView()
    }
    
    //MARK: - UI - setup
    
    private func setUpView() {
        photoImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: photoName)
            return imageView
        }()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            photoImageView.heightAnchor.constraint(equalToConstant: view.bounds.maxX - 20),
            ])
    }
    
    //MARK: - open functions
    
    func configure(photo: String) {
        self.photoName = photo
    }
}
