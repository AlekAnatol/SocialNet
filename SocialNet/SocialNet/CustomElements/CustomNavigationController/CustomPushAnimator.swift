//
//  CustomPushAnimator.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 11.07.2023.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        let containerViewFrame = transitionContext.containerView.frame
        let destinationViewTargetFrame = source.view.frame
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        destination.view.frame = CGRect(x: containerViewFrame.width,
                                        y: 0,
                                        width: containerViewFrame.height,
                                        height: containerViewFrame.width)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            destination.view.transform = .identity
            destination.view.frame = destinationViewTargetFrame
        } completion: { finished in
            transitionContext.completeTransition(finished)
        }
    }
}


