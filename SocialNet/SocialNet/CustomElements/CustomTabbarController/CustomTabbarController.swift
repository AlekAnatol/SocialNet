//
//  CustomTabbarController.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 11.07.2023.
//

import UIKit

class CustomTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
    }
}

extension CustomTabbarController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimator(startFrame: CGRect(x: self.view.frame.midX - 50,
                                                        y: self.view.frame.midY - 50,
                                                        width: 100,
                                                        height: 100))
    }
}
