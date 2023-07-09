//
//  GalleryHorizontalView.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 09.07.2023.
//

import UIKit

class GalleryHorizontalView: UIView {
    
    //MARK: - Private properties
    
    var inactiveIndicatorColor: UIColor = UIColor.lightGray
    var activeIndicatorColor: UIColor = UIColor.systemBlue
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    var view = UIView()
    var mainImageView = UIImageView()
    var secondaryImageView = UIImageView()
    var images = [UIImage]()
    var isLeftSwipe = false
    var isRightSwipe = false
    var chooseFlag = false
    var currentIndex = 0
    var customPageView = UIPageControl()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - UI - setup
    
    private func setupView() {
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.addGestureRecognizer(recognizer)
        
        mainImageView.backgroundColor = UIColor.clear
        mainImageView.frame = self.bounds
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.masksToBounds = true
        self.addSubview(mainImageView)
        
        secondaryImageView.backgroundColor = UIColor.clear
        secondaryImageView.frame = self.bounds
        secondaryImageView.contentMode = .scaleAspectFill
        secondaryImageView.layer.masksToBounds = true
        secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        self.addSubview(secondaryImageView)
        
        customPageView.backgroundColor = UIColor.clear
        customPageView.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
        customPageView.layer.zPosition = 100
        customPageView.numberOfPages = 1
        customPageView.currentPage = 0
        customPageView.pageIndicatorTintColor = self.inactiveIndicatorColor
        customPageView.currentPageIndicatorTintColor = self.activeIndicatorColor
        self.addSubview(customPageView)
        
        customPageView.translatesAutoresizingMaskIntoConstraints = false
        customPageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        customPageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                               constant: customPageView.frame.height).isActive = true
    }
    
    //MARK: - Configure method
    
    func configure(images: [UIImage], index: Int) {
        self.images = images
        self.mainImageView.image = self.images[index]
        self.currentIndex = index
        customPageView.numberOfPages = self.images.count
        customPageView.currentPage = index
    }
    
    //MARK: - Animations methods
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        if let animator = interactiveAnimator,
           animator.isRunning { return }
        
        switch recognizer.state {
        case .began: touchBegan(recognizer)
        case .changed: touchMoves(recognizer)
        case .ended: touchEnded(recognizer)
        default: return
        }
    }
    
    private func touchBegan(_ recognizer: UIPanGestureRecognizer) {
        transformViewsToIdentity()
        
        self.mainImageView.image = images[currentIndex]
        self.bringSubviewToFront(self.mainImageView)
        
        interactiveAnimator?.startAnimation()
        let animation: (() -> Void)? = { [weak self] in
            self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width,
                                                              y: 0)
        }
        interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                     curve: .easeInOut,
                                                     animations: animation)
        interactiveAnimator.pauseAnimation()
        isLeftSwipe = false
        isRightSwipe = false
        chooseFlag = false
    }
    
    private func touchMoves(_ recognizer: UIPanGestureRecognizer) {
        var translation = recognizer.translation(in: self.view)
        
        if translation.x < 0 && (!isLeftSwipe) && (!chooseFlag) {
            if currentIndex == (images.count - 1) {
                interactiveAnimator.stopAnimation(true)
                return
            }
            chooseFlag = true
            isLeftSwipe = true
            onChange(isLeft: isLeftSwipe)
            
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.addAnimations { [weak self] in
                guard let self = self else { return }
                self.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                self.secondaryImageView.transform = .identity
            }
            interactiveAnimator.addCompletion({ [weak self] _ in
                guard let self = self else { return }
                self.onChangeCompletion(isLeft: self.isLeftSwipe)
            })
            
            interactiveAnimator.startAnimation()
            interactiveAnimator.pauseAnimation()
        }
        
        if translation.x > 0 && (!isRightSwipe) && (!chooseFlag) {
            if currentIndex == 0 {
                interactiveAnimator.stopAnimation(true)
                return
            }
            isRightSwipe = true
            chooseFlag = true
            onChange(isLeft: !isRightSwipe)
            
            interactiveAnimator.stopAnimation(true)
            
            interactiveAnimator.addAnimations { [weak self] in
                guard let self = self else { return }
                self.mainImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                self.secondaryImageView.transform = .identity
            }
            interactiveAnimator.addCompletion({ [weak self] _ in
                guard let self = self else { return }
                self.onChangeCompletion(isLeft: !self.isRightSwipe)
            })
            
            interactiveAnimator.startAnimation()
            interactiveAnimator.pauseAnimation()
        }
        
        if isRightSwipe && (translation.x < 0) { return }
        if isLeftSwipe && (translation.x > 0) { return }
        
        translation.x = translation.x < 0 ? -translation.x : translation.x
        interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width)
    }
    
    private func touchEnded(_ recognizer: UIPanGestureRecognizer) {
        if let animator = interactiveAnimator,
           animator.isRunning { return }
        
        var translation = recognizer.translation(in: self.view)

        translation.x = translation.x < 0 ? -translation.x : translation.x
        
        if (translation.x / (UIScreen.main.bounds.width)) > 0.5  {
            interactiveAnimator.startAnimation()
        } else {
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.finishAnimation(at: .start)
            interactiveAnimator.addAnimations { [weak self] in
                guard let self = self else { return }
                self.mainImageView.transform = .identity
                if self.isLeftSwipe {
                    self.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                }
                if self.isRightSwipe {
                    self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                }
            }
            interactiveAnimator.addCompletion({ [weak self] _ in
                guard let self = self else { return }
                self.transformViewsToIdentity()
            })
            interactiveAnimator.startAnimation()
        }
    }
    
    private func transformViewsToIdentity() {
        mainImageView.transform = .identity
        secondaryImageView.transform = .identity
    }
    
    private func onChange(isLeft: Bool) {
        transformViewsToIdentity()
        mainImageView.image = images[currentIndex]
        
        if isLeft {
            secondaryImageView.image = images[currentIndex + 1]
            secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        } else {
            secondaryImageView.image = images[currentIndex - 1]
            secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }
    }
    
    private func onChangeCompletion(isLeft: Bool) {
        transformViewsToIdentity()
        currentIndex = isLeft ? currentIndex + 1 : currentIndex - 1
        
        customPageView.currentPage = currentIndex
        mainImageView.image = images[currentIndex]
        bringSubviewToFront(mainImageView)
    }
}
