//
//  GalleryController.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 13.04.2023.
//

import UIKit

class GalleryController: UIViewController {

    //MARK: - Private properties
    
    private var photosCollectionView: UICollectionView!
    private var photosArray = [String]()
    
    //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        setUpView()
    }

    //MARK: - UI - setup
    
    private func setUpView() {
        let collectionViewLayout = createCollectionViewLayout()
        photosCollectionView = {
            let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.customCollectionViewCellReuseIdentifier)
            collectionView.dataSource = self
            collectionView.delegate = self
            return collectionView
        }()
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(photosCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            photosCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: (view.bounds.width - 30)/3,
                                 height: (view.bounds.width - 30)/3)
        return layout
    }
    
    //MARK: - Open functions
    
    func configure(photos: [String]) {
        self.photosArray = photos
    }
}

//MARK: - UICollectionViewDataSource

extension GalleryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.customCollectionViewCellReuseIdentifier,
                                                            for: indexPath) as? CustomCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(image: photosArray[indexPath.item], likeCount: indexPath.item)
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate

extension GalleryController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected \(indexPath.item) item")
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
        print("Count of likes - \(selectedCell.likesCounterControlView.likesCounter)")
        let photoController = PhotoController()
        photoController.configure(photo: photosArray[indexPath.item])
        self.navigationController?.pushViewController(photoController, animated: true)
    }
}
